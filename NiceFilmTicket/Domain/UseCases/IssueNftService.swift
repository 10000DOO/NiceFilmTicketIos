//
//  IssueNftService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/05.
//

import Foundation
import Combine

class IssueNftService: IssueNftServiceProtocol {
    
    private let issueNftRepository: IssueNftRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(issueNftRepository: IssueNftRepositoryProtocol) {
        self.issueNftRepository = issueNftRepository
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
            self?.issueNftRepository.registerNft(issueNFTReq: issueNftReq, countNFTReq: countNftReq, poster: posterImage, normal: normalNftImage, rare: rareNftImage, legend: legendNftImage)
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
}
