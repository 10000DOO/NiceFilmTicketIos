//
//  MemberServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine

protocol MemberServiceProtocol {
    
    func signIn(loginId: String, password: String, memberType: String, completion: @escaping (String) -> Void)
    
    func emailDuplicateCheck(email: String, completion: @escaping (String) -> Void)
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (String) -> Void)
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (String) -> Void)
    
    func passwordPatternCheck(password: String, completion: @escaping (String) -> Void)
    
    func passwordMatchingCheck(password: String, passwordForCheck: String, completion: @escaping (String) -> Void)
    
    func isValidLoginId(loginId: String) -> Bool
    
    func isValidNickName(nickName: String) -> Bool
    
    func isValidPassword(password: String) -> Bool
    
    func signUp(email: String, emailCode: String, loginId: String, password: String, nickName: String, memberType: String, completion: @escaping (SignUpRes) -> Void)
    
    func findId(emailCode: String) -> AnyPublisher<String, ErrorResponse>
    
    func findPw(newPwDto: NewPwDto) -> AnyPublisher<String, ErrorResponse>
}
