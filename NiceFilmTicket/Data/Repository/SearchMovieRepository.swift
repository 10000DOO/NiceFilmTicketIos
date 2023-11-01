//
//  SearchMovieRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/29/23.
//

import Foundation
import Moya
import Combine
import CombineMoya

class SearchMovieRepository: SearchMovieRepositoryProtocol {
    
    private let provider = MoyaProvider<SearchMovieAPI>()
    
    func searchMovie(page: Int, size: Int, movieTitle: String) -> AnyPublisher<MovieListResponse, ErrorResponse> {
        return provider.requestPublisher(.searchMovie(page: page, size: size, movieTitle: movieTitle))
            .tryMap { response in
                switch response.statusCode {
                case 200...299:
                    return try response.map(MovieListResponse.self)
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
