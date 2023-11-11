//
//  SignUpService.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/05.
//

import Foundation

class SignUpService: SignUpServiceProtocol {
        
    private let signUpRepository: SignUpRepositoryProtocol
    private let emailService: EmailServiceProtocol
    
    init(signUpRepository: SignUpRepositoryProtocol, emailService: EmailServiceProtocol) {
        self.signUpRepository = signUpRepository
        self.emailService = emailService
    }
    
    func emailDuplicateCheck(email: String, completion: @escaping (String) -> Void) {
        if emailService.isEmailValid(email: email) {
            signUpRepository.emailDuplicateCheck(email: email) { result in
                switch result {
                case .success(_):
                    completion(ErrorMessage.availableEmail.message)
                case .failure(let error):
                    switch error.status {
                    case 400:
                        completion(ErrorMessage.duplicateEmail.message)
                    case 500:
                        completion(ErrorMessage.serverError.message)
                    default:
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            completion(ErrorMessage.wrongEmailPattern.message) // 에러 메시지 설정
        }
    }
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (String) -> Void) {
        if isValidLoginId(loginId: loginId) {
            signUpRepository.loginIdDuplicateCheck(loginId: loginId) { result in
                switch result {
                case .success(_):
                    completion(ErrorMessage.availableLoginId.message)
                case .failure(let error):
                    switch error.status {
                    case 400:
                        completion(ErrorMessage.duplicateLoginId.message)
                    case 500:
                        completion(ErrorMessage.serverError.message)
                    default:
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            completion(ErrorMessage.wrongLoginIdPattern.message) // 에러 메시지 설정
        }
    }
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (String) -> Void) {
        if isValidNickName(nickName: nickName) {
            signUpRepository.nickNameDuplicateCheck(nickName: nickName) { result in
                switch result {
                case .success(_):
                    completion(ErrorMessage.availableNickName.message)
                case .failure(let error):
                    switch error.status {
                    case 400:
                        completion(ErrorMessage.duplicateNickName.message)
                    case 500:
                        completion(ErrorMessage.serverError.message)
                    default:
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            completion(ErrorMessage.wrongNickNamePattern.message) // 에러 메시지 설정
        }
    }
    
    func passwordPatternCheck(password: String, completion: @escaping (String) -> Void) {
        if isValidPassword(password: password) {
            completion(ErrorMessage.availablePassword.message)
        } else {
            completion(ErrorMessage.wrongPasswordPattern.message) // 에러 메시지 설정
        }
    }
    
    func passwordMatchingCheck(password: String, passwordForCheck: String, completion: @escaping (String) -> Void) {
        if password == passwordForCheck {
            completion(ErrorMessage.passwordMatching.message)
        } else {
            completion(ErrorMessage.passwordNotMatching.message) // 에러 메시지 설정
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
    
    func signUp(email: String, emailCode: String, loginId: String, password: String, nickName: String, memberType: String, completion: @escaping (SignUpRes) -> Void) {
        let signUpReq = SignUpReq(loginId: loginId, password: password, username: nickName, email: email)
        signUpRepository.signUp(signUpReq: signUpReq, emailCode: emailCode, memberType: memberType) { result in
            switch result {
            case .success(_):
                var signUpRes = SignUpRes()
                signUpRes.statusCode = 200
                completion(signUpRes)
            case .failure(let error):
                switch error.status {
                case 400:
                    var signUpRes = SignUpRes()
                    signUpRes.statusCode = 400
                    for element in error.error {
                        if element.error.contains("이메일") {
                            signUpRes.email = ErrorMessage.checkEmailAgain.message
                            continue
                        }
                        if element.error.contains("코드") {
                            signUpRes.emailCode = ErrorMessage.checkEmailCodeAgain.message
                            continue
                        }
                        if element.error.contains("아이디") {
                            signUpRes.loginId = ErrorMessage.checkLoginIdAgain.message
                            continue
                        }
                        if element.error.contains("비밀번호") {
                            signUpRes.password = ErrorMessage.checkPasswordAgain.message
                            continue
                        }
                        if element.error.contains("이름") {
                            signUpRes.nickName = ErrorMessage.checkNickNameAgain.message
                            continue
                        }
                    }
                    completion(signUpRes)
                case 500:
                    var signUpRes = SignUpRes()
                    signUpRes.statusCode = 500
                    signUpRes.serverError = ErrorMessage.serverError.message
                    completion(signUpRes)
                default:
                    var signUpRes = SignUpRes()
                    signUpRes.statusCode = 500
                    signUpRes.serverError = ErrorMessage.serverError.message
                    completion(signUpRes)
                }
            }
        }
    }
}
