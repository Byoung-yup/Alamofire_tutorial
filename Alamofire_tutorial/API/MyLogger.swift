//
//  MyLogger.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/10.
//

import Foundation
import Alamofire

final class MyLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "ApiLog")
    
    func requestDidResume(_ request: Request) {
        print("MyLogger = requestDidResume()")
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("MyLogger = request.didParseResponse()")
        debugPrint(request)
    }
}
