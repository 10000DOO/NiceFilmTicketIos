//
//  SignUpViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/26.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    lazy var logoImageView = UIImageView()
    lazy var signUpText = UILabel()
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var emailCodeSendingButton = UIButton()
    lazy var emailTextField = UITextField()
    lazy var idTextField = UITextField()
    lazy var pwTextField = UITextField()
    lazy var pwCheckTextField = UITextField()
    lazy var nickNameTextField = UITextField()
    lazy var signupButton = UIButton()
    lazy var emailCodeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //뒤로가기 제스쳐는 살리고 백버튼 지우기
        self.navigationController?.navigationBar.isHidden = true
        
        configureLogoImageView()
        signUpLabel()
        configureScrollView(menu: signUpText)
        sendEmailButton()
        emailTextFieldFunc()
        emailCodeTextFieldFunc()
        idTextFieldFunc()
        passwordTextField()
        passwordCheckTextField()
        nickNameTextFieldFunc()
        authTextField()
        
        hideKeyboardWhenTappedAround()
    }
}

extension SignUpViewController {
    //키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthenticationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //로고 만들기
    private func configureLogoImageView() {
        logoImageView = UIImageView(image: UIImage(named: "Logo"))
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.top).offset(170)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(210)
            make.height.equalTo(150)
        }
    }
    
    private func signUpLabel() {
        // 회원가입 텍스트 레이블 생성
        signUpText = MenuUILabel(text: "회원가입", size: UIFont.boldSystemFont(ofSize: 25))
        view.addSubview(signUpText)
        
        // 회원가입 텍스트 제약 조건
        signUpText.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
        }
    }
    
    // 스크롤뷰 설정
    private func configureScrollView(menu: UILabel) {
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(menu.snp.bottom).offset(20)// logoImageView 아래에서 시작
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width)
        }
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(530)
        }
    }
    
    private func sendEmailButton() {
        //인증번호 발송 버튼
        emailCodeSendingButton = AuthenticationUIButton(title: "인증번호 발송", isHidden: false)
        //signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside) //회원가입 버튼 눌렀을 때
        emailCodeSendingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        contentView.addSubview(emailCodeSendingButton)
        
        emailCodeSendingButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    private func emailTextFieldFunc() {
        //이메일 입력 텍스트 필드
        emailTextField = AuthenticationTextField(placeholder: "  이메일", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(emailTextField)

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(emailCodeSendingButton.snp.leading).offset(-20)
        }
    }
    
    private func emailCodeTextFieldFunc() {
        //이메일 코드 입력 텍스트 필드
        emailCodeTextField = AuthenticationTextField(placeholder: "  이메일 인증 코드", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(emailCodeTextField)

        emailCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }

    private func idTextFieldFunc() {
        //아이디 입력 텍스트 필드
        idTextField = AuthenticationTextField(placeholder: "  아이디", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(idTextField)

        idTextField.snp.makeConstraints { make in
            make.top.equalTo(emailCodeTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }

    private func passwordTextField() {
        //비밀번호 입력 텍스트 필드
        pwTextField = AuthenticationTextField(placeholder: "  비밀번호", isSecureTextEntry: true, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(pwTextField)

        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }

    private func passwordCheckTextField() {
        //비밀번호 확인 입력 텍스트 필드
        pwCheckTextField = AuthenticationTextField(placeholder: "  비밀번호 확인", isSecureTextEntry: true, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(pwCheckTextField)

        pwCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }

    private func nickNameTextFieldFunc() {
        //닉네임 입력 텍스트 필드
        nickNameTextField = AuthenticationTextField(placeholder: "  닉네임", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(nickNameTextField)

        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(pwCheckTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }

    private func authTextField() {
        //회원가입 버튼
        signupButton = AuthenticationUIButton(title: "Make Account", isHidden: false)
        //signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside) //회원가입 버튼 눌렀을 때
        contentView.addSubview(signupButton)

        signupButton.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(30)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
    }
}
