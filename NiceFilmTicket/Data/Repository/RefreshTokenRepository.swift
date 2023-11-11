//
//  RefreshTokenRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/16.
//

import Foundation
import CombineMoya
import Moya
import Combine

class RefreshTokenRepository: RefreshTokenRepositoryProtocol {
    
    private let provider = MoyaProvider<RefreshTokenAPI>()
    
    func getNewToken() -> AnyPublisher<SignInResponse, ErrorResponse> {
            return provider.requestPublisher(.refreshToken)
                .tryMap { response in
                    switch response.statusCode {
                    case 200...299:
                        return try response.map(SignInResponse.self)
                    case 400...499:
                        let expiredToken = try response.map(CommonSuccessRes.self)
                        throw ErrorResponse(status: 401, error: [ErrorDetail(error: expiredToken.data)])
                    default:
                        throw ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])
                    }
                }
                .mapError { error in
                    if case let MoyaError.statusCode(response) = error,
                       500...599 ~= response.statusCode {
                        do {
                            return try response.map(ErrorResponse.self)
                        } catch {}
                    }
                    return error as? ErrorResponse ?? ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])
                }
                .eraseToAnyPublisher()
        }
}

