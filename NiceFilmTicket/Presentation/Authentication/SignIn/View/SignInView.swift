//
//  SignInView.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/29.
//
import UIKit
import SnapKit

class SignInView: UIView {
    
    lazy var personalSignInImage = UIImageView()
    lazy var businessSignInImage = UIImageView()
    lazy var kakaoImageView = UIImageView()
    lazy var idTextField = UITextField()
    lazy var pwTextField = UITextField()
    lazy var signInErrorLabel = UILabel()
    lazy var signInButton = UIButton()
    lazy var orDivider = UIImageView()
    lazy var signupButton = UIButton()
    lazy var findId = UILabel()
    lazy var findPw = UILabel()
    lazy var dividerLine = UIImageView()
    lazy var scrollView = UIScrollView()
    lazy var logoImageView = UIImageView()
    lazy var contentView = UIView()
    lazy var personalSignInText = UILabel()
    lazy var businessSignInText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        configureLogoImageView()
        configureScrollView(logoImageView: logoImageView)
        setGeneralLogin()
        setBusinessLogin()
        kakaoLoginButton()
        iDTextField()
        passwordTextField()
        signinErrorLabel()
        createSignInButton()
        createOrDivider()
        createSignUpButton()
        createDivider()
        createFindIDButton()
        createFindPWButton()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("AuthenticationView(coder:) has not been implemented")
    }
}

extension SignInView {
    //로고 만들기
    func configureLogoImageView() {
        logoImageView = UIImageView(image: UIImage(named: "Logo"))
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.top).offset(170)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(210)
            make.height.equalTo(150)
        }
    }
    
    // 스크롤뷰 설정
    private func configureScrollView(logoImageView: UIImageView) {
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(logoImageView.snp.bottom) // logoImageView 아래에서 시작
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width)
        }
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(640)
        }
    }
    
    private func setGeneralLogin(){
        // 개인로그인 이미지 뷰 생성
        personalSignInImage = UIImageView(image: UIImage(systemName: "person.fill"))
        personalSignInImage.isUserInteractionEnabled = true
        personalSignInImage.tintColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        contentView.addSubview(personalSignInImage)
        
        personalSignInImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(contentView.snp.leading).offset(60)
            make.top.equalTo(contentView.snp.top).offset(50)
        }
        
        // 개인로그인 텍스트 레이블 생성
        personalSignInText = MenuUILabel(text: "일반", size: UIFont.boldSystemFont(ofSize: 25))
        personalSignInText.isUserInteractionEnabled = true
        contentView.addSubview(personalSignInText)
        
        // 개인로그인 텍스트 제약 조건
        personalSignInText.snp.makeConstraints { make in
            make.leading.equalTo(personalSignInImage.snp.trailing).offset(0)
            make.top.equalTo(contentView.snp.top).offset(55)
        }
    }
    
    private func setBusinessLogin() {
        // 비지니스로그인 텍스트 레이블 생성
        businessSignInText = MenuUILabel(text: "비즈니스", size: UIFont.boldSystemFont(ofSize: 25))
        businessSignInText.isUserInteractionEnabled = true
        contentView.addSubview(businessSignInText)
        
        // 비지니스로그인 텍스트 제약 조건
        businessSignInText.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(60)
            make.top.equalTo(contentView.snp.top).offset(55)
        }
        
        // 비지니스로그인 이미지 뷰 생성
        businessSignInImage = UIImageView(image: UIImage(systemName: "bag"))
        businessSignInImage.isUserInteractionEnabled = true
        businessSignInImage.tintColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        contentView.addSubview(businessSignInImage)
        
        businessSignInImage.snp.makeConstraints { make in
            make.trailing.equalTo(businessSignInText.snp.leading)
            make.top.equalTo(contentView.snp.top).offset(50)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func kakaoLoginButton() {
        //카카오 로그인 버튼
        kakaoImageView = UIImageView(image: UIImage(named: "KakaoLogin"))
        kakaoImageView.isUserInteractionEnabled = true
        contentView.addSubview(kakaoImageView)
        
        // 카카오 로그인 뷰의 제약 조건 설정
        kakaoImageView.snp.makeConstraints { make in
            make.top.equalTo(personalSignInText.snp.bottom).offset(150)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
    }
    
    private func iDTextField() {
        //ID 입력 텍스트 필드
        idTextField = AuthenticationTextField(placeholder: "  ID", isSecureTextEntry: false, backgroundColor: UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1), isHidden: true, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(idTextField)
        
        idTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(businessSignInImage.snp.bottom).offset(40)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }
    
    private func passwordTextField() {
        //비밀번호 입력 텍스트 필드
        pwTextField = AuthenticationTextField(placeholder: "  PW", isSecureTextEntry: true, backgroundColor: UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1), isHidden: true, font: UIFont.systemFont(ofSize: 20))
        contentView.addSubview(pwTextField)
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }
    
    private func signinErrorLabel() {
        signInErrorLabel.text = ""
        signInErrorLabel.textColor = .red
        signInErrorLabel.isHidden = true
        contentView.addSubview(signInErrorLabel)
        
        signInErrorLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(pwTextField.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
        }
    }
    
    private func createSignInButton() {
        //로그인 버튼
        signInButton = AuthenticationUIButton(title: "LogIn", isHidden: true)
        contentView.addSubview(signInButton)
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(signInErrorLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    private func createOrDivider() {
        //signIn버튼 아래 or
        orDivider = UIImageView(image: UIImage(named: "OrDivider"))
        orDivider.isHidden = true
        contentView.addSubview(orDivider)
        
        orDivider.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(40)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(280)
            make.height.equalTo(10)
        }
    }
    
    private func createSignUpButton() {
        //회원가입 버튼
        signupButton = AuthenticationUIButton(title: "Make Account", isHidden: true)
        contentView.addSubview(signupButton)
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(orDivider.snp.bottom).offset(40)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
    }
    
    private func createDivider() {
        //아이디 찾기 비밀번호 찾기 분리선
        dividerLine = UIImageView(image: UIImage(named: "Line"))
        dividerLine.isHidden = true
        contentView.addSubview(dividerLine)
        
        dividerLine.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom).offset(85)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(3)
            make.height.equalTo(50)
        }
    }
    
    private func createFindIDButton() {
        //아이디 찾기
        findId = FindIdPwUILabel(text: "아이디 찾기")
        contentView.addSubview(findId)
        
        // 아이디 찾기 제약 조건
        findId.snp.makeConstraints { make in
            make.trailing.equalTo(dividerLine.snp.leading).offset(-65)
            make.top.equalTo(signupButton.snp.bottom).offset(100)
        }
    }
    
    private func createFindPWButton() {
        //비밀번호 찾기
        findPw = FindIdPwUILabel(text: "비밀번호 찾기")
        contentView.addSubview(findPw)
        
        // 비밀번호 찾기 제약 조건
        findPw.snp.makeConstraints { make in
            make.leading.equalTo(dividerLine.snp.trailing).offset(60)
            make.top.equalTo(signupButton.snp.bottom).offset(100)
        }
    }
}
