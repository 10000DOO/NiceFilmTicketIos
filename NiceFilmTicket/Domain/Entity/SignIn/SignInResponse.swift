//
//  SignInResponse.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/10.
//

import Foundation

struct SignInResponse: Codable {
    let status: Int
    let data: TokenInfo
}

struct TokenInfo: Codable {
    let grantType: String
    let username: String
    let accessToken: String
    let refreshToken: String
}
