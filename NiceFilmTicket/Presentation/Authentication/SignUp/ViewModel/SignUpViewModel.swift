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
        signUpService.loginIdDuplicateCheck(loginId: loginId) { [weak self] message in
            self?.loginIdError = message
        }
    }
    
    func nickNameDuplicateCheck(nickName: String) {
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
    
    func passwordDuplicateCheck(password: String) {
        signUpService.passwordPatternCheck(password: password) { [weak self] message in
            self?.passwordError = message
        }
    }
    
    func subscribeToPasswordError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $passwordError.sink { passwordError in
            completion(passwordError)
        }.store(in: &store)
    }
}
