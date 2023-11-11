//
//  DrawNftReq.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/3/23.
//

import Foundation

struct DrawNftReq: Codable {
    let nftSerialnum1: String
    let nftLevel1: String
    let nftSerialnum2: String
    let nftLevel2: String
    let nftSerialnum3: String
    let nftLevel3: String
}
