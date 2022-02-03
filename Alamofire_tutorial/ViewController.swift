//
//  ViewController.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/01/28.
//  Reference: 유튜브 정대리

import UIKit
import Alamofire
import SnapKit
import Toast_Swift

class ViewController: UIViewController {
    let url = API.BASIC_URL + "search/photos"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    
    func setUpUI() {
        let mainContainerView = MainContainer()
        self.view.addSubview(mainContainerView)
        mainContainerView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.snp.top).offset(200)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    
}

