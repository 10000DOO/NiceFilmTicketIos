//
//  DrawNftRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/5/23.
//

import Foundation
import Combine
import Moya

protocol DrawNftRepositoryProtocol {
    
    func drawNft(drawNftReq: DrawNftReq) -> AnyPublisher<DrawNftRes, ErrorResponse>
}
