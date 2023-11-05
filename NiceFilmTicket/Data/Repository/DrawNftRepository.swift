//
//  DrawNftRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/3/23.
//

import Foundation
import CombineMoya
import Moya
import Combine

class DrawNftRepository: DrawNftRepositoryProtocol {
    
    private let provider = MoyaProvider<DrawNftAPI>()
    
    func drawNft(drawNftReq: DrawNftReq) -> AnyPublisher<DrawNftRes, ErrorResponse> {
        return provider.requestPublisher(.drawNft(drawNftReq: drawNftReq))
            .tryMap { response in
                switch response.statusCode {
                case 200...299:
                    return try response.map(DrawNftRes.self)
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
