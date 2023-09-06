//
//  SignUpRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/06.
//

import Foundation
import Moya

class SignUpRepository: SignUpRepositoryProtocol {
    
    private let provider = MoyaProvider<SignUpAPI>()
    
    func emailDuplicateCheck(email: String, completion: @escaping (Result<SignUpDuplicateTestRes, ErrorResponse>) -> Void) {
        provider.request(.emailDuplicateTest(email: email)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(SignUpDuplicateTestRes.self)
                        completion(.success(result))
                    } catch {
                        print("이메일 중복 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                case 400...499:
                    do {
                        let result = try response.map(ErrorResponse.self)
                        completion(.failure(result))
                    } catch {
                        print("이메일 중복 아닐 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                default:
                    print("Unexpected Error status code: \(response.debugDescription)")
                    completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            case let .failure(error):
                if case let .statusCode(response) = error,
                   500...599 ~= response.statusCode {
                    do {
                        let errorRes = try response.map(ErrorResponse.self)
                        completion(.failure(errorRes))
                    } catch {
                        print("이메일 중복체크 실패 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                } else {
                    completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            }
        }
    }
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (Result<SignUpDuplicateTestRes, ErrorResponse>) -> Void) {
        provider.request(.loginIdDuplicateTest(loginId: loginId)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(SignUpDuplicateTestRes.self)
                        completion(.success(result))
                    } catch {
                        print("아이디 중복 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                case 400...499:
                    do {
                        let result = try response.map(ErrorResponse.self)
                        completion(.failure(result))
                    } catch {
                        print("아이디 중복 아닐 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                default:
                    print("Unexpected Error status code: \(response.debugDescription)")
                    completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            case let .failure(error):
                if case let .statusCode(response) = error,
                   500...599 ~= response.statusCode {
                    do {
                        let errorRes = try response.map(ErrorResponse.self)
                        completion(.failure(errorRes))
                    } catch {
                        print("아이디 중복체크 실패 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                } else {
                    completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            }
        }
    }
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (Result<SignUpDuplicateTestRes, ErrorResponse>) -> Void) {
        provider.request(.nickNameDuplicateTest(nickName: nickName)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let result = try response.map(SignUpDuplicateTestRes.self)
                        completion(.success(result))
                    } catch {
                        print("닉네임 중복 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                case 400...499:
                    do {
                        let result = try response.map(ErrorResponse.self)
                        completion(.failure(result))
                    } catch {
                        print("닉네임 중복 아닐 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                default:
                    print("Unexpected Error status code: \(response.debugDescription)")
                    completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            case let .failure(error):
                if case let .statusCode(response) = error,
                   500...599 ~= response.statusCode {
                    do {
                        let errorRes = try response.map(ErrorResponse.self)
                        completion(.failure(errorRes))
                    } catch {
                        print("닉네임 중복체크 실패 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                } else {
                    completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            }
        }
    }
}
