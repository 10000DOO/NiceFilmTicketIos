//
//  SignInService.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/10.
//

import Foundation

class SignInService: SignInServiceProtocol {
    
    private let signInRepository: SignInRepositoryProtocol
    
    init(signInRepository: SignInRepositoryProtocol) {
        self.signInRepository = signInRepository
    }
    
    func signIn(loginId: String, password: String, memberType: String, completion: @escaping (String) -> Void) {
        let signInReq = SignInReq(loginId: loginId, password: password)
        signInRepository.signIn(signInReq: signInReq, memberType: memberType) { result in
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
}
