//
//  SignUpServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/05.
//

import Foundation

protocol SignUpServiceProtocol {
    
    func emailDuplicateCheck(email: String, completion: @escaping (String) -> Void)
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (String) -> Void)
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (String) -> Void)
    
    func passwordPatternCheck(password: String, completion: @escaping (String) -> Void)
    
    func passwordMatchingCheck(password: String, passwordForCheck: String, completion: @escaping (String) -> Void)
    
    func isValidLoginId(loginId: String) -> Bool
    
    func isValidNickName(nickName: String) -> Bool
    
    func isValidPassword(password: String) -> Bool
    
    func signUp(email: String, emailCode: String, loginId: String, password: String, nickName: String, completion: @escaping (SignUpRes) -> Void)
}
