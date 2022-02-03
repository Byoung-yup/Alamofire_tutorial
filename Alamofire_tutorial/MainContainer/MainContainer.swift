//
//  MainContainer.swift
//  Alamofire_tutorial
//
//  Created by 김병엽 on 2022/02/03.
//

import UIKit

class MainContainer: UIView {
    
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
        btn.backgroundColor = .red
        btn.tintColor  = .white
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 10
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
    
    // MARK: - setUpUI method
    func setUpUI() {
        self.addSubview(self.mainPhotoView)
        self.mainPhotoView.snp.makeConstraints{ make in
            make.top.equalTo(self.snp.top)
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
            make.width.equalTo(250)
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
        self.searchBar.becomeFirstResponder() // 포커싱 설정
    }
}
