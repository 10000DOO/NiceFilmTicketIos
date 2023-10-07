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
    
    private let signUpView = SignUpView(emailCodeHidden: true)
    let signUpViewModel: SignUpViewModel
    var cancellables = Set<AnyCancellable>()
    var keyHeight: CGFloat?
    var originFrameHeight: CGFloat?
    
    init(signUpViewModel: SignUpViewModel) {
        self.signUpViewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SignUpViewController(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //name으로 하나씩 지우기
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        
        originFrameHeight = self.view.frame.size.height
        
        let emailSendingButtonClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
        signUpView.emailCodeSendingButton.addGestureRecognizer(emailSendingButtonClickRecognizer)
        
        let signUpButtonClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(signUp))
        signUpView.signUpButton.addGestureRecognizer(signUpButtonClickRecognizer)
        
        //뒤로가기 제스쳐는 살리고 백버튼 지우기
        self.navigationController?.navigationBar.isHidden = true
        
        hideKeyboardWhenTappedAround()
        
    }
}

extension SignUpViewController {
    //키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        keyHeight = keyboardHeight
        
        if originFrameHeight! <= self.view.frame.size.height {
            self.view.frame.size.height -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if originFrameHeight! > self.view.frame.size.height {
            self.view.frame.size.height += keyHeight ?? 0
        }
    }
    
    @objc func sendEmail() {
        if let email = self.signUpView.emailTextField.text {
            signUpViewModel.sendEmail(email: email)
            bindingEmailError()
        }
    }
    
    @objc func signUp() {
        var email: String = ""
        var emailCode: String = ""
        var loginId: String = ""
        var password: String = ""
        var passwordCheck: String = ""
        var nickName: String = ""
        
        if let emailText = self.signUpView.emailTextField.text {
            //사용 가능한 이메일인지 검사
            if self.signUpView.emailErrorLabel.text == ErrorMessage.availableEmail.message {
                email = emailText
            } else {
                self.signUpView.emailErrorLabel.text = ErrorMessage.wrongEmailPattern.message
            }
        } else {
            self.signUpView.emailErrorLabel.text = ErrorMessage.emailNotExist.message
        }
        
        if let emailCodeText = self.signUpView.emailCodeTextField.text {
            emailCode = emailCodeText
        } else {
            self.signUpView.emailCodeErrorLabel.text = ErrorMessage.emailCodeNotExist.message
        }
        
        if let loginIdText = self.signUpView.idTextField.text {
            //사용 가능한 아이디인지 검사
            if self.signUpView.idErrorLabel.text == ErrorMessage.availableLoginId.message {
                loginId = loginIdText
            } else {
                self.signUpView.idErrorLabel.text = ErrorMessage.wrongLoginIdPattern.message
            }
        } else {
            self.signUpView.idErrorLabel.text = ErrorMessage.loginIdNotExist.message
        }
        
        if let passwordText = self.signUpView.pwTextField.text {
            //사용 가능한 비밀번호인지 검사
            if self.signUpView.pwErrorLabel.text == ErrorMessage.availablePassword.message {
                password = passwordText
            } else {
                self.signUpView.pwErrorLabel.text = ErrorMessage.wrongPasswordPattern.message
            }
        } else {
            self.signUpView.pwErrorLabel.text = ErrorMessage.passwordNotExist.message
        }
        
        if let passwordCheckText = self.signUpView.pwCheckTextField.text {
            //비밀번호 일치하는지 검사
            if self.signUpView.pwCheckErrorLabel.text == ErrorMessage.passwordMatching.message {
                passwordCheck = passwordCheckText
            } else {
                self.signUpView.pwCheckErrorLabel.text = ErrorMessage.passwordNotMatching.message
            }
        } else {
            self.signUpView.pwCheckErrorLabel.text = ErrorMessage.passwordCheckNotExist.message
        }
        
        if let nickNameText = self.signUpView.nicknameTextField.text {
            //닉네임 일치하는지 검사
            if self.signUpView.nicknameErrorLabel.text == ErrorMessage.availableNickName.message {
                nickName = nickNameText
            } else {
                self.signUpView.nicknameErrorLabel.text = ErrorMessage.wrongNickNamePattern.message
            }
        } else {
            self.signUpView.nicknameErrorLabel.text = ErrorMessage.nickNameNotExist.message
        }
        
        if password == passwordCheck {
            guard let memberType = UserDefaults.standard.string(forKey: "memberType") else { return }
            signUpViewModel.signUp(email: email, emailCode: emailCode, loginId: loginId, password: password, nickName: nickName, memberType: memberType)
            bindingEmailError()
            bindingEmailCodeError()
            bindingLoginIdDuplicate()
            bindingPasswordPattern()
            bindingNickNameDuplicate()
            
            signUpViewModel.$signUpSuccess.sink { [weak self] result in
                if result {
                    let signInVC = SignInViewController(signInViewModel: SignInViewModel(signInService: SignInService(signInRepository: SignInRepository())))
                    self?.navigationController?.pushViewController(signInVC, animated: false)
                }
            }.store(in: &cancellables)
        }
    }
    
    func bindingEmailCodeError() {
        signUpViewModel.subscribeToEmailCodeError(store: &cancellables) {
            [weak self] emailCodeErrorMessage in
            DispatchQueue.main.async {
                if emailCodeErrorMessage != ErrorMessage.availableEmail.message {
                    self?.signUpView.emailTextField.resignFirstResponder()
                    self?.signUpView.emailErrorLabel.textColor = .red
                    self?.signUpView.emailErrorLabel.text = emailCodeErrorMessage
                }
            }
        }
    }
    
    
    func bindingEmailError() {
        signUpViewModel.subscribeToEmailError(store: &cancellables) { [weak self] emailErrorMessage in
            DispatchQueue.main.async {
                if emailErrorMessage != ErrorMessage.availableEmail.message {
                    self?.signUpView.emailTextField.resignFirstResponder()
                    self?.signUpView.emailErrorLabel.textColor = .red
                    self?.signUpView.emailErrorLabel.text = emailErrorMessage
                } else {
                    self?.signUpView.emailCodeStackView.isHidden = false
                    self?.signUpView.emailErrorLabel.textColor = .clear
                }
            }
        }
    }
    
    func bindingEmailDuplicate() {
        signUpViewModel.subscribeToEmailError(store: &cancellables) { [weak self] emailErrorMessage in
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

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.signUpView.emailTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            signUpViewModel.emailDuplicateCheck(email: updatedText)
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
}
