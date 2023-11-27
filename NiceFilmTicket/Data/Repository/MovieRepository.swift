//
//  MovieRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Moya
import Combine
import CombineMoya

class MovieRepository : MovieRepositoryProtocol {
    
    private let provider = MoyaProvider<MovieAPI>()
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetail, ErrorResponse> {
        return provider.requestPublisher(.getMovieDetail(id: id))
            .tryMap { response in
                switch response.statusCode {
                case 200...299:
                    return try response.map(MovieDetail.self)
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
    
    func buyNft(id: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return provider.requestPublisher(.buyMovie(id: id))
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
    
    func getMovies(sortType: String, page: Int, size: Int) -> AnyPublisher<MovieListResponse, ErrorResponse> {
        return provider.requestPublisher(.getMovies(sortType: sortType, page: page, size: size))
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
