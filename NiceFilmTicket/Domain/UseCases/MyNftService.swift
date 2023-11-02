//
//  MyNftService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import Foundation
import Combine

class MyNftService: MyNftServiceProtocol {
    
    private let myNftRepository: MyNftRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(myNftRepository: MyNftRepositoryProtocol) {
        self.myNftRepository = myNftRepository
    }
    
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTInfo, ErrorResponse> {
        return Future<NFTInfo, ErrorResponse> { [weak self] promise in
            self?.myNftRepository.getMyNft(username: username, page: page, size: size)
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
