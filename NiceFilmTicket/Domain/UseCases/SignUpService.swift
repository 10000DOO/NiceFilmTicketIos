//
//  SignUpService.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/05.
//

import Foundation

class SignUpService: SignUpServiceProtocol {
        
    let signUpRepository: SignUpRepositoryProtocol
    let emailService: EmailServiceProtocol
    
    init(signUpRepository: SignUpRepositoryProtocol, emailService: EmailServiceProtocol) {
        self.signUpRepository = signUpRepository
        self.emailService = emailService
    }
    
    func emailDuplicateCheck(email: String, completion: @escaping (String) -> Void) {
        if emailService.isEmailValid(email: email) {
            signUpRepository.emailDuplicateCheck(email: email) { result in
                switch result {
                case .success(_):
                    print("중복 X")
                    completion(ErrorMessage.availableEmail.message)
                case .failure(let error):
                    switch error.status {
                    case 400:
                        print("중복된 이메일")
                        completion(ErrorMessage.duplicateEmail.message)
                    case 500:
                        print("이메일 중복 검사 실패")
                        completion(ErrorMessage.serverError.message)
                    default:
                        print("이메일 중복 검사 실패")
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            completion(ErrorMessage.wrongEmailPattern.message) // 에러 메시지 설정
            print(ErrorMessage.wrongEmailPattern.message)
        }
    }
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (String) -> Void) {
        if isValidLoginId(loginId: loginId) {
            signUpRepository.loginIdDuplicateCheck(loginId: loginId) { result in
                switch result {
                case .success(_):
                    print("중복 X")
                    completion(ErrorMessage.availableLoginId.message)
                case .failure(let error):
                    switch error.status {
                    case 400:
                        print("중복된 아이디")
                        completion(ErrorMessage.duplicateLoginId.message)
                    case 500:
                        print("아이디 중복 검사 실패")
                        completion(ErrorMessage.serverError.message)
                    default:
                        print("아이디 중복 검사 실패")
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            completion(ErrorMessage.wrongLoginIdPattern.message) // 에러 메시지 설정
            print(ErrorMessage.wrongLoginIdPattern.message)
        }
    }
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (String) -> Void) {
        if isValidNickName(nickName: nickName) {
            signUpRepository.nickNameDuplicateCheck(nickName: nickName) { result in
                switch result {
                case .success(_):
                    print("중복 X")
                    completion(ErrorMessage.availableNickName.message)
                case .failure(let error):
                    switch error.status {
                    case 400:
                        print("중복된 닉네임")
                        completion(ErrorMessage.duplicateNickName.message)
                    case 500:
                        print("닉네임 중복 검사 실패")
                        completion(ErrorMessage.serverError.message)
                    default:
                        print("닉네임 중복 검사 실패")
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            completion(ErrorMessage.wrongNickNamePattern.message) // 에러 메시지 설정
            print(ErrorMessage.wrongNickNamePattern.message)
        }
    }
    
    func passwordDuplicateCheck(password: String, completion: @escaping (String) -> Void) {
        if isValidPassword(password: password) {
            completion(ErrorMessage.availablePassword.message)
        } else {
            completion(ErrorMessage.wrongPasswordPattern.message) // 에러 메시지 설정
            print(ErrorMessage.wrongPasswordPattern.message)
        }
    }
    
    func isValidLoginId(loginId: String) -> Bool {
        let loginIdRegex = "^.{5,20}$"
        let loginIdPredicate = NSPredicate(format: "SELF MATCHES %@", loginIdRegex)
        return loginIdPredicate.evaluate(with: loginId)
    }
    
    func isValidNickName(nickName: String) -> Bool {
        let nickNameRegex = "^.{1,20}$"
        let nickNamePredicate = NSPredicate(format: "SELF MATCHES %@", nickNameRegex)
        return nickNamePredicate.evaluate(with: nickName)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[-_.~!@<>()$*?])[A-Za-z\\d-_.~!@<>()$*?]{8,20}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}
