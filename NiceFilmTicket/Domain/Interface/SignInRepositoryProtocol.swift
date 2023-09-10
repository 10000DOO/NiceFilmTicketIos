//
//  SignInRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/10.
//

import Foundation

protocol SignInRepositoryProtocol {
    
    func signIn(signInReq: SignInReq, completion: @escaping (Result<SignInResponse, ErrorResponse>) -> Void)
}
