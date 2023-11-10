//
//  FindIdPwServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import Foundation
import Combine

protocol FindIdPwServiceProtocol {
    func drawNft(emailCode: String) -> AnyPublisher<String, ErrorResponse>
}
