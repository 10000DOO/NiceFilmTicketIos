//
//  FindIdPwRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import Foundation
import Combine

protocol FindIdPwRepositoryProtocol {
    func findId(emailCode: String) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}
