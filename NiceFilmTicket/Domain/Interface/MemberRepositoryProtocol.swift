//
//  MemberRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine
import Moya

protocol MemberRepositoryProtocol {
    func signIn(signInReq: SignInReq, memberType: String, completion: @escaping (Result<SignInResponse, ErrorResponse>) -> Void)
    
    func emailDuplicateCheck(email: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
    
    func signUp(signUpReq: SignUpReq, emailCode: String, memberType: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void)
    
    func findId(emailCode: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func findPw(newPwDto: NewPwDto) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}
