//
//  ErrorMessage.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/31.
//

import Foundation

enum ErrorMessage: String {
    case wrongEmailPattern = "잘못된 이메일 입니다."
    case serverError = "잠시 후 서비스 이용 부탁드립니다."
    case duplicateEmail = "이미 존재하는 이메일입니다."
    case availableEmail = "사용 가능한 이메일입니다."
    case duplicateLoginId = "이미 존재하는 아이디입니다."
    case duplicateNickName = "이미 존재하는 닉네임입니다."
    case availableLoginId = "사용 가능한 아이디입니다."
    case availableNickName = "사용 가능한 닉네임입니다."
    case availablePassword = "사용 가능한 비밀번호입니다."
    case wrongLoginIdPattern = "잘못된 아이디 입니다."
    case wrongNickNamePattern = "잘못된 닉네임 입니다."
    case wrongPasswordPattern = "대소문자,숫자,특수문자 포함 8~20자리입니다."
    case passwordMatching = "비밀번호가 일치합니다."
    case passwordNotMatching = "비밀번호가 일치하지 않습니다."
    case emailNotExist = "이메일이 존재하지 않습니다."
    case emailCodeNotExist = "이메일 코드가 존재하지 않습니다."
    case loginIdNotExist = "아이디가 존재하지 않습니다."
    case passwordNotExist = "비밀번호가 존재하지 않습니다."
    case passwordCheckNotExist = "비밀번호 확인이 존재하지 않습니다."
    case nickNameNotExist = "닉네임이 존재하지 않습니다."
    case checkEmailAgain = "이메일을 다시 확인해 주세요."
    case checkEmailCodeAgain = "인증 코드를 다시 확인해 주세요."
    case checkLoginIdAgain = "아이디를 다시 확인해 주세요."
    case checkPasswordAgain = "비밀번호를 다시 확인해 주세요."
    case checkNickNameAgain = "닉네임을 다시 확인해 주세요."
    case signInSuccess = "로그인 성공했습니다."
    case signInFail = "아이디 비밀번호를 다시 확인해 주세요."
    case expiredToken = "만료된 토큰입니다."
    case expiredRefreshToken = "토큰이 만료 되었습니다. 다시 로그인 해주세요."
    case reIssueToken = "토큰 재발급 완료."
    
    var message: String {
        return rawValue
    }
}
