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
    
    func getMyNftList(username: String, page: Int, size: Int) -> AnyPublisher<MyNftListDto, ErrorResponse> {
        return Future<MyNftListDto, ErrorResponse> { [weak self] promise in
            self?.myNftRepository.getMyNft(username: username, page: page, size: size)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(ErrorResponse(status: error.status, error: error.error)))
                    case .finished:
                        break
                    }
                } receiveValue: { response in
                    var nftList = [NftList]()
                    if response.data.hasNext {
                        for i in 0..<(response.data.nftPickDtos.count - 1) / 2{
                            let data = NftList(leftPoster: response.data.nftPickDtos[i * 2].poster, leftMovieTitle: response.data.nftPickDtos[i * 2].movieTitle, leftNftLevel: response.data.nftPickDtos[i * 2].nftLevel, leftNftSerialnum: response.data.nftPickDtos[i * 2].nftSerialnum, rightPoster: response.data.nftPickDtos[(i * 2) + 1].poster, rightMovieTitle: response.data.nftPickDtos[(i * 2) + 1].movieTitle, rightNftLevel: response.data.nftPickDtos[(i * 2) + 1].nftLevel, rightNftSerialnum: response.data.nftPickDtos[(i * 2) + 1].nftSerialnum)
                            nftList.append(data)
                        }
                    } else {
                        if response.data.nftPickDtos.count % 2 == 1 {
                            for i in 0..<(response.data.nftPickDtos.count - 1) / 2{
                                let data = NftList(leftPoster: response.data.nftPickDtos[i * 2].poster, leftMovieTitle: response.data.nftPickDtos[i * 2].movieTitle, leftNftLevel: response.data.nftPickDtos[i * 2].nftLevel, leftNftSerialnum: response.data.nftPickDtos[i * 2].nftSerialnum, rightPoster: response.data.nftPickDtos[(i * 2) + 1].poster, rightMovieTitle: response.data.nftPickDtos[(i * 2) + 1].movieTitle, rightNftLevel: response.data.nftPickDtos[(i * 2) + 1].nftLevel, rightNftSerialnum: response.data.nftPickDtos[(i * 2) + 1].nftSerialnum)
                                nftList.append(data)
                            }
                            nftList.append(NftList(leftPoster: response.data.nftPickDtos[response.data.nftPickDtos.count - 1].poster, leftMovieTitle: response.data.nftPickDtos[response.data.nftPickDtos.count - 1].movieTitle, leftNftLevel: response.data.nftPickDtos[response.data.nftPickDtos.count - 1].nftLevel, leftNftSerialnum: response.data.nftPickDtos[response.data.nftPickDtos.count - 1].nftSerialnum, rightPoster: nil, rightMovieTitle: nil, rightNftLevel: nil, rightNftSerialnum: nil))
                        } else {
                            for i in 0..<response.data.nftPickDtos.count / 2{
                                let data = NftList(leftPoster: response.data.nftPickDtos[i * 2].poster, leftMovieTitle: response.data.nftPickDtos[i * 2].movieTitle, leftNftLevel: response.data.nftPickDtos[i * 2].nftLevel, leftNftSerialnum: response.data.nftPickDtos[i * 2].nftSerialnum, rightPoster: response.data.nftPickDtos[(i * 2) + 1].poster, rightMovieTitle: response.data.nftPickDtos[(i * 2) + 1].movieTitle, rightNftLevel: response.data.nftPickDtos[(i * 2) + 1].nftLevel, rightNftSerialnum: response.data.nftPickDtos[(i * 2) + 1].nftSerialnum)
                                nftList.append(data)
                            }
                        }
                    }
                    promise(.success(MyNftListDto(nftList: nftList, hasNext: response.data.hasNext, isFirst: response.data.isFirst, normalCount: response.data.normalCount, rareCount: response.data.rareCount, legendCount: response.data.legendCount)))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
}
