//
//  FindIdView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import UIKit
import SnapKit

class FindIdView: UIView {

    var logoImageView = UIImageView()
    var titleLabel = MenuUILabel(text: "아이디 찾기", size: UIFont.boldSystemFont(ofSize: 25))
    var emailTextField = AuthenticationTextField(placeholder: "  이메일", isSecureTextEntry: false, backgroundColor: .white, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    var emailSendButton = AuthenticationUIButton(title: "인증코드 전송", isHidden: false)
    var emailCodeTextField = AuthenticationTextField(placeholder: "  인증코드", isSecureTextEntry: false, backgroundColor: .white, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    var errorLabel = UILabel()
    var checkButton = AuthenticationUIButton(title: "확인요청", isHidden: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("FindIdView(coder:) has not been implemented")
    }
}

extension FindIdView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setLogo()
        setTitleLabel()
        setEmailTextField()
        setEmailCodeTextField()
        setErrorLabel()
        setEmailSendButton()
        setCheckButton()
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
    
    func setEmailTextField() {
        self.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    func setEmailCodeTextField() {
        self.addSubview(emailCodeTextField)
        
        emailCodeTextField.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
    func setErrorLabel() {
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(25)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.top.equalTo(emailCodeTextField.snp.bottom).offset(5)
        }
    }
    
    func setEmailSendButton() {
        self.addSubview(emailSendButton)
        
        emailSendButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    func setCheckButton() {
        self.addSubview(checkButton)
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(emailSendButton.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
    }
}
