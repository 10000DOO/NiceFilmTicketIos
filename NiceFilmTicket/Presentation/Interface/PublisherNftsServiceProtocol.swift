//
//  PublisherNftsServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/15.
//

import Foundation

protocol PublisherMainServiceProtocol {
    
    func getNfts(username: String, page: Int, size: Int, completion: @escaping (Result<NFTResponse, ErrorResponse>) -> Void)
}
