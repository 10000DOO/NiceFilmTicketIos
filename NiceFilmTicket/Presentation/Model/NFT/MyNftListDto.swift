//
//  MyNftListDto.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/7/23.
//

import Foundation

struct MyNftListDto: Codable {
    let nftList: [NftList]
    let hasNext: Bool
    let isFirst: Bool
    let normalCount: Int
    let rareCount: Int
    let legendCount: Int
}

struct NftList: Codable {
    let leftPoster: String
    let leftMovieTitle: String
    let leftNftLevel: String
    let leftNftSerialnum: String
    let rightPoster: String?
    let rightMovieTitle: String?
    let rightNftLevel: String?
    let rightNftSerialnum: String?
}
