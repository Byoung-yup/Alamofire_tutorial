//
//  MySearchRouter.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/10.
//

import Foundation
import Alamofire

// 검색관련 api
enum MySearchRouter: URLRequestConvertible {
    
    case searchPhotos(term: String)
    case searchUsers(term: String)
    
    var baseURL: URL {
        return URL(string: API.BASIC_URL + "search/")!
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .searchPhotos, .searchUsers:
            return .get
        }
        
//        switch self {
//        case .searchPhotos:
//            return .get
//        case .searchUsers:
//            return .post
//        }
    }
    
    var endPoint: String {
        switch self {
        case .searchPhotos:
            return "photos/"
        case .searchUsers:
            return "users/"
        }
    }
    
    var parameters: [String : String] {
        
        switch self {
        case let .searchPhotos(term), let .searchUsers(term):
            return ["query" : term]
        }
            
    }
        
    
    func asURLRequest() throws -> URLRequest {
        
        print ("MySearchRouter - asURLRequest() called")
        
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        switch self {
//        case let .get(parameters):
//            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        case let .post(parameters):
//            request = try JSONParameterEncoder().encode(parameters, into: request)
//        }

        return request
    }
}
