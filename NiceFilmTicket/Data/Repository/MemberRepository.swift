//
//  MemberRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine
import Alamofire

class MemberRepository: MemberRepositoryProtocol {
    
    func signIn(signInReq: SignInReq, memberType: String, completion: @escaping (Result<SignInResponse, ErrorResponse>) -> Void) {
        let url = URLComponents(string: ServerInfo.serverURL + "/signin")!
        var components = url
        components.queryItems = [URLQueryItem(name: "role", value: memberType)]
        
        AF.request(components.url!,
                   method: .post,
                   parameters: signInReq,
                   encoder: JSONParameterEncoder.default,
                   headers: ["Content-Type": "application/json"])
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: data)
                    completion(.success(signInResponse))
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(errorResponse))
                    } else {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        completion(.failure(defaultError))
                    }
                }
            case .failure(let error):
                let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                completion(.failure(customError))
            }
        }
    }
    
    
    func emailDuplicateCheck(email: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        AF.request(ServerInfo.serverURL + "/member/check/email",
                   method: .get,
                   parameters: ["email": email],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: ["Content-Type": "application/json"])
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let emailDuplicateCheckRes = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                    completion(.success(emailDuplicateCheckRes))
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(errorResponse))
                    } else {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        completion(.failure(defaultError))
                    }
                }
            case .failure(let error):
                let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                completion(.failure(customError))
            }
        }
    }
    
    func loginIdDuplicateCheck(loginId: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        AF.request(ServerInfo.serverURL + "/member/check/loginid",
                   method: .get,
                   parameters: ["loginid": loginId],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: ["Content-Type": "application/json"])
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let loginIdDuplicateCheckRes = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                    completion(.success(loginIdDuplicateCheckRes))
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(errorResponse))
                    } else {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        completion(.failure(defaultError))
                    }
                }
            case .failure(let error):
                let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                completion(.failure(customError))
            }
        }
    }
    
    func nickNameDuplicateCheck(nickName: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        AF.request(ServerInfo.serverURL + "/member/check/username",
                   method: .get,
                   parameters: ["username": nickName],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: ["Content-Type": "application/json"])
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let nickNameDuplicateCheckRes = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                    completion(.success(nickNameDuplicateCheckRes))
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(errorResponse))
                    } else {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        completion(.failure(defaultError))
                    }
                }
            case .failure(let error):
                let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                completion(.failure(customError))
            }
        }
    }
    
    func signUp(signUpReq: SignUpReq, emailCode: String, memberType: String, completion: @escaping (Result<CommonSuccessRes, ErrorResponse>) -> Void) {
        let url = URLComponents(string: ServerInfo.serverURL + "/signup")!
        var components = url
        components.queryItems = [URLQueryItem(name: "code", value: emailCode), URLQueryItem(name: "role", value: memberType)]
        
        AF.request(components.url!,
                   method: .post,
                   parameters: signUpReq,
                   encoder: JSONParameterEncoder.default,
                   headers: ["Content-Type": "application/json"])
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let signUpResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                    completion(.success(signUpResponse))
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(errorResponse))
                    } else {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        completion(.failure(defaultError))
                    }
                }
            case .failure(let error):
                let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                completion(.failure(customError))
            }
        }
    }
    
    func findId(emailCode: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/find/id",
                       method: .get,
                       parameters: ["code" : emailCode],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let findIdRes = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(findIdRes))
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
    
    func findPw(newPwDto: NewPwDto) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/find/pw",
                       method: .post,
                       parameters: newPwDto,
                       encoder: JSONParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let findPwResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(findPwResponse))
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
