//
//  EmailProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation
import Combine

protocol EmailServiceProtocol {
    
    func sendEmail(email: String, completion: @escaping (String) -> Void)
    
    func isEmailValid(email: String) -> Bool
    
    func checkCode(emailCode: String) -> AnyPublisher<String, ErrorResponse>
}
