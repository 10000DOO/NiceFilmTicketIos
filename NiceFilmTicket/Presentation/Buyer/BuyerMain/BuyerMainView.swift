//
//  BuyerMainView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit
import SnapKit

class BuyerMainView: UIView {
    
    var logoImageView = UIImageView(image: UIImage(named: "Logo"))
    var searchTextField = UITextField()
    var listUpButton = UIButton(type: .system)
    var tableView = UITableView()
    var searchTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("BuyerMainView(coder:) has not been implemented")
    }
}

extension BuyerMainView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setLogo()
        setSearchTextField()
        setListUpButton()
        setTableView()
        setSearchTableView()
    }
    
    private func setLogo() {
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(50)
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
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
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
    
    private func setTableView() {
        tableView.separatorStyle = .none
        self.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(listUpButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    
    private func setSearchTableView() {
        searchTableView.separatorStyle = .none
        self.addSubview(searchTableView)

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(listUpButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
}
