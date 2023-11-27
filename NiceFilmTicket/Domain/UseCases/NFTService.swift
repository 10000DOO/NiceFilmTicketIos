//
//  NFTService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine

class NFTService: NFTServiceProtocol {
    
    private let nftRepository: NFTRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(nftRepository: NFTRepositoryProtocol) {
        self.nftRepository = nftRepository
    }
    
    func drawNft(firstNft: NFTPickDto, secondNft: NFTPickDto, thirdNft: NFTPickDto) -> AnyPublisher<NewNftData, ErrorResponse> {
        let drawNftReq = DrawNftReq(nftSerialnum1: firstNft.nftSerialnum, nftLevel1: firstNft.nftLevel, nftSerialnum2: secondNft.nftSerialnum, nftLevel2: secondNft.nftLevel, nftSerialnum3: thirdNft.nftSerialnum, nftLevel3: thirdNft.nftLevel)
        return Future<NewNftData, ErrorResponse> { [weak self] promise in
            self?.nftRepository.drawNft(drawNftReq: drawNftReq)
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
    
    func actorPatternCheck(actor: String) -> [String]? {
        let actors = actor.components(separatedBy: ", ")

        if !actors.isEmpty {
            return actors
        }
        return nil
    }
    
    func datePatternCheck(date: String) -> Bool {
        // yyyy-MM-dd 형식의 정규 표현식 패턴
        let pattern = #"^\d{4}-\d{2}-\d{2}$"#
        
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: date.utf16.count)
        return regex.firstMatch(in: date, options: [], range: range) != nil
    }
    
    func issueNft(issueNftReq: IssueNFTReq, countNftReq: CountNFTReq, posterImage: [String: Foundation.Data], normalNftImage: [String: Foundation.Data], rareNftImage: [String: Foundation.Data], legendNftImage: [String: Foundation.Data]) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { [weak self] promise in
            self?.nftRepository.registerNft(issueNFTReq: issueNftReq, countNFTReq: countNftReq, poster: posterImage, normal: normalNftImage, rare: rareNftImage, legend: legendNftImage)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(ErrorResponse(status: error.status, error: error.error)))
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    promise(.success(response))
                }).store(in: &self!.cancellables)
                }.eraseToAnyPublisher()
    }
    
    func getNfts(username: String, page: Int, size: Int, completion: @escaping (Result<NFTResponse, ErrorResponse>) -> Void) {
        nftRepository.getNfts(username: username, page: page, size: size) { result in
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
    
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTInfo, ErrorResponse> {
        return Future<NFTInfo, ErrorResponse> { [weak self] promise in
            self?.nftRepository.getMyNft(username: username, page: page, size: size)
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
            self?.nftRepository.getMyNft(username: username, page: page, size: size)
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

