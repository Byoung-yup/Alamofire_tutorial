//
//  BaseVC.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/07.
//

import UIKit
import Toast_Swift

class BaseVC: UIViewController {
    
    var vcTitle: String = "" {
        didSet {
            self.title = vcTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 인증 실패 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notication:)), name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTO_FAIL), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 인증 실패 노티피케이션 등록 해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTO_FAIL), object: nil)
    }
    
    // MARK: - objc methods
    
    @objc func showErrorPopup(notication: NSNotification) {
        print("BaseVC - showErrorPopup() called")
        
        if let data = notication.userInfo?["statusCode"] {
            print("showErrorPopup() data: \(data)")
            
            // 메인 스레드에서 돌리기 즉 UI 스레드
            DispatchQueue.main.async {
                self.view.makeToast("☠️ \(data) 에러 입니다.", duration: 1.0, position: .center)
            }
        }
    }
}
