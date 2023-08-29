//
//  SignUpViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/26.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    //leading쪽 공간 확보를 위한 뷰
    var leadingSpace: UIView{
        let view = UIView()
        view.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(70)
        }
        return view
    }
    lazy var logoImageView = UIImageView()
    lazy var signUpText = UILabel()
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIStackView()
    lazy var emailStackView = UIStackView()
    lazy var emailTextField = UITextField()
    lazy var emailCodeSendingButton = UIButton()
    lazy var emailCodeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //뒤로가기 제스쳐는 살리고 백버튼 지우기
        self.navigationController?.navigationBar.isHidden = true
        
        configureLogoImageView()
        signUpLabel()
        configureScrollView(menu: signUpText)
        configureStackView()
        emailTextFieldFunc(errorHidden: true)
        //이메일 코드 입력 텍스트 필드
        configTextFieldFunc(ui: AuthenticationTextField(placeholder: "  이메일 인증 코드", isSecureTextEntry: false, backgroundColor: .clear, isHidden: true, font: UIFont.systemFont(ofSize: 20)), errorHidden: true)
        //아이디 입력 텍스트 필드
        configTextFieldFunc(ui: AuthenticationTextField(placeholder: "  아이디", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20)), errorHidden: true)
        //비밀번호 입력 텍스트 필드
        configTextFieldFunc(ui: AuthenticationTextField(placeholder: "  비밀번호", isSecureTextEntry: true, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20)), errorHidden: true)
        //비밀번호 확인 입력 텍스트 필드
        configTextFieldFunc(ui: AuthenticationTextField(placeholder: "  비밀번호 확인", isSecureTextEntry: true, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20)), errorHidden: true)
        //닉네임 입력 텍스트 필드
        configTextFieldFunc(ui: AuthenticationTextField(placeholder: "  닉네임", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20)), errorHidden: true)
        
        configSignUpButton(ui: AuthenticationUIButton(title: "Make Account", isHidden: false))
        
        
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
    }
    
    //스택 뷰 설정
    private func configureStackView() {
        contentView.axis = .vertical
        contentView.spacing = 20
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.trailing.equalTo(scrollView.frameLayoutGuide).inset(30)
        }
    }
    
    private func emailTextFieldFunc(errorHidden: Bool) {
        emailStackView.axis = .horizontal
        emailStackView.spacing = 10
        
        if errorHidden {
            leadingSpace.snp.updateConstraints { make in
                make.height.equalTo(50)
            }
            emailStackView.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        } else {
            leadingSpace.snp.updateConstraints { make in
                make.height.equalTo(70)
            }
            emailStackView.snp.makeConstraints { make in
                make.height.equalTo(70)
            }
        }
        
        let includeValidationStackView = UIStackView()
        includeValidationStackView.axis = .vertical
        
        let errorLabel: UILabel = {
            let label = UILabel()
            label.text = "에러"
            label.textColor = .red
            return label
        }()
        errorLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        let includeValidationStackView2 = UIStackView()
        includeValidationStackView2.axis = .vertical
        
        let errorLabel2: UILabel = {
            let label = UILabel()
            label.text = ""
            return label
        }()
        
        errorLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        
        // 이메일 입력 텍스트 필드 설정
        emailTextField = AuthenticationTextField(placeholder: "  이메일", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        // 인증번호 발송 버튼 설정
        emailCodeSendingButton = AuthenticationUIButton(title: "인증번호 발송", isHidden: false)
        emailCodeSendingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        emailCodeSendingButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        contentView.addArrangedSubview(emailStackView)
        
        // 이메일 필드와 에러 레이블을 vertical stack view에 추가
        includeValidationStackView.addArrangedSubview(emailTextField)
        
        if !errorHidden {
            includeValidationStackView.addArrangedSubview(errorLabel)
        }
        
        includeValidationStackView2.addArrangedSubview(emailCodeSendingButton)
        
        if !errorHidden {
            includeValidationStackView2.addArrangedSubview(errorLabel2)
        }
        
        // leading space와 validation stack view를 horizontal stack view에 추가
        emailStackView.addArrangedSubview(leadingSpace)
        emailStackView.addArrangedSubview(includeValidationStackView)
        emailStackView.addArrangedSubview(includeValidationStackView2)
    }
    
    
    private func configTextFieldFunc(ui:UIView, errorHidden: Bool) {
        let includeEmptyStackView = UIStackView()
        includeEmptyStackView.axis = .horizontal
        
        let includeValidationStackView = UIStackView()
        includeValidationStackView.axis = .vertical
        
        let leadingSpace: UIView = {
            let view = UIView()
            return view
        }()
        
        // Add constraints to the spaces.
        leadingSpace.snp.makeConstraints { make in
            make.width.equalTo(30) // Adjust this value as needed.
        }
        
        let errorLabel: UILabel = {
            let label = UILabel()
            label.text = "에러"
            label.textColor = .red
            label.isHidden = errorHidden
            return label
        }()
        
        ui.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        if !(ui.isHidden && errorHidden) {
            contentView.addArrangedSubview(includeEmptyStackView)
            
            // Add the space views and the text field to the stack view.
            includeEmptyStackView.addArrangedSubview(leadingSpace)
            includeValidationStackView.addArrangedSubview(ui)
            includeValidationStackView.addArrangedSubview(errorLabel)
            includeEmptyStackView.addArrangedSubview(includeValidationStackView)
        }
    }
    
    private func configSignUpButton(ui: UIButton) {
        let SignUpButtonStackView = UIStackView()
        SignUpButtonStackView.axis = .horizontal
        
        let leadingSpace: UIView = {
            let view = UIView()
            return view
        }()
        
        let trailingSpace: UIView = {
            let view = UIView()
            return view
        }()
        
        ui.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        contentView.addArrangedSubview(SignUpButtonStackView)
        
        // Add the space views and the text field to the stack view.
        SignUpButtonStackView.addArrangedSubview(leadingSpace)
        SignUpButtonStackView.addArrangedSubview(ui)
        SignUpButtonStackView.addArrangedSubview(trailingSpace)
        
        
        // Add constraints to the spaces.
        leadingSpace.snp.makeConstraints { make in
            make.width.equalTo(80) // Adjust this value as needed.
        }
        
        trailingSpace.snp.makeConstraints { make in
            make.width.equalTo(50) // Adjust this value as needed.
        }
    }
}
