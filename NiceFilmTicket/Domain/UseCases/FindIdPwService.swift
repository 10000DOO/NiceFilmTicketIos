//
//  FindIdPwService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import Foundation
import Combine

class FindIdPwService: FindIdPwServiceProtocol {
    
    private let findIdPwRepository: FindIdPwRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(findIdPwRepository: FindIdPwRepositoryProtocol) {
        self.findIdPwRepository = findIdPwRepository
    }
    
    func findId(emailCode: String) -> AnyPublisher<String, ErrorResponse> {
        return Future<String, ErrorResponse> { [weak self] promise in
            self?.findIdPwRepository.findId(emailCode: emailCode)
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
            self?.findIdPwRepository.findPw(newPwDto: newPwDto)
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
