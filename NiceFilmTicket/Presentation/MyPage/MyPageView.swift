//
//  MyPageView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/7/23.
//

import UIKit
import SnapKit

class MyPageView: UIView {
    
    var logoImageView = UIImageView(image: UIImage(named: "Logo"))
    var titleLabel = UILabel()
    var normalNft = UILabel()
    var rareNft = UILabel()
    var legendNft = UILabel()
    var normalCount = UILabel()
    var rareCount = UILabel()
    var legendCount = UILabel()
    var searchTextField = UITextField()
    var listUpButton = UIButton(type: .system)
    var tableView = UITableView()
    var searchTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("MyPageView(coder:) has not been implemented")
    }
}

extension MyPageView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setLogo()
        setTitleLabel()
        setSearchTextField()
        setListUpButton()
        setNormalNft()
        setRareNft()
        setLegendNft()
        setNormalCount()
        setRareCount()
        setLegendCount()
        setTableView()
        setSearchTableView()
    }
    
    private func setLogo() {
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(85)
        }
    }
    
    private func setTitleLabel() {
        titleLabel.text = "보유 NFT"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .gray
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setSearchTextField() {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.tintColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        
        let paddingView = UIView()
        paddingView.addSubview(imageView)
        
        paddingView.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(paddingView.snp.top).inset(5)
            make.leading.equalTo(paddingView.snp.leading).inset(10)
        }
        
        imageView.isUserInteractionEnabled = false
        paddingView.isUserInteractionEnabled = false
        
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.borderWidth = 2
        searchTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        self.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
    
    private func setListUpButton() {
        let config = UIButton.Configuration.plain()
        listUpButton = UIButton(configuration: config)
        listUpButton.tintColor = UIColor(red: 8/255, green: 30/255, blue: 92/255,alpha: 1)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor(red: 8/255, green: 30/255, blue: 92/255,alpha: 1)
        ]
        
        let attributedTitle = NSAttributedString(string: "정렬조건", attributes :attributes)
        
        listUpButton.setAttributedTitle(attributedTitle, for:.normal)
        
        self.addSubview(listUpButton)
        
        listUpButton.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.trailing).offset(-5)
            make.centerY.equalTo(searchTextField.snp.centerY)
        }
    }
    
    private func setNormalNft() {
        normalNft.text = "NORMAL"
        normalNft.font = .boldSystemFont(ofSize: 15)
        normalNft.textColor = UIColor(red: 50/255, green: 173/255, blue: 230/255, alpha: 1)
        self.addSubview(normalNft)
        
        normalNft.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.5)
        }
    }
    
    private func setRareNft() {
        rareNft.text = "RARE"
        rareNft.font = .boldSystemFont(ofSize: 15)
        rareNft.textColor = .green
        self.addSubview(rareNft)
        
        rareNft.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setLegendNft() {
        legendNft.text = "LEGEND"
        legendNft.font = .boldSystemFont(ofSize: 15)
        legendNft.textColor = .red
        self.addSubview(legendNft)
        
        legendNft.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.5)
        }
    }
    
    private func setNormalCount() {
        normalCount.text = "3"
        normalCount.font = .boldSystemFont(ofSize: 15)
        self.addSubview(normalCount)
        
        normalCount.snp.makeConstraints { make in
            make.top.equalTo(normalNft.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.5)
        }
    }
    
    private func setRareCount() {
        rareCount.text = "3"
        rareCount.font = .boldSystemFont(ofSize: 15)
        self.addSubview(rareCount)
        
        rareCount.snp.makeConstraints { make in
            make.top.equalTo(rareNft.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setLegendCount() {
        legendCount.text = "3"
        legendCount.font = .boldSystemFont(ofSize: 15)
        self.addSubview(legendCount)
        
        legendCount.snp.makeConstraints { make in
            make.top.equalTo(legendNft.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.5)
        }
    }
    
    private func setTableView() {
        tableView.separatorStyle = .none
        self.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(rareCount.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    
    private func setSearchTableView() {
        searchTableView.separatorStyle = .none
        self.addSubview(searchTableView)

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(rareCount.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
}
