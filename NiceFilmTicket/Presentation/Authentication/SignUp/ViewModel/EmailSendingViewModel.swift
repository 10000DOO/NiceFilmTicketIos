//
//  EmailSendingViewModel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/29.
//

import Foundation
import Combine

class EmailSendingViewModel: ObservableObject {
    
    private let emailService: EmailServiceProtocol
    @Published var email = ""
    @Published var emailError = ""
    
    init(emailService: EmailServiceProtocol) {
        self.emailService = emailService
    }
    
    func sendEmail(email: String) {
        if emailService.isEmailValid(email: email){
            emailService.sendEmail(email: email) { [weak self] status in
                if status == 200{
                    print("이메일 발송 성공")
                    self?.emailError = ""
                } else if status == 400 {
                    let errorMessage: ErrorMessage = .wrongEmailPattern
                    self?.emailError = errorMessage.message // 에러 메시지 설정
                    print(self?.emailError ?? "이메일 발송 실패")
                } else if status == 500{
                    let errorMessage: ErrorMessage = .serverError
                    self?.emailError = errorMessage.message // 에러 메시지 설정
                }
            }
        } else {
            let errorMessage: ErrorMessage = .wrongEmailPattern
            emailError = errorMessage.message // 에러 메시지 설정
            print(emailError)
        }
    }
    
    func subscribeToEmailError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $emailError.sink { emailError in
            completion(emailError)
        }.store(in: &store)
    }
}
