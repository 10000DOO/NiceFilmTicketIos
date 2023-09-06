//
//  EmailSendingViewModel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/29.
//

import Foundation
import Combine

class EmailViewModel: ObservableObject {
    
    private let emailService: EmailServiceProtocol
    private let signUpService: SignUpServiceProtocol
    @Published var email = ""
    @Published var emailError = ""
    
    init(emailService: EmailServiceProtocol, signUpService: SignUpServiceProtocol) {
        self.emailService = emailService
        self.signUpService = signUpService
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
}
