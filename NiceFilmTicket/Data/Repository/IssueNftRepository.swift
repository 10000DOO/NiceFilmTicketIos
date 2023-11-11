//
//  IssueNftRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/06.
//

import Foundation
import CombineMoya
import Moya
import Combine

class IssueNftRepository: IssueNftRepositoryProtocol {
    
    private let provider = MoyaProvider<issueNftAPI>()
    
    func registerNft(issueNFTReq: IssueNFTReq, countNFTReq: CountNFTReq, poster: [String: Foundation.Data], normal: [String: Foundation.Data], rare: [String: Foundation.Data], legend: [String: Foundation.Data]) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return provider.requestPublisher(.issueNft(issueNFTReq: issueNFTReq, countNFTReq: countNFTReq, poster: poster, normal: normal, rare: rare, legend: legend))
            .tryMap { response in
                switch response.statusCode {
                case 200...299:
                    return try response.map(CommonSuccessRes.self)
                case 400...499:
                    throw try response.map(ErrorResponse.self)
                default:
                    throw ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])
                }
            }
            .mapError { error in
                if case let MoyaError.statusCode(response) = error, 500...599 ~= response.statusCode {
                    do {
                        return try response.map(ErrorResponse.self)
                    } catch {}
                }
                return error as? ErrorResponse ?? ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])
            }.eraseToAnyPublisher()
    }
}
