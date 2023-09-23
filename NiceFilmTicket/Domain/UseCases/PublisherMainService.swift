//
//  PublisherNftsService.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/15.
//

import Foundation

class PublisherMainService: PublisherMainServiceProtocol {
    
    private let publisherMainRepository: PublisherMainRepositoryProtocol

    init(publisherMainRepository: PublisherMainRepositoryProtocol) {
        self.publisherMainRepository = publisherMainRepository
    }
    
    func getNfts(page: Int, size: Int, completion: @escaping (Result<NFTResponse, ErrorResponse>) -> Void) {
        publisherMainRepository.getNfts(page: page, size: size) { result in
            switch result {
            case .success(let response):
                if response.data.nftListDtos.isEmpty {
                    return
                }
                completion(.success(response.data))
            case .failure(let error):
                switch error.status {
                case 400...499:
                    completion(.failure(ErrorResponse(status: 401, error: [ErrorDetail(error: error.error[0].error)])))
                default: break
                }
            }
        }
    }
}
