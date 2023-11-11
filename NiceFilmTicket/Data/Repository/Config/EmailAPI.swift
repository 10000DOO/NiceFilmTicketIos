//
//  EmailRepoConfig.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/30.
//

import Foundation
import Moya

enum EmailAPI{
    case sendEmail(email: EmailSendingReq)
    case checkCode(emailCode: String)
}

extension EmailAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .sendEmail:
            return "/email"
        case .checkCode:
            return "/email/check"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendEmail:
            return .post
        case .checkCode:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendEmail(let emailSendingReq):
            return .requestJSONEncodable(emailSendingReq)
        case .checkCode(let emailCode):
            return .requestParameters(parameters: ["code": emailCode], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
