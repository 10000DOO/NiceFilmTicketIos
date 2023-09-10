//
//  SignUpReq.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/07.
//

import Foundation

struct SignUpReq: Codable {
    let loginId: String
    let password: String
    let publisherName: String
    let email: String
}
