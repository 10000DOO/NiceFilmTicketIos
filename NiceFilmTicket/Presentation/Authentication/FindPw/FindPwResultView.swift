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
    var pwTextField = AuthenticationTextField(placeholder: "  비밀번호", isSecureTextEntry: false, backgroundColor: .white, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    var pwCheckTextField = AuthenticationTextField(placeholder: "  비밀번호 확인", isSecureTextEntry: false, backgroundColor: .white, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    var errorLabel = UILabel()
    var findPwButton = AuthenticationUIButton(title: "비밀번호 재설정", isHidden: false)
    
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
        setPwTextField()
        setPwCheckTextField()
        setErrorLabel()
        setFindPwButton()
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
    func setPwTextField() {
        pwTextField.isSecureTextEntry = true
        self.addSubview(pwTextField)
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.top).offset(50)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
    }
    
    func setPwCheckTextField() {
        pwCheckTextField.isSecureTextEntry = true
        self.addSubview(pwCheckTextField)
        
        pwCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
    }
    
    func setErrorLabel() {
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        self.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(pwCheckTextField.snp.bottom).offset(10)
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
}
