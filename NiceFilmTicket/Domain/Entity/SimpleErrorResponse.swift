//
//  SimpleErrorResponse.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import Foundation

struct SimpleErrorResponse: Codable, Error {
    let status: Int
    let error: String
}
