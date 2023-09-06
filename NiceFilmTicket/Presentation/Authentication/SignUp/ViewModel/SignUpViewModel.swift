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
    @Published var loginId = ""
    @Published var loginIdError = ""
    @Published var password = ""
    @Published var passwordError = ""
    @Published var passwordCheck = ""
    @Published var passwordCheckError = ""
    @Published var nickName = ""
    @Published var nickNameError = ""
    
    init(signUpService: SignUpServiceProtocol) {
        self.signUpService = signUpService
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
}
