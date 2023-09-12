//
//  SignInViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/24.
//

import UIKit
import SnapKit
import Combine

class SignInViewController: UIViewController {
    
    private var signInView = SignInView()
    private let signInViewModel: SignInViewModel
    var cancellables = Set<AnyCancellable>()
    
    init(signInViewModel: SignInViewModel) {
        self.signInViewModel = signInViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("AuthenticationViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView = SignInView(frame: view.bounds)
        view.addSubview(signInView)
        
        signInView.pwTextField.textContentType = .oneTimeCode
        
        setupGestureRecognizers()
    }
}

extension SignInViewController {
    private func setupGestureRecognizers() {
        // 개인 버튼 탭 제스처 인식기 생성 및 추가
        let personalTextClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPersonButton))
        signInView.personalSignInText.addGestureRecognizer(personalTextClickRecognizer)
        
        let personalImageClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPersonButton))
        signInView.personalSignInImage.addGestureRecognizer(personalImageClickRecognizer)
        
        // 비지니스 버튼 탭 제스처 인식기 생성 및 추가
        let businessTextClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickBusinessButton))
        signInView.businessSignInText.addGestureRecognizer(businessTextClickRecognizer)
        
        let businessImageClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickBusinessButton))
        signInView.businessSignInImage.addGestureRecognizer(businessImageClickRecognizer)
    
        signInView.signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        // 회원가입 버튼 이벤트 설정
        signInView.signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        
        // 키보드 내리기 설정
        hideKeyboardWhenTappedAround()
    }
    
    //개인 로그인으로 변경
    @objc private func clickPersonButton() {
        signInView.personalSignInImage.image = UIImage(systemName: "person.fill")
        signInView.businessSignInImage.image = UIImage(systemName: "bag")
    }
    
    //비즈니스 로그인으로 변경
    @objc private func clickBusinessButton() {
        signInView.businessSignInImage.image = UIImage(systemName: "bag.fill")
        signInView.personalSignInImage.image = UIImage(systemName: "person")
    }
    
    //회원가입 뷰로 이동
    @objc private func didTapSignupButton() {
        let signUpVC = SignUpViewController(signUpViewModel: SignUpViewModel(signUpService: SignUpService(signUpRepository: SignUpRepository(), emailService: EmailService(emailRepository: EmailRepository())), emailService: EmailService(emailRepository: EmailRepository())))
        self.navigationController?.pushViewController(signUpVC, animated: false)
    }
    
    @objc func signIn() {
        if let loginId = signInView.idTextField.text, let password = signInView.pwTextField.text {
            signInViewModel.signIn(loginId: loginId, password: password)
            bindingSignInError()
        } else {
            signInView.signInErrorLabel.textColor = .red
            signInView.signInErrorLabel.text = ErrorMessage.signInFail.message
        }
    }
    
    func bindingSignInError() {
        signInViewModel.subscribeSignInError(store: &cancellables) { [weak self] signInMessage in
            if signInMessage == ErrorMessage.signInSuccess.message {
                //다음 화면으로 이동
                let PublisherTabbarVC = PublisherTapbarViewController()
                PublisherTabbarVC.modalPresentationStyle = .fullScreen
                self?.present(PublisherTabbarVC, animated: true, completion: nil)
            } else {
                self?.signInView.signInErrorLabel.textColor = .red
                self?.signInView.signInErrorLabel.text = signInMessage
            }
        }
    }

    //키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
