//
//  DrawNftService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/5/23.
//

import Foundation
import Combine

class DrawNftService: DrawNftServiceProtocol {
    
    private let drawNftRepository: DrawNftRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(drawNftRepository: DrawNftRepositoryProtocol) {
        self.drawNftRepository = drawNftRepository
    }
    
    func drawNft(firstNft: NFTPickDto, secondNft: NFTPickDto, thirdNft: NFTPickDto) -> AnyPublisher<NewNftData, ErrorResponse> {
        let drawNftReq = DrawNftReq(nftSerialnum1: firstNft.nftSerialnum, nftLevel1: firstNft.nftLevel, nftSerialnum2: secondNft.nftSerialnum, nftLevel2: secondNft.nftLevel, nftSerialnum3: thirdNft.nftSerialnum, nftLevel3: thirdNft.nftLevel)
        return Future<NewNftData, ErrorResponse> { [weak self] promise in
            self?.drawNftRepository.drawNft(drawNftReq: drawNftReq)
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
