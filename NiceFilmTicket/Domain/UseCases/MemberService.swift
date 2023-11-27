//
//  MemberService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine

class MemberService: MemberServiceProtocol {
    
    private let memberRepository: MemberRepositoryProtocol
    private let emailService: EmailServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(memberRepository: MemberRepositoryProtocol, emailService: EmailServiceProtocol) {
        self.memberRepository = memberRepository
        self.emailService = emailService
    }
    
    func signIn(loginId: String, password: String, memberType: String, completion: @escaping (String) -> Void) {
        let signInReq = SignInReq(loginId: loginId, password: password)
        memberRepository.signIn(signInReq: signInReq, memberType: memberType) { result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set("Bearer[\(response.data.accessToken)]", forKey: "accessToken")
                UserDefaults.standard.set("Bearer[\(response.data.refreshToken)]", forKey: "refreshToken")
                UserDefaults.standard.set(response.data.username, forKey: "username")
                completion(ErrorMessage.signInSuccess.message)
            case .failure(let error):
                switch error.status {
                case 401:
                    completion(ErrorMessage.signInFail.message)
                case 500:
                    completion(ErrorMessage.serverError.message)
                default:
                    completion(ErrorMessage.serverError.message)
                }
            }
        }
    }
    
    func emailDuplicateCheck(email: String, completion: @escaping (String) -> Void) {
        if emailService.isEmailValid(email: email) {
            memberRepository.emailDuplicateCheck(email: email) { result in
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
            memberRepository.loginIdDuplicateCheck(loginId: loginId) { result in
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
            memberRepository.nickNameDuplicateCheck(nickName: nickName) { result in
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
        memberRepository.signUp(signUpReq: signUpReq, emailCode: emailCode, memberType: memberType) { result in
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
    
    func findId(emailCode: String) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.memberRepository.findId(emailCode: emailCode)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(ErrorResponse(status: error.status, error: error.error)))
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    promise(.success(response.data))
                }).store(in: &self!.cancellables)
                }.eraseToAnyPublisher()
    }
    
    func findPw(newPwDto: NewPwDto) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.memberRepository.findPw(newPwDto: newPwDto)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(ErrorResponse(status: error.status, error: error.error)))
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    promise(.success(response.data))
                }).store(in: &self!.cancellables)
                }.eraseToAnyPublisher()
    }
}
