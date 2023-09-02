//
//  ErrorResponse.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/31.
//

import Foundation

struct ErrorResponse: Codable, Error {
    let status: Int
    let error: [ErrorDetail]
}

struct ErrorDetail: Codable {
    let error: String
}
