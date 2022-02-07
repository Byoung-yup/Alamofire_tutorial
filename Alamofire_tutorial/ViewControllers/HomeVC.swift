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

class HomeVC: UIViewController {
    let url = API.BASIC_URL + "search/photos"
    
    var mainContainerView: MainContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 키보드 올라가는 이벤트를 받는 처리
        // 키보드 노티 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 키보드 노티 등록 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        self.mainContainerView.searchBar.resignFirstResponder() // 포커싱 해제
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mainContainerView.searchBar.becomeFirstResponder()
    }
    
    func setUpUI() {
        self.mainContainerView = MainContainer()
        mainContainerView.delegate = self
        self.view.addSubview(mainContainerView)
        mainContainerView.snp.makeConstraints{ make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    // MARK: - prepare methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userInputValue = self.mainContainerView.searchBar.text else { return }
        
        switch (segue.identifier) {
        case SEGUE_ID.USER_LIST_VC:
            let nextVC = segue.destination as! UserListVC
            nextVC.vcTitle = userInputValue + " 🧑‍🦲"
        default :
            break
        }
    }
    
    // MARK: - objc methods
    @objc func keyboardWillShowHandle(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboard.origin.y: \(keyboardSize.origin.y)")
            print("searchBtn.frame.origin.y: \(self.mainContainerView.searchBtn.frame.origin.y)")
            print("mainphotoView.frame.origin.y: \(self.mainContainerView.mainPhotoView.frame.origin.y)")
            if (keyboardSize.origin.y < self.mainContainerView.searchBtn.frame.origin.y) {
                let distance = keyboardSize.origin.y - self.mainContainerView.searchBtn.frame.origin.y
                print("distance: \(distance)")
                self.view.frame.origin.y = distance
            }
        }
    }
    
    @objc func keyboardWillHideHandle(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

// MARK: - identifier Delegate method
extension HomeVC: identifierDelegate {
    func searchButton(identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: self)
    }
}

