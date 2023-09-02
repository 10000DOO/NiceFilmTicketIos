//
//  ErrorMessage.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/31.
//

import Foundation

enum ErrorMessage: String {
    case wrongEmailPattern = "잘못된 이메일 형식입니다."
    case serverError = "잠시 후 서비스 이용 부탁드립니다."
    
    var message: String {
        return rawValue
    }
}
