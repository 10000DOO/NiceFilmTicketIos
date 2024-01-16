//
//  RefreshTokenRepository.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/16.
//

import Foundation
import Alamofire
import Combine

class RefreshTokenRepository: RefreshTokenRepositoryProtocol {
    func getNewToken() -> AnyPublisher<SignInResponse, ErrorResponse> {
        return Future<SignInResponse, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/token/issue",
                       method: .get,
                       headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!, "refreshToken" : UserDefaults.standard.string(forKey: "refreshToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let issuedToken = try JSONDecoder().decode(SignInResponse.self, from: data)
                        promise(.success(issuedToken))
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
