//
//  PublisherMainPageView.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/12.
//

import UIKit
import SnapKit

class PublisherMainView: UIView {
    
    var logoImageView = UIImageView()
    var viewTitle = MenuUILabel(text: "[  NFT 등록 목록  ]", size: UIFont.boldSystemFont(ofSize: 40))
    //var tableView = UITableView()
    var nftNum = UILabel()
    var movieTitle = UILabel()
    var moviePrice = UILabel()
    var salePeriod = UILabel()
    var nftStock = UILabel()
    var lineView = UIView()
    var registerButton = AuthenticationUIButton(title: "NFT 등록하기", isHidden: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("PublisherMainView(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension PublisherMainView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setLogo()
        setTitle()
        setNftNum()
        setNftStock()
        setMoviePrice()
        setSalePeriod()
        setMovieTitle()
        setDividLine()
        setRegisterButton()
        //setupTableView()
    }
    
    private func setLogo() {
        logoImageView = UIImageView(image: UIImage(named: "Logo"))
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(120)
            make.height.equalTo(60)
        }
    }
    
    private func setTitle() {
        self.addSubview(viewTitle)
        
        viewTitle.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setNftNum() {
        nftNum.text = "No"
        nftNum.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(nftNum)
        
        nftNum.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(30)
            make.leading.equalTo(self.snp.leading).inset(5)
        }
    }
    
    private func setNftStock() {
        nftStock.text = "판매수량"
        nftStock.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(nftStock)
        
        nftStock.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(30)
            make.trailing.equalTo(self.snp.trailing).inset(5)
        }
    }
    
    private func setMoviePrice() {
        moviePrice.text = "금액"
        moviePrice.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(moviePrice)
        
        moviePrice.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(30)
            make.centerX.equalTo(self.snp.centerX).offset(-35)
        }
    }
    
    private func setSalePeriod() {
        salePeriod.text = "판매기간"
        salePeriod.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(salePeriod)
        
        salePeriod.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(30)
            make.leading.equalTo(moviePrice.snp.trailing).offset(35)
        }
    }
    
    private func setMovieTitle() {
        movieTitle.text = "영화명"
        movieTitle.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(movieTitle)
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(viewTitle.snp.bottom).offset(30)
            make.trailing.equalTo(moviePrice.snp.leading).offset(-35)
        }
    }
    
    private func setDividLine() {
        lineView.backgroundColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        self.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nftStock.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    private func setRegisterButton() {
        self.addSubview(registerButton)

        registerButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).inset(100)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    
//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        self.addSubview(tableView)
//
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(viewTitle.snp.bottom).offset(30) // viewTitle 밑에 추가
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//
//    }
}

//extension PublisherMainView: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10 // 예시: 10개의 행
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Row \(indexPath.row)"
//        return cell
//    }
//}
