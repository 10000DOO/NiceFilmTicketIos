//
//  PublisherMainRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/15.
//

import Foundation
import Moya

class PublisherMainRepository: PublisherMainRepositoryProtocol {
    
    private let provider = MoyaProvider<PublisherGetNftAPI>()
    
    func getNfts(page: Int, size: Int, completion: @escaping (Result<NFTList, ErrorResponse>) -> Void) {
        provider.request(.getNfts(page: page, size: size)) { result in
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

