//
//  EmailProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation

protocol EmailServiceProtocol {
    
    func sendEmail(email: String, completion: @escaping (String) -> Void)
    
    func isEmailValid(email: String) -> Bool
}
