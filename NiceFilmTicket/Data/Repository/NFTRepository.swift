//
//  NFTRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import CombineMoya
import Moya
import Combine

class NFTRepository: NFTRepositoryProtocol {
    
    private let provider = MoyaProvider<NftAPI>()
    
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
    
    func getNfts(username: String, page: Int, size: Int, completion: @escaping (Result<NFTList, ErrorResponse>) -> Void) {
        provider.request(.getNfts(username: username, page: page, size: size)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(NFTList.self)
                        completion(.success(result))
                    } catch {
                        completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                case 400...499:
                    do {
                        let result = try response.map(ErrorResponse.self)
                        completion(.failure(result))
                    } catch {
                        completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                default:
                    completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            case .failure(let error):
                if case let .statusCode(response) = error,
                   500...599 ~= response.statusCode {
                    do {
                        let errorRes = try response.map(ErrorResponse.self)
                        completion(.failure(errorRes))
                    } catch {
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                } else {
                    completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            }
        }
    }
}
