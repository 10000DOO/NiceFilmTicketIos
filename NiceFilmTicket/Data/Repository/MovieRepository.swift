//
//  MovieRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Alamofire
import Combine

class MovieRepository : MovieRepositoryProtocol {
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetail, ErrorResponse> {
        return Future<MovieDetail, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/movie/detail/\(id)",
                       method: .get,
                       headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let movieDetailResponse = try JSONDecoder().decode(MovieDetail.self, from: data)
                        promise(.success(movieDetailResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func buyNft(id: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/nft/buy/\(id)",
                       method: .post,
                       headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let buyNFTResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(buyNFTResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getMovies(sortType: String, page: Int, size: Int) -> AnyPublisher<MovieListResponse, ErrorResponse> {
        return Future<MovieListResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/movie",
                       method: .get,
                       parameters: ["sortType": sortType, "page": String(page), "size": String(size)],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let moviesResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
                        promise(.success(moviesResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func searchMovie(page: Int, size: Int, movieTitle: String) -> AnyPublisher<MovieListResponse, ErrorResponse> {
        return Future<MovieListResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/movie/search",
                       method: .get,
                       parameters: ["page": String(page), "size": String(size), "movieTitle": movieTitle],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let searchMovieResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
                        promise(.success(searchMovieResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
}
