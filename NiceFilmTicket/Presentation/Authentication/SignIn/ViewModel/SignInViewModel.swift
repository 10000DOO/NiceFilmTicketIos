//
//  SignInViewModel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/08.
//

import Foundation
import Combine

class SignInViewModel: ObservableObject {
    
    private let signInService: SignInServiceProtocol
    @Published var loginId = ""
    @Published var password = ""
    @Published var signInError = ""
    
    init(signInService: SignInServiceProtocol) {
        self.signInService = signInService
    }
    
    func signIn(loginId: String, password: String) {
        signInService.signIn(loginId: loginId, password: password) { [weak self] message in
            self?.signInError = message
        }
    }
    
    func subscribeSignInError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $signInError.sink { signInError in
            completion(signInError)
        }.store(in: &store)
    }
}
