//
//  EmailRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation

protocol EmailRepositoryProtocol {
    
    func sendEmail(email: EmailSendingReq, completion: @escaping (Result<EmailSendingRes, ErrorResponse>) -> Void)
}
