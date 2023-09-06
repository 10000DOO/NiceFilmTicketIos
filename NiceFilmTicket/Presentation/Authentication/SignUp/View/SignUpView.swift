//
//  SignUpView.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/29.
//

import UIKit

class SignUpView: UIView {
    
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
    lazy var emailCodeStackView = UIStackView()
    lazy var emailStackView = UIStackView()
    lazy var emailTextField = AuthenticationTextField(placeholder: "  이메일", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    lazy var emailCodeSendingButton = AuthenticationUIButton(title: "인증번호 발송", isHidden: false)
    lazy var emailCodeTextField = AuthenticationTextField(placeholder: "  이메일 인증 코드", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    lazy var idTextField = AuthenticationTextField(placeholder: "  아이디", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    lazy var pwTextField = AuthenticationTextField(placeholder: "  비밀번호", isSecureTextEntry: true, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    lazy var pwCheckTextField = AuthenticationTextField(placeholder: "  비밀번호 확인", isSecureTextEntry: true, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    lazy var nicknameTextField = AuthenticationTextField(placeholder: "  닉네임", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
    lazy var signUpButton = AuthenticationUIButton(title: "Make Account", isHidden: false)
    lazy var emailErrorLabel = UILabel()
    lazy var emailCodeErrorLabel = UILabel()
    lazy var idErrorLabel = UILabel()
    lazy var pwErrorLabel = UILabel()
    lazy var pwCheckErrorLabel = UILabel()
    lazy var nicknameErrorLabel = UILabel()
    lazy var bottomSpace = UILabel()
    
    init(emailCodeHidden: Bool) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        configureLogoImageView()
        signUpLabel()
        configureScrollView(menu: signUpText)
        configureStackView()
        emailTextFieldFunc(errorLabel: emailErrorLabel, bottomSpace: bottomSpace)
        //이메일 코드 입력 텍스트 필드
        emailCodeTextFieldFunc(ui: emailCodeTextField, errorLabel: emailCodeErrorLabel)
        //아이디 입력 텍스트 필드
        configTextFieldFunc(ui: idTextField, errorLabel: idErrorLabel)
        //비밀번호 입력 텍스트 필드
        configTextFieldFunc(ui: pwTextField, errorLabel: pwErrorLabel)
        //비밀번호 확인 입력 텍스트 필드
        configTextFieldFunc(ui: pwCheckTextField, errorLabel: pwCheckErrorLabel)
        //닉네임 입력 텍스트 필드
        configTextFieldFunc(ui: nicknameTextField, errorLabel: nicknameErrorLabel)
        //회원가입 버튼
        configSignUpButton(ui: signUpButton)
    }
}

extension SignUpView {
    //로고 만들기
    private func configureLogoImageView() {
        logoImageView = UIImageView(image: UIImage(named: "Logo"))
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.top).offset(170)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(210)
            make.height.equalTo(150)
        }
    }
    
    func signUpLabel() {
        // 회원가입 텍스트 레이블 생성
        signUpText = MenuUILabel(text: "회원가입", size: UIFont.boldSystemFont(ofSize: 25))
        self.addSubview(signUpText)
        
        // 회원가입 텍스트 제약 조건
        signUpText.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
        }
    }
    
    // 스크롤뷰 설정
    func configureScrollView(menu: UILabel) {
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(menu.snp.bottom).offset(30)// logoImageView 아래에서 시작
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width)
        }
    }
    
    //스택 뷰 설정
    func configureStackView() {
        contentView.axis = .vertical
        contentView.spacing = 15
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.trailing.equalTo(scrollView.frameLayoutGuide).inset(30)
        }
    }
    
    //이메일 텍스트 필드
    func emailTextFieldFunc(errorLabel: UILabel, bottomSpace: UILabel) {
        emailStackView.axis = .horizontal
        emailStackView.spacing = 10
        
        leadingSpace.snp.updateConstraints { make in
            make.height.equalTo(70)
        }
        emailStackView.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        
        let includeValidationStackView = UIStackView()
        includeValidationStackView.axis = .vertical
        
        errorLabel.text = ""
        errorLabel.textColor = .red
        bottomSpace.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        let includeValidationStackView2 = UIStackView()
        includeValidationStackView2.axis = .vertical
        
        bottomSpace.text = ""
        bottomSpace.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        // 이메일 입력 텍스트 필드 설정
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        // 인증번호 발송 버튼 설정
        emailCodeSendingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        emailCodeSendingButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        contentView.addArrangedSubview(emailStackView)
        // 이메일 필드와 에러 레이블을 vertical stack view에 추가
        includeValidationStackView.addArrangedSubview(emailTextField)
        includeValidationStackView.addArrangedSubview(errorLabel)
        includeValidationStackView2.addArrangedSubview(emailCodeSendingButton)
        includeValidationStackView2.addArrangedSubview(bottomSpace)
        // leading space와 validation stack view를 horizontal stack view에 추가
        emailStackView.addArrangedSubview(leadingSpace)
        emailStackView.addArrangedSubview(includeValidationStackView)
        emailStackView.addArrangedSubview(includeValidationStackView2)
    }
    
    //이메일 코드
    func emailCodeTextFieldFunc(ui: UIView, errorLabel: UILabel) {
        emailCodeStackView.axis = .horizontal
        
        let emailCodeErrorStackView = UIStackView()
        emailCodeErrorStackView.axis = .vertical
        
        let leadingSpace: UIView = {
            let view = UIView()
            return view
        }()
        
        // Add constraints to the spaces.
        leadingSpace.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        errorLabel.text = ""
        errorLabel.textColor = .red
        
        errorLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        ui.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        contentView.addArrangedSubview(emailCodeStackView)
        
        // Add the space views and the text field to the stack view.
        emailCodeStackView.addArrangedSubview(leadingSpace)
        emailCodeErrorStackView.addArrangedSubview(ui)
        emailCodeErrorStackView.addArrangedSubview(errorLabel)
        emailCodeStackView.addArrangedSubview(emailCodeErrorStackView)
        emailCodeStackView.isHidden = true
    }
    
    func configTextFieldFunc(ui: UIView, errorLabel: UILabel) {
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
            make.width.equalTo(30)
        }
        
        errorLabel.text = ""
        errorLabel.textColor = .red
        
        errorLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        ui.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        contentView.addArrangedSubview(includeEmptyStackView)
        
        // Add the space views and the text field to the stack view.
        includeEmptyStackView.addArrangedSubview(leadingSpace)
        includeValidationStackView.addArrangedSubview(ui)
        includeValidationStackView.addArrangedSubview(errorLabel)
        includeEmptyStackView.addArrangedSubview(includeValidationStackView)
    }
    
    func configSignUpButton(ui: UIButton) {
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
        
        ui.backgroundColor = .darkGray
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
