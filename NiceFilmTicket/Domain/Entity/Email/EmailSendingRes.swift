//
//  EmailSendingRes.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation

//200 정상
struct EmailSendingRes: Codable {
    var status: Int
    var data: Data
}

struct Data: Codable {
    var target: String
}
