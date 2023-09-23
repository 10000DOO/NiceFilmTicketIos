//
//  NFTData.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/15.
//

import Foundation

struct NFTList: Codable {
    let status: Int
    let data: NFTResponse
}

struct NFTResponse: Codable {
    let nftListDtos: [NFTItem]
    let hasNext: Bool
    let isFirst: Bool
}

struct NFTItem: Codable {
    let id: Int
    let movieTitle: String
    let nftPrice: Int
    let nftCount: Int
    let nftLevel: String
    let saleStartDate: String
    let saleEndDate: String
}
