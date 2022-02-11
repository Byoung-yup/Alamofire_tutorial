//
//  MainContainer.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/03.
//

import UIKit
import Toast_Swift
import Alamofire

protocol identifierDelegate {
    func searchButton(identifier: String)
}

class MainContainer: UIView {
    
    var delegate: identifierDelegate!
    
    var keyboardDismissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    var mainPhotoView: UIImageView = {
        let imgV = UIImageView()
        imgV.clipsToBounds = true
        imgV.layer.cornerRadius = 15
        imgV.sizeToFit()
        imgV.image = UIImage(named: "mainPhoto")
        return imgV
    }()
    
    var sgControl: UISegmentedControl = {
        let sg = UISegmentedControl(items: ["사진검색", "사용자검색"])
        sg.addTarget(self, action: #selector(clickedSegmentControl(_:)), for: .valueChanged)
        sg.selectedSegmentIndex = 0
        sg.tintColor = .white
        sg.selectedSegmentTintColor = .systemPink
        return sg
    }()
    
    var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.placeholder = "사진 키워드 입력"
        return sb
    }()

    var searchBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("검색하기", for: .normal)
        btn.addTarget(self, action: #selector(onSearchButtonClicked(_:)), for: .touchUpInside)
        btn.backgroundColor = .red
        btn.tintColor  = .white
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 10
        //btn.isHidden = true
        return btn
    }()
    
    var indicatorView: UIActivityIndicatorView = {
        let indiView = UIActivityIndicatorView(style: .medium)
        indiView.startAnimating()
        indiView.isHidden = true
        return indiView
    }()
    
    //MARK: - override methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
        self.setUpUI()
        self.setDelegate()
        self.addGestureRecognizer(keyboardDismissTabGesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - loadXib method
    func loadXib() {
        if let nib = Bundle.main.loadNibNamed("MainContainer", owner: self, options: nil)?.first as? UIView {
            nib.frame = self.bounds
            self.addSubview(nib)
        }
    }
    
    // MARK: - set Delegate
    func setDelegate() {
        self.searchBar.delegate = self
        self.keyboardDismissTabGesture.delegate = self
    }
    
    // MARK: - setUpUI method
    func setUpUI() {
        self.addSubview(self.mainPhotoView)
        self.mainPhotoView.snp.makeConstraints{ make in
            make.top.equalTo(self.snp.top).offset(150)
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(100)
        }
        
        self.addSubview(self.sgControl)
        self.sgControl.snp.makeConstraints{ make in
            make.top.equalTo(mainPhotoView.snp.bottom).offset(30)
            make.centerX.equalTo(mainPhotoView.snp.centerX)
            make.width.equalTo(200)
        }
        
        self.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints{ make in
            make.top.equalTo(sgControl.snp.bottom).offset(30)
            make.centerX.equalTo(sgControl.snp.centerX)
            make.width.equalTo(300)
        }
        
        self.addSubview(self.searchBtn)
        self.searchBtn.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.centerX.equalTo(searchBar.snp.centerX)
            make.width.equalTo(70)
        }
        
        self.addSubview(self.indicatorView)
        self.indicatorView.snp.makeConstraints{ make in
            make.centerX.equalTo(searchBtn.snp.centerX)
            make.centerY.equalTo(searchBtn.snp.centerY)
        }
    }
     
    //MARK: - objc methods
    @objc func clickedSegmentControl(_ sender: UISegmentedControl) {
        var btnTitle : String = ""
        
        switch sender.selectedSegmentIndex {
        case 0:
            btnTitle = "사진 키워드"
        case 1:
            btnTitle = "사용자 이름"
        default :
            break
        }
        
        self.searchBar.placeholder = btnTitle + " 입력"
    }
    
    @objc func onSearchButtonClicked( _ sender: UIButton) {
        
//        let url = API.BASIC_URL + "search/photos"
        
        guard let userInput = self.searchBar.text else { return }
        
        // 키, 벨류 형식의 딕셔너리
//        let queryParam : [String : String] = [
//            "query" : userInput,
//            "client_id" : API.CLIENT_ID
//        ]
        
        /*
        AF.request(url, method: .get, parameters: queryParam, encoding: URLEncoding.default).responseJSON { data in
            debugPrint(data)
         */
        
        //var urlToCall: URLRequestConvertible?
        
        switch sgControl.selectedSegmentIndex {
        case 0:
            //let urlToCall = MySearchRouter.searchPhotos(term: userInput)
            
            MyAlamofireManager
                .shared
                .getPhotos(searchTerm: userInput) { [weak self] result in
                    
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let fetchedPhotos):
                        print("HomeVC - getPhotos.success - fetchedPhotos.count: \(fetchedPhotos.count)")
                        self.pushVC()
                    case .failure(let error):
                        print("HomeVC - getPhtos.failure - error: \(error.rawValue)")
                        self.makeToast("\(error.rawValue)", duration: 1.0, position: .center)
                }
            }
        //case 1:
            //let urlToCall = MySearchRouter.searchUsers(term: userInput)
        default :
            break
            
        }
        
//        if let urlConvertible = urlToCall {
//            MyAlamofireManager
//                .shared
//                .session
//                .request(urlConvertible)
//                .validate(statusCode: 200..<401)
//                .responseJSON(completionHandler: { response in
//                    debugPrint(response)
//                })
//        }
        
//        if (!userInput.isEmpty) {
//            self.pushVC()
//        }
        //self.pushVC()
    }
    
    // MARK: - fileprivate methods
    fileprivate func pushVC() {
        var segueID: String = ""
        
        switch sgControl.selectedSegmentIndex {
        case 0:
            segueID = "goToPhotoCollectionVC"
        case 1:
            segueID = "goToUserListVC"
        default :
            break
        }
        self.delegate.searchButton(identifier: segueID)
    }
}


// MARK: - UISearchBar Delegate methods
extension MainContainer: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            //self.searchBtn.isHidden = true
        } else {
            self.searchBtn.isHidden = false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputText = searchBar.text?.appending(text).count ?? 0
        
        if (inputText >= 12) {
            self.makeToast("📢 12자 까지만 입력가능합니다.", duration: 1.0, position: .center)
        }
        
        return inputText <= 12 ? true : false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userInputText = self.searchBar.text else { return }
         
        if (!userInputText.isEmpty) {
            self.pushVC()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MainContainer: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sgControl) == true) {
            return false
        } else if (touch.view?.isDescendant(of: self.searchBar) == true) {
            return false
        } else if (touch.view?.isDescendant(of: self.searchBtn) == true) {
            return false
        }
        self.endEditing(true)
        return true
    }
}
