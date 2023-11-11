//
//  MyNftRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import Foundation
import Moya
import Combine
import CombineMoya

class MyNftRepository: MyNftRepositoryProtocol {
    
    private let provider = MoyaProvider<MyNftAPI>()
    
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTData, ErrorResponse> {
        return provider.requestPublisher(.getMyNft(username: username, page: page, size: size))
            .tryMap { response in
                switch response.statusCode {
                case 200...299:
                    return try response.map(NFTData.self)
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
