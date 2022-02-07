//
//  BaseVC.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/07.
//

import UIKit

class BaseVC: UIViewController {
    
    var vcTitle: String = "" {
        didSet {
            self.title = vcTitle
        }
    }
}
