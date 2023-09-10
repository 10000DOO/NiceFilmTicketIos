//
//  EmailService.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation

class EmailService: EmailServiceProtocol {
    
    let emailRepository: EmailRepositoryProtocol
    
    init(emailRepository: EmailRepositoryProtocol) {
        self.emailRepository = emailRepository
    }
    
    func sendEmail(email: String, completion: @escaping (String) -> Void) {
        if isEmailValid(email: email) {
            let emailSendingReq = EmailSendingReq(email: email)
            emailRepository.sendEmail(email: emailSendingReq){ result in
                switch result {
                case .success(_):
                    completion(ErrorMessage.availableEmail.message)
                case .failure(let error):
                    switch error.status {
                    case 400:
                        completion(ErrorMessage.wrongEmailPattern.message)
                    case 500:
                        completion(ErrorMessage.serverError.message)
                    default:
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            completion(ErrorMessage.wrongEmailPattern.message)
        }
        
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

