//
//  ViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/24.
//

import UIKit
import SnapKit

class AuthenticationViewController: UIViewController {
    
    private var authenticationView: AuthenticationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticationView = AuthenticationView(frame: view.bounds)
        view.addSubview(authenticationView)
        
        setupGestureRecognizers()
    }
}

extension AuthenticationViewController {
    private func setupGestureRecognizers() {
        // 개인 버튼 탭 제스처 인식기 생성 및 추가
        let personalTextClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPersonButton))
        authenticationView.personalLoginText.addGestureRecognizer(personalTextClickRecognizer)
        
        let personalImageClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPersonButton))
        authenticationView.personalLoginImage.addGestureRecognizer(personalImageClickRecognizer)
        
        // 비지니스 버튼 탭 제스처 인식기 생성 및 추가
        let businessTextClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickBusinessButton))
        authenticationView.businessLoginText.addGestureRecognizer(businessTextClickRecognizer)
        
        let businessImageClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickBusinessButton))
        authenticationView.businessLoginImage.addGestureRecognizer(businessImageClickRecognizer)
        
        // 회원가입 버튼 이벤트 설정
        authenticationView.signupButton.addTarget(self, action: #selector(didTapSignupButton), for:.touchUpInside)
        
        // 키보드 내리기 설정
        hideKeyboardWhenTappedAround()
    }
    
    //개인 로그인으로 변경
    @objc private func clickPersonButton() {
        authenticationView.personalLoginImage.image = UIImage(systemName: "person.fill")
        authenticationView.businessLoginImage.image = UIImage(systemName: "bag")
        authenticationView.kakaoImageView.isHidden = false
        authenticationView.idTextField.isHidden = true
        authenticationView.pwTextField.isHidden = true
        authenticationView.loginButton.isHidden = true
        authenticationView.orDivider.isHidden = true
        authenticationView.signupButton.isHidden = true
        authenticationView.findId.isHidden = true
        authenticationView.findPw.isHidden = true
        authenticationView.dividerLine.isHidden = true
        authenticationView.scrollView.isScrollEnabled = false
    }
    
    //비즈니스 로그인으로 변경
    @objc private func clickBusinessButton() {
        
        authenticationView.businessLoginImage.image = UIImage(systemName: "bag.fill")
        authenticationView.personalLoginImage.image = UIImage(systemName: "person")
        authenticationView.kakaoImageView.isHidden = true
        authenticationView.idTextField.isHidden = false
        authenticationView.pwTextField.isHidden = false
        authenticationView.loginButton.isHidden = false
        authenticationView.orDivider.isHidden = false
        authenticationView.signupButton.isHidden = false
        authenticationView.findId.isHidden = false
        authenticationView.findPw.isHidden = false
        authenticationView.dividerLine.isHidden = false
        authenticationView.scrollView.isScrollEnabled = true
    }
    
    //회원가입 뷰로 이동
    @objc private func didTapSignupButton() {
        let signUpVC = SignUpViewController(emailSendingViewModel: EmailSendingViewModel(emailService: EmailService(emailRepository: EmailRepository())))
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
