//
//  DrawNftRes.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/5/23.
//

import Foundation

struct DrawNftRes: Codable {
    let status: Int
    let data: NewNftData
}

struct NewNftData: Codable {
    let nftLevel: String
    let mediaUrl: String
    let movieName: String
}
