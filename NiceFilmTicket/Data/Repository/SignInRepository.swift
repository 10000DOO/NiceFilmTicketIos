//
//  SignInRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/10.
//

import Foundation
import Moya

class SignInRepository: SignInRepositoryProtocol {
    
    private let provider = MoyaProvider<SignInAPI>()
    
    func signIn(signInReq: SignInReq, completion: @escaping (Result<SignInResponse, ErrorResponse>) -> Void) {
        provider.request(.signIn(signInReq: signInReq)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let signInRes = try response.map(SignInResponse.self)
                        completion(.success(signInRes))
                    } catch {
                        completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                case 400...499:
                    do {
                        let signInErrorRes = try response.map(ErrorResponse.self)
                        completion(.failure(signInErrorRes))
                    } catch {
                        completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                default:
                    completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            case let .failure(error):
                if case let .statusCode(response) = error,
                   500...599 ~= response.statusCode {
                    do {
                        let signInErrorRes = try response.map(ErrorResponse.self)
                        completion(.failure(signInErrorRes))
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
