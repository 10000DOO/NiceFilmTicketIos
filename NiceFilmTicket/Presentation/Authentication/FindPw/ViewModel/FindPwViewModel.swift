//
//  FindPwViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import Foundation
import Combine

class FindPwViewModel: ObservableObject{
    
    private let emailService: EmailServiceProtocol
    private let findIdPwService: FindIdPwServiceProtocol
    @Published var errorMessage = ""
    @Published var checkCodeSuccess = false
    var cancellables = Set<AnyCancellable>()
    
    init(emailService: EmailServiceProtocol, findIdPwService: FindIdPwServiceProtocol) {
        self.emailService = emailService
        self.findIdPwService = findIdPwService
    }
    
    func sendEmailCode(email: String) {
        emailService.sendEmail(email: email) { result in }
    }
    
    func checkEmailCode(emailCode: String) {
        emailService.checkCode(emailCode: emailCode)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.error.first!.error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                self?.checkCodeSuccess = true
            }.store(in: &self.cancellables)
    }
    
    func updateErrorMessage(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $errorMessage
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
    
    func updateCode(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $checkCodeSuccess
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
}
