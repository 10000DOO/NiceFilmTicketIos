//
//  MyNftRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import Foundation
import Combine
import Moya

protocol MyNftRepositoryProtocol {
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTData, ErrorResponse>
}
