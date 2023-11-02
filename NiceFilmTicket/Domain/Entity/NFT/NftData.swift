//
//  NftData.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import Foundation

struct NFTData: Codable {
    let status: Int
    let data: NFTInfo
}

struct NFTInfo: Codable {
    let nftPickDtos: [NFTPickDto]
    let hasNext: Bool
    let isFirst: Bool
    let normalCount: Int
    let rareCount: Int
    let legendCount: Int
}

struct NFTPickDto: Codable {
    let poster: String
    let movieTitle: String
    let nftLevel: String
    let nftSerialnum: String
}
