//
//  MyAlamofireManager.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/10.
//

import Foundation
import Alamofire

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
}
