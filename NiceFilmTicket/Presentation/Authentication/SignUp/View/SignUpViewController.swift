//
//  SignUpViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/26.
//

import UIKit
import SnapKit
import Combine

class SignUpViewController: UIViewController {
    
    private var signUpView = SignUpView(emailCodeHidden: true)
    var emailSendingViewModel: EmailSendingViewModel
    var cancellables = Set<AnyCancellable>()
    
    init(emailSendingViewModel: EmailSendingViewModel){
        self.emailSendingViewModel = emailSendingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignUpViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signUpView)
        
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let emailSendingButtonClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
        signUpView.emailCodeSendingButton.addGestureRecognizer(emailSendingButtonClickRecognizer)
        
        //뒤로가기 제스쳐는 살리고 백버튼 지우기
        self.navigationController?.navigationBar.isHidden = true
        
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
    
    @objc func sendEmail() {
        if let email = self.signUpView.emailTextField.text {
            emailSendingViewModel.sendEmail(email: email)
            bindingEmailError()
        }
    }
    
    func bindingEmailError() {
        emailSendingViewModel.subscribeToEmailError(store: &cancellables) { [weak self] emailErrorMessage in
            DispatchQueue.main.async {
                if emailErrorMessage.isEmpty {
                    self?.signUpView.emailTextField.resignFirstResponder()
                    self?.signUpView.emailErrorLabel.textColor = .clear
                    self?.signUpView.emailCodeStackView.isHidden = false
                    self?.signUpView.emailTextField.isEnabled = false
                } else {
                    self?.signUpView.emailTextField.resignFirstResponder()
                    self?.signUpView.emailErrorLabel.textColor = .red
                    self?.signUpView.emailErrorLabel.text = emailErrorMessage
                    self?.signUpView.emailCodeStackView.isHidden = true
                }
            }
        }
    }
}
