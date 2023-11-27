//
//  FindPwResultViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/12/23.
//

import Foundation
import Combine

class FindPwResultViewModel {
    
    private let memberService: MemberServiceProtocol
    @Published var password = ""
    @Published var passwordError = ""
    @Published var passwordCheck = ""
    @Published var passwordCheckError = ""
    @Published var newPwError = ""
    @Published var newPwSuccess = false
    var cancellables = Set<AnyCancellable>()
    
    init(memberService: MemberServiceProtocol) {
        self.memberService = memberService
    }
    
    func passwordPatternCheck(password: String) {
        memberService.passwordPatternCheck(password: password) { [weak self] message in
            self?.passwordError = message
        }
    }
    
    func subscribeToPasswordError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $passwordError.sink { passwordError in
            completion(passwordError)
        }.store(in: &store)
    }
    
    func passwordMatching(password: String, passwordForCheck: String) {
        memberService.passwordMatchingCheck(password: password, passwordForCheck: passwordForCheck) { [weak self] message in
            self?.passwordCheckError = message
        }
    }
    
    func subscribeToPasswordMatchingError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $passwordCheckError.sink { passwordMatchingError in
            completion(passwordMatchingError)
        }.store(in: &store)
    }
    
    func findPw(newPwDto: NewPwDto) {
        memberService.findPw(newPwDto: newPwDto)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.newPwError = error.error.first!.error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                self?.newPwSuccess = true
            }.store(in: &self.cancellables)
    }
    
    func subscribeToNewPwError(store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $newPwError.sink { error in
            completion(error)
        }.store(in: &store)
    }
    
    func subscribeToNewPwSuccess(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $newPwSuccess.sink { result in
            completion(result)
        }.store(in: &store)
    }
}
