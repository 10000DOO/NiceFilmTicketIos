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
    
    func sendEmail(email: String, completion: @escaping (Int) -> Void) {
        let emailSendingReq = EmailSendingReq(email: email)
        emailRepository.sendEmail(email: emailSendingReq){ result in
            switch result {
            case .success(let emailSendingRes):
                completion(emailSendingRes.status)
            case .failure(let error):
                completion(error.status)
            }
        }
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

