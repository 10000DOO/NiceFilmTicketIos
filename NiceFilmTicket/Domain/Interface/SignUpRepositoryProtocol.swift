//
//  SignUpRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/06.
//

import Foundation

protocol SignUpRepositoryProtocol {
    
    func emailDuplicateCheck(email: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
    
    func signUp(signUpReq: SignUpReq, emailCode: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
}
