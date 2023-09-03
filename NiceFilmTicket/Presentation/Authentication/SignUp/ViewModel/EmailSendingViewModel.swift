//
//  EmailSendingViewModel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/29.
//

import Foundation
import Combine

class EmailSendingViewModel: ObservableObject {
    
    private let emailService: EmailServiceProtocol
    @Published var email = ""
    @Published var emailError = ""
    
    init(emailService: EmailServiceProtocol) {
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
        emailService.emailDuplicateCheck(email: email) { [weak self] message in
            self?.emailError = message
        }
    }
}
