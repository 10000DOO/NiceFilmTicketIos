//
//  EmailService.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation

class EmailService: EmailServiceProtocol {
    
    let emailRepository: EmailRepositoryProtocol
    
    init(emailRepository: EmailRepositoryProtocol) {
        self.emailRepository = emailRepository
    }
    
    func sendEmail(email: String, completion: @escaping (String) -> Void) {
        if isEmailValid(email: email) {
            let emailSendingReq = EmailSendingReq(email: email)
            emailRepository.sendEmail(email: emailSendingReq){ result in
                switch result {
                case .success(_):
                    print("이메일 발송 성공")
                    completion("")
                case .failure(let error):
                    switch error.status {
                    case 400:
                        print("잘못된 형식의 이메일")
                        completion(ErrorMessage.wrongEmailPattern.message)
                    case 500:
                        print("이메일 발송 실패")
                        completion(ErrorMessage.serverError.message)
                    default:
                        print("이메일 발송 실패")
                        completion(ErrorMessage.serverError.message)
                    }
                }
            }
        } else {
            print(ErrorMessage.wrongEmailPattern.message)
            completion(ErrorMessage.wrongEmailPattern.message)
        }
        
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func emailDuplicateCheck(email: String, completion: @escaping (String) -> Void) {
        if isEmailValid(email: email) {
            emailRepository.emailDuplicateCheck(email: email) { result in
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
}

