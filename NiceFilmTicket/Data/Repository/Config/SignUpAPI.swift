//
//  SignUpAPI.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/06.
//

import Foundation
import Moya

enum SignUpAPI{
    case loginIdDuplicateTest(loginId: String)
    case emailDuplicateTest(email: String)
    case nickNameDuplicateTest(nickName: String)
}

extension SignUpAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .loginIdDuplicateTest:
            return "/member/check/loginid"
        case .emailDuplicateTest:
            return "/member/check/email"
        case .nickNameDuplicateTest:
            return "/member/check/username"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginIdDuplicateTest:
            return .get
        case .emailDuplicateTest:
            return .get
        case .nickNameDuplicateTest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .loginIdDuplicateTest(let loginId):
            return .requestParameters(parameters: ["loginid": loginId], encoding: URLEncoding.queryString)
        case .emailDuplicateTest(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .nickNameDuplicateTest(let nickName):
            return .requestParameters(parameters: ["username": nickName], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
