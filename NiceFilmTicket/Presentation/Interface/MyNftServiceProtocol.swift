//
//  MyNftServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import Foundation
import Combine

protocol MyNftServiceProtocol {
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTInfo, ErrorResponse>
}
