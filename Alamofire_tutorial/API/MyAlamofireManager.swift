//
//  MyAlamofireManager.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/10.
//

import Foundation
import Alamofire
import SwiftyJSON

final class MyAlamofireManager {
    
    // 싱글턴 적용
    static let shared = MyAlamofireManager()
    
    // 인터셉터
    let intercepters = Interceptor(interceptors:
                        [
                            BaseInterceptor()
                        ])
    
    // 로거 설정
    let momitors = [MyLogger()]
    
    // 세션 설정
    var session : Session
    
    private init() {
        session = Session(
            interceptor: intercepters,
            eventMonitors: momitors)
    }
    
    func getPhotos(searchTerm userInput: String, completion: @escaping (Result<[Photo], MyError>) -> Void) {
        
        print("MyAlamofireManager getPhotos() called: \(userInput)")
        
        self.session
            .request(MySearchRouter.searchPhotos(term: userInput))
            .validate(statusCode: 200..<401)
            .responseJSON(completionHandler: { response in
                
                guard let responseValue = response.value else { return }
                
                let responseJSON = JSON(responseValue)
                
                let jsonArray = responseJSON["results"]
                
                var photos = [Photo]()
                
                print("jsonArray.size: \(jsonArray.count))")
                
                for (index, subJson): (String, JSON) in jsonArray {
                    //print("index: \(index), subJson: \(subJson)")
                    
                    // 데이터 파싱
//                    let thumbnail  = subJson["urls"]["thumb"].string ?? ""
//                    let username   = subJson["user"]["username"].string ?? ""
//                    let likesCount = subJson["likes"].intValue ?? 0
//                    let createAt   = subJson["created_at"].string
                    
                    guard let thumbnail  = subJson["urls"]["thumb"].string,
                          let username   = subJson["user"]["username"].string,
                          let createAt   = subJson["created_at"].string else { return }
                    
                    let likesCount = subJson["likes"].intValue
                    
                 let photoItem = Photo(thumbnail: thumbnail, username: username, likesCount: likesCount, createAt: createAt)
                    // 배열에 넣고
                    photos.append(photoItem)
                    print("photos item: \(photos)")
                }
                
                if photos.count > 0 {
                    completion(.success(photos))
                } else {
                    completion(.failure(.noContent))
                }
            })
    }
}
