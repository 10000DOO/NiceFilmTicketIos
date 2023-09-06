//
//  EmailRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation
import Moya

class EmailRepository: EmailRepositoryProtocol {
    
    private let provider = MoyaProvider<EmailAPI>()
    
    func sendEmail(email: EmailSendingReq, completion: @escaping (Result<EmailSendingRes, ErrorResponse>) -> Void) {
        provider.request(.sendEmail(email: email)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299:
                    do {
                        let emailRes = try response.map(EmailSendingRes.self)
                        completion(.success(emailRes))
                    } catch {
                        print("이메일 발송 성공 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                case 400...499:
                    do {
                        let errorRes = try response.map(ErrorResponse.self)
                        completion(.failure(errorRes))
                    } catch {
                        print("이메일 발송 실패 시 파싱 에러: \(error)")
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
                        print("이메일 발송 실패 시 파싱 에러: \(error)")
                        completion(.failure(ErrorResponse(status: response.statusCode, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                    }
                } else {
                    completion(.failure(ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.message)])))
                }
            }
        }
    }
}