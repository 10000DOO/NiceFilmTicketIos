//
//  SignUpViewModel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/05.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    private let signUpService: SignUpServiceProtocol
    private let emailService: EmailServiceProtocol
    @Published var email = ""
    @Published var emailError = ""
    @Published var emailCode = ""
    @Published var emailCodeError = ""
    @Published var loginId = ""
    @Published var loginIdError = ""
    @Published var password = ""
    @Published var passwordError = ""
    @Published var passwordCheck = ""
    @Published var passwordCheckError = ""
    @Published var nickName = ""
    @Published var nickNameError = ""
    @Published var signUpSuccess = false
    
    init(signUpService: SignUpServiceProtocol, emailService: EmailServiceProtocol) {
        self.signUpService = signUpService
        self.emailService = emailService
    }
    
    func sendEmail(email: String) {
        emailService.sendEmail(email: email) { [weak self] message in
            self?.emailError = message
        }
    }
    
    func subscribeToEmailError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $emailError.sink { emailError in
            completion(emailError)
        }.store(in: &store)
    }
    
    func emailDuplicateCheck(email: String) {
        signUpService.emailDuplicateCheck(email: email) { [weak self] message in
            self?.emailError = message
        }
    }
    
    func loginIdDuplicateCheck(loginId: String) {
        self.loginId = loginId
        signUpService.loginIdDuplicateCheck(loginId: loginId) { [weak self] message in
            self?.loginIdError = message
        }
    }
    
    func nickNameDuplicateCheck(nickName: String) {
        self.nickName = nickName
        signUpService.nickNameDuplicateCheck(nickName: nickName) { [weak self] message in
            self?.nickNameError = message
        }
    }
    
    func subscribeToLoginIdError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $loginIdError.sink { loginIdError in
            completion(loginIdError)
        }.store(in: &store)
    }
    
    func subscribeToNickNameError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $nickNameError.sink { nickNameError in
            completion(nickNameError)
        }.store(in: &store)
    }
    
    func passwordPatternCheck(password: String) {
        self.password = password
        signUpService.passwordPatternCheck(password: password) { [weak self] message in
            self?.passwordError = message
        }
        
        signUpService.passwordMatchingCheck(password: password, passwordForCheck: passwordCheck) { [weak self] message in
            self?.passwordCheckError = message
        }
    }
    
    func subscribeToPasswordError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $passwordError.sink { passwordError in
            completion(passwordError)
        }.store(in: &store)
    }
    
    func passwordMatching(passwordForCheck: String) {
        self.passwordCheck = passwordForCheck
        signUpService.passwordMatchingCheck(password: password, passwordForCheck: passwordForCheck) { [weak self] message in
            self?.passwordCheckError = message
        }
    }
    
    func subscribeToPasswordMatchingError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $passwordCheckError.sink { passwordMatchingError in
            completion(passwordMatchingError)
        }.store(in: &store)
    }
    
    func subscribeToEmailCodeError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $emailCodeError.sink { emailCodeError in
            completion(emailCodeError)
        }.store(in: &store)
    }
    
    func signUp(email: String, emailCode: String, loginId: String, password: String, nickName: String) {
        signUpService.signUp(email: email, emailCode: emailCode, loginId: loginId, password: password, nickName: nickName) { [weak self] response in
            if response.serverError.isEmpty {
                if response.statusCode == 200 {
                    self?.signUpSuccess = true
                }
                if response.statusCode == 400 {
                    if !response.email.isEmpty {
                        self?.emailError = response.email
                    }
                    if !response.emailCode.isEmpty {
                        self?.emailCodeError = response.emailCode
                    }
                    if !response.loginId.isEmpty {
                        self?.loginIdError = response.loginId
                    }
                    if !response.password.isEmpty {
                        self?.passwordError = response.password
                    }
                    if !response.nickName.isEmpty {
                        self?.nickNameError = response.nickName
                    }
                }
            } else {
                self?.emailError = response.serverError
                self?.loginIdError = response.serverError
                self?.passwordError = response.serverError
                self?.nickNameError = response.serverError
            }
        }
    }
}
