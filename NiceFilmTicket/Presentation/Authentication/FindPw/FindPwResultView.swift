//
//  FindPwResultView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/11/23.
//

import UIKit
import SnapKit

class FindPwResultView: UIView {
    var logoImageView = UIImageView()
    var titleLabel = MenuUILabel(text: "비밀번호 찾기", size: UIFont.boldSystemFont(ofSize: 25))
    var borderView = UIView()
    var explanation = UILabel()
    var idLabel = UILabel()
    var gotoLoginButton = AuthenticationUIButton(title: "로그인하러 가기", isHidden: false)
    var findPwButton = AuthenticationUIButton(title: "비밀번호 찾기", isHidden: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("FindIdView(coder:) has not been implemented")
    }
}

extension FindPwResultView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setLogo()
        setTitleLabel()
        setBorderView()
        setExplanation()
        setIdLabel()
        setFindPwButton()
        setGotoLoginButton()
    }
    
    func setLogo() {
        logoImageView = UIImageView(image: UIImage(named: "Logo"))
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.top).offset(170)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(210)
            make.height.equalTo(150)
        }
    }
    
    func setTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
        }
    }
    
    func setBorderView() {
        borderView.layer.borderWidth = 2
        borderView.layer.cornerRadius = 20
        borderView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        borderView.backgroundColor = .clear
        self.addSubview(borderView)
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }
    }
    func setExplanation() {
        explanation.text = "아이디를 찾았습니다!"
        explanation.textColor = .gray
        explanation.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(explanation)
        
        explanation.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    func setIdLabel() {
        idLabel.font = UIFont.boldSystemFont(ofSize: 30)
        idLabel.numberOfLines = 0
        idLabel.textAlignment = .center
        self.addSubview(idLabel)
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(explanation.snp.top).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    
    func setFindPwButton() {
        self.addSubview(findPwButton)
        
        findPwButton.snp.makeConstraints { make in
            make.bottom.equalTo(borderView.snp.bottom).offset(-50)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    
    func setGotoLoginButton() {
        self.addSubview(gotoLoginButton)
        
        gotoLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(findPwButton.snp.top).offset(-50)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
}
