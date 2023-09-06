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
    case duplicateEmail = "이미 존재하는 이메일입니다."
    case availableEmail = "사용 가능한 이메일입니다."
    case duplicateLoginId = "이미 존재하는 아이디입니다."
    case duplicateNickName = "이미 존재하는 닉네임입니다."
    case availableLoginId = "사용 가능한 아이디입니다."
    case availableNickName = "사용 가능한 닉네임입니다."
    case availablePassword = "사용 가능한 비밀번호입니다."
    case wrongLoginIdPattern = "잘못된 아이디 형식입니다."
    case wrongNickNamePattern = "잘못된 닉네임 형식입니다."
    case wrongPasswordPattern = "대소문자,숫자,특수문자 포함 8~20자리입니다."
    case passwordMatching = "비밀번호가 일치합니다."
    case passwordNotMatching = "비밀번호가 일치하지 않습니다."
    
    var message: String {
        return rawValue
    }
}
