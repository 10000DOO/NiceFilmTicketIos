//
//  EmailRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation
import Alamofire
import Combine

class EmailRepository: EmailRepositoryProtocol {
    
    func sendEmail(email: EmailSendingReq, completion: @escaping (Result<EmailSendingRes, ErrorResponse>) -> Void) {
        AF.request(ServerInfo.serverURL + "/email",
                   method: .post,
                   parameters: email,
                   encoder: JSONParameterEncoder.default,
                   headers: ["Content-Type": "application/json"])
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let emailSendResponse = try JSONDecoder().decode(EmailSendingRes.self, from: data)
                    completion(.success(emailSendResponse))
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
    
    func checkEmailCode(emailCode: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/email/check",
                       method: .post,
                       parameters: ["code" : emailCode],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let codeCheckResponse = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(codeCheckResponse))
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
