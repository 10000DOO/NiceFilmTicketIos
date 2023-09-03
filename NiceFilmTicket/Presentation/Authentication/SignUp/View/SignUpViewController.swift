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
        signUpView.emailTextField.delegate = self
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
            
            emailSendingViewModel.emailDuplicateCheck(email: updatedText)
            bindingEmailDuplicate()
        }
        return true
    }
    
    func bindingEmailDuplicate() {
        emailSendingViewModel.subscribeToEmailError(store: &cancellables) { [weak self] emailErrorMessage in
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
}
