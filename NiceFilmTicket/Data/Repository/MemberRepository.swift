//
//  MemberRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Moya
import Combine
import CombineMoya

class MemberRepository: MemberRepositoryProtocol {
    
    private let provider = MoyaProvider<MemberAPI>()
    
    func signIn(signInReq: SignInReq, memberType: String, completion: @escaping (Result<SignInResponse, ErrorResponse>) -> Void) {
        provider.request(.signIn(signInReq: signInReq, memberType: memberType)) { result in
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
    
    func emailDuplicateCheck(email: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        provider.request(.emailDuplicateTest(email: email)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(CommonSuccessRes.self)
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
            case let .failure(error):
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
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        provider.request(.loginIdDuplicateTest(loginId: loginId)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(CommonSuccessRes.self)
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
            case let .failure(error):
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
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        provider.request(.nickNameDuplicateTest(nickName: nickName)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(CommonSuccessRes.self)
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
            case let .failure(error):
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
    
    func signUp(signUpReq: SignUpReq, emailCode: String, memberType: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        provider.request(.signUpReq(signUpReq: signUpReq, emailCode: emailCode, memberType: memberType)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(CommonSuccessRes.self)
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
                if case .statusCode(let response) = error,
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
    
    func findId(emailCode: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return provider.requestPublisher(.findId(emailCode: emailCode))
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
    
    func findPw(newPwDto: NewPwDto) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return provider.requestPublisher(.findPw(newPwDto: newPwDto))
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
