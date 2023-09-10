//
//  SignInServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/10.
//

import Foundation

protocol SignInServiceProtocol {
    
    func signIn(loginId: String, password: String, completion: @escaping (String) -> Void)
}
