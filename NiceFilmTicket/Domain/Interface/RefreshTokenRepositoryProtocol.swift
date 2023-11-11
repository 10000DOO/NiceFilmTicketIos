//
//  RefreshTokenRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/16.
//

import Foundation
import Combine

protocol RefreshTokenRepositoryProtocol {
    
    func getNewToken() -> AnyPublisher<SignInResponse, ErrorResponse>
}
