//
//  CountNFTReq.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/05.
//

import Foundation

struct CountNFTReq: Codable {
    let normalCount: Int
    let rareCount: Int
    let legendCount: Int
}
