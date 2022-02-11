//
//  Photo.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/11.
//

import Foundation

struct Photo: Codable {
    var thumbnail: String
    var username: String
    var likesCount: Int
    var createAt: String
}
