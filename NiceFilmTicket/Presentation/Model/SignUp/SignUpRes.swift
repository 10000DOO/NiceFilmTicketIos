//
//  SignUpRes.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/08.
//

import Foundation

struct SignUpRes: Codable {
    var statusCode: Int = 0
    var serverError: String = ""
    var email: String = ""
    var emailCode: String = ""
    var loginId: String = ""
    var password: String = ""
    var nickName: String = ""
}
