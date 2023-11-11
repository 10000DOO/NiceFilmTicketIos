//
//  FindIdPwServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import Foundation
import Combine

protocol FindIdPwServiceProtocol {
    func findId(emailCode: String) -> AnyPublisher<String, ErrorResponse>
    
    func findPw(newPwDto: NewPwDto) -> AnyPublisher<String, ErrorResponse>
}
