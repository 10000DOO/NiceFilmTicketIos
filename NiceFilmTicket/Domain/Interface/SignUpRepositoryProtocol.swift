//
//  SignUpRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/06.
//

import Foundation

protocol SignUpRepositoryProtocol {
    
    func emailDuplicateCheck(email: String, completion: @escaping (Result<SignUpDuplicateTestRes, ErrorResponse>) -> Void)
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (Result<SignUpDuplicateTestRes, ErrorResponse>) -> Void)
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (Result<SignUpDuplicateTestRes, ErrorResponse>) -> Void)
}
