//
//  RefreshTokenService.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/16.
//

import Foundation
import Combine

class RefreshTokenService: RefreshTokenServiceProtocol {
    
    private let refreshTokenRepository: RefreshTokenRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(refreshTokenRepository: RefreshTokenRepositoryProtocol) {
        self.refreshTokenRepository = refreshTokenRepository
    }
    
    func issueNewToken() -> AnyPublisher<String, Never> {
        return Future<String, Never> { [weak self] promise in
            self?.refreshTokenRepository.getNewToken()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        if error.error[0].error == ErrorMessage.expiredRefreshToken.message {
                            promise(.success(error.error[0].error))
                        }
                    case .finished:
                        break
                    }
                },
                      receiveValue: { response in
                    UserDefaults.standard.set("Bearer[\(response.data.accessToken)]", forKey: "accessToken")
                    UserDefaults.standard.set("Bearer[\(response.data.refreshToken)]", forKey: "refreshToken")
                    UserDefaults.standard.set(response.data.username, forKey: "username")
                    promise(.success("success"))
                })
                .store(in: &self!.cancellables)
        }
        .eraseToAnyPublisher()
    }
}
