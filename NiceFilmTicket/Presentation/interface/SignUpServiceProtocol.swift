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
    
    func isValidLoginId(loginId: String) -> Bool
    
    func isValidNickName(nickName: String) -> Bool
}