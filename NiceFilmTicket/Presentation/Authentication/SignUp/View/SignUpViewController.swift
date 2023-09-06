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
    let emailViewModel: EmailViewModel
    let signUpViewModel: SignUpViewModel
    var cancellables = Set<AnyCancellable>()
    
    init(emailViewModel: EmailViewModel, signUpViewModel: SignUpViewModel){
        self.emailViewModel = emailViewModel
        self.signUpViewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignUpViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.emailTextField.delegate = self
        signUpView.idTextField.delegate = self
        signUpView.nicknameTextField.delegate = self
        signUpView.pwTextField.delegate = self
        signUpView.pwCheckTextField.delegate = self
        view.addSubview(signUpView)
        
        signUpView.pwTextField.textContentType = .oneTimeCode
        signUpView.pwCheckTextField.textContentType = .oneTimeCode
        
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
            emailViewModel.sendEmail(email: email)
            bindingEmailError()
        }
    }
    
    func bindingEmailError() {
        emailViewModel.subscribeToEmailError(store: &cancellables) { [weak self] emailErrorMessage in
            DispatchQueue.main.async {
                if emailErrorMessage.isEmpty {
                    self?.signUpView.emailCodeStackView.isHidden = false
                    self?.signUpView.emailErrorLabel.textColor = .clear
                    self?.signUpView.emailTextField.isEnabled = false
                    self?.signUpView.emailTextField.backgroundColor = .lightGray
                }
                if emailErrorMessage != ErrorMessage.availableEmail.message {
                    self?.signUpView.emailTextField.resignFirstResponder()
                    self?.signUpView.emailErrorLabel.textColor = .red
                    self?.signUpView.emailErrorLabel.text = emailErrorMessage
                }
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.signUpView.emailTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            emailViewModel.emailDuplicateCheck(email: updatedText)
            bindingEmailDuplicate()
        }
        
        if textField == self.signUpView.idTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            signUpViewModel.loginIdDuplicateCheck(loginId: updatedText)
            bindingLoginIdDuplicate()
        }
        
        if textField == self.signUpView.nicknameTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            signUpViewModel.nickNameDuplicateCheck(nickName: updatedText)
            bindingNickNameDuplicate()
        }
        
        if textField == self.signUpView.pwTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            signUpViewModel.passwordPatternCheck(password: updatedText)
            bindingPasswordPattern()
            bindingPasswordCheck()
        }
        
        if textField == self.signUpView.pwCheckTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            signUpViewModel.passwordMatching(passwordForCheck: updatedText)
            bindingPasswordCheck()
        }
        return true
    }
    
    func bindingEmailDuplicate() {
        emailViewModel.subscribeToEmailError(store: &cancellables) { [weak self] emailErrorMessage in
            DispatchQueue.main.async {
                if emailErrorMessage == ErrorMessage.availableEmail.message {
                    self?.signUpView.emailErrorLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
                    self?.signUpView.emailErrorLabel.text = emailErrorMessage
                } else {
                    self?.signUpView.emailErrorLabel.textColor = .red
                    self?.signUpView.emailErrorLabel.text = emailErrorMessage
                }
            }
        }
    }
    
    func bindingLoginIdDuplicate() {
        signUpViewModel.subscribeToLoginIdError(store: &cancellables) { [weak self] loginIdErrorMessage in
            DispatchQueue.main.async {
                if loginIdErrorMessage == ErrorMessage.availableLoginId.message {
                    self?.signUpView.idErrorLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
                    self?.signUpView.idErrorLabel.text = loginIdErrorMessage
                } else {
                    self?.signUpView.idErrorLabel.textColor = .red
                    self?.signUpView.idErrorLabel.text = loginIdErrorMessage
                }
            }
        }
    }
    
    func bindingNickNameDuplicate() {
        signUpViewModel.subscribeToNickNameError(store: &cancellables) { [weak self] nickNameErrorMessage in
            DispatchQueue.main.async {
                if nickNameErrorMessage == ErrorMessage.availableNickName.message {
                    self?.signUpView.nicknameErrorLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
                    self?.signUpView.nicknameErrorLabel.text = nickNameErrorMessage
                } else {
                    self?.signUpView.nicknameErrorLabel.textColor = .red
                    self?.signUpView.nicknameErrorLabel.text = nickNameErrorMessage
                }
            }
        }
    }
    
    func bindingPasswordPattern() {
        signUpViewModel.subscribeToPasswordError(store: &cancellables) { [weak self] passwordErrorMessage in
            DispatchQueue.main.async {
                if passwordErrorMessage == ErrorMessage.availablePassword.message {
                    self?.signUpView.pwErrorLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
                    self?.signUpView.pwErrorLabel.text = passwordErrorMessage
                } else {
                    self?.signUpView.pwErrorLabel.textColor = .red
                    self?.signUpView.pwErrorLabel.text = passwordErrorMessage
                }
            }
        }
    }
    
    //비밀번호 일치 확인
    func bindingPasswordCheck() {
        signUpViewModel.subscribeToPasswordMatchingError(store: &cancellables) { [weak self] passwordMatchingError in
            DispatchQueue.main.async {
                if passwordMatchingError == ErrorMessage.passwordMatching.message {
                    self?.signUpView.pwCheckErrorLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
                    self?.signUpView.pwCheckErrorLabel.text = passwordMatchingError
                } else {
                    self?.signUpView.pwCheckErrorLabel.textColor = .red
                    self?.signUpView.pwCheckErrorLabel.text = passwordMatchingError
                }
            }
        }
    }
}
