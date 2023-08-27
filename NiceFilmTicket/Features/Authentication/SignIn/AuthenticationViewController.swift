//
//  ViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/24.
//

import UIKit
import SnapKit

class AuthenticationViewController: UIViewController {
    
    
    lazy var personalLoginImage = UIImageView()
    lazy var businessLoginImage = UIImageView()
    lazy var kakaoImageView = UIImageView()
    lazy var idTextField = UITextField()
    lazy var pwTextField = UITextField()
    lazy var loginButton = UIButton()
    lazy var orDivider = UIImageView()
    lazy var signupButton = UIButton()
    lazy var findId = UILabel()
    lazy var findPw = UILabel()
    lazy var dividerLine = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 로고이미지 뷰 생성
        let logoImageView = UIImageView(image: UIImage(named: "Logo"))
        view.addSubview(logoImageView)
        
        // 로고이미지 뷰의 제약 조건 설정
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.top).offset(200)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(350)
            make.height.equalTo(450)
        }
        
        // 개인로그인 컨테이너 뷰 생성
        let personalButtonContainer = UIView()
        view.addSubview(personalButtonContainer)
        
        // 개인로그인 컨테이너 뷰의 제약 조건 설정
        personalButtonContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.top.equalTo(logoImageView.snp.bottom).offset(-100)
        }
        
        // 개인로그인 이미지 뷰 생성
        personalLoginImage = UIImageView(image: UIImage(systemName: "person.fill"))
        personalLoginImage.tintColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        personalLoginImage.isUserInteractionEnabled = true // 하위 뷰의 클릭 이벤트 허용
        personalButtonContainer.addSubview(personalLoginImage)
        
        personalLoginImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        // 개인로그인 텍스트 레이블 생성
        let personalLoginText = MenuUILabel(text: "일반", size: UIFont.boldSystemFont(ofSize: 25))
        personalLoginText.isUserInteractionEnabled = true // 하위 뷰의 클릭 이벤트 허용
        personalButtonContainer.addSubview(personalLoginText)
        
        // 개인로그인 텍스트 제약 조건
        personalLoginText.snp.makeConstraints { make in
            make.leading.equalTo(personalLoginImage.snp.trailing).offset(0)
            make.trailing.top.bottom.equalToSuperview()
        }
        
        personalLoginImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        // 비지니스로그인 컨테이너 뷰 생성
        let businessButtonContainer = UIView()
        view.addSubview(businessButtonContainer)
        
        // 비지니스로그인 컨테이너 뷰의 제약 조건 설정
        businessButtonContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(60)
            make.top.equalTo(logoImageView.snp.bottom).offset(-100)
        }
        
        // 비지니스로그인 이미지 뷰 생성
        businessLoginImage = UIImageView(image: UIImage(systemName: "bag"))
        businessLoginImage.tintColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        businessLoginImage.isUserInteractionEnabled = true // 하위 뷰의 클릭 이벤트 허용
        businessButtonContainer.addSubview(businessLoginImage)
        
        businessLoginImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        // 비지니스로그인 텍스트 레이블 생성
        let businessLoginText = MenuUILabel(text: "비즈니스", size: UIFont.boldSystemFont(ofSize: 25))
        businessLoginText.isUserInteractionEnabled = true // 하위 뷰의 클릭 이벤트 허용
        businessButtonContainer.addSubview(businessLoginText)
        
        // 비지니스로그인 텍스트 제약 조건
        businessLoginText.snp.makeConstraints { make in
            make.leading.equalTo(businessLoginImage.snp.trailing).offset(0)
            make.trailing.top.bottom.equalToSuperview()
        }
        
        businessLoginImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        //카카오 로그인 버튼
        kakaoImageView = UIImageView(image: UIImage(named: "KakaoLogin"))
        view.addSubview(kakaoImageView)
        
        // 카카오 로그인 뷰의 제약 조건 설정
        kakaoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.bottom).inset(150)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        
        //ID 입력 텍스트 필드
        idTextField = AuthenticationTextField(placeholder: "  ID", isSecureTextEntry: false, backgroundColor: UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1), isHidden: true, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(idTextField)
        
        idTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(businessButtonContainer.snp.bottom).offset(25)
            make.leading.equalTo(view.snp.leading).inset(30)
            make.trailing.equalTo(view.snp.trailing).inset(30)
        }
        
        //비밀번호 입력 텍스트 필드
        pwTextField = AuthenticationTextField(placeholder: "  PW", isSecureTextEntry: true, backgroundColor: UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1), isHidden: true, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(pwTextField)
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(view.snp.leading).inset(30)
            make.trailing.equalTo(view.snp.trailing).inset(30)
        }
        
        hideKeyboardWhenTappedAround()
        
        //로그인 버튼
        loginButton = AuthenticationUIButton(title: "LogIn")
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(150)
        }
        
        //login버튼 아래 or
        orDivider = UIImageView(image: UIImage(named: "OrDivider"))
        orDivider.isHidden = true
        view.addSubview(orDivider)
        
        orDivider.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(280)
            make.height.equalTo(10)
        }
        
        //회원가입 버튼
        signupButton = AuthenticationUIButton(title: "Make Account")
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside) //회원가입 버튼 눌렀을 때
        view.addSubview(signupButton)
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(orDivider.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(220)
        }
        
        //아이디 찾기 비밀번호 찾기 분리선
        dividerLine = UIImageView(image: UIImage(named: "Line"))
        dividerLine.isHidden = true
        view.addSubview(dividerLine)
        
        dividerLine.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(35)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(3)
            make.height.equalTo(50)
        }
        
        //아이디 찾기
        findId = FindIdPwUILabel(text: "아이디 찾기")
        view.addSubview(findId)
        
        // 아이디 찾기 제약 조건
        findId.snp.makeConstraints { make in
            make.right.equalTo(dividerLine.snp.left).offset(-65)
            make.bottom.equalTo(view.snp.bottom).inset(50)
        }
        
        //비밀번호 찾기
        findPw = FindIdPwUILabel(text: "비밀번호 찾기")
        view.addSubview(findPw)
        
        // 비밀번호 찾기 제약 조건
        findPw.snp.makeConstraints { make in
            make.left.equalTo(dividerLine.snp.right).offset(60)
            make.bottom.equalTo(view.snp.bottom).inset(50)
        }
        
        // 개인 버튼 탭 제스처 인식기 생성 및 추가
        let personalButtonClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPersonButton))
        personalButtonContainer.addGestureRecognizer(personalButtonClickRecognizer)
        
        // 비지니스 버튼 탭 제스처 인식기 생성 및 추가
        let BusinessButtonClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickBusinessButton))
        businessButtonContainer.addGestureRecognizer(BusinessButtonClickRecognizer)
    }
}

extension AuthenticationViewController {
    //개인 로그인으로 변경
    @objc func clickPersonButton() {
        personalLoginImage.image = UIImage(systemName: "person.fill")
        businessLoginImage.image = UIImage(systemName: "bag")
        kakaoImageView.isHidden = false
        idTextField.isHidden = true
        pwTextField.isHidden = true
        loginButton.isHidden = true
        orDivider.isHidden = true
        signupButton.isHidden = true
        findId.isHidden = true
        findPw.isHidden = true
        dividerLine.isHidden = true
    }
    
    //비즈니스 로그인으로 변경
    @objc func clickBusinessButton() {
        businessLoginImage.image = UIImage(systemName: "bag.fill")
        personalLoginImage.image = UIImage(systemName: "person")
        kakaoImageView.isHidden = true
        idTextField.isHidden = false
        pwTextField.isHidden = false
        loginButton.isHidden = false
        orDivider.isHidden = false
        signupButton.isHidden = false
        findId.isHidden = false
        findPw.isHidden = false
        dividerLine.isHidden = false
    }
    
    //회원가입 뷰로 이동
    @objc func didTapSignupButton() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: false)
    }
    
    //키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthenticationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}