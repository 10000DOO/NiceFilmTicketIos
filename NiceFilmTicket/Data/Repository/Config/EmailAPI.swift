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
    case emailDuplicateTest(email: String)
}

extension EmailAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .sendEmail:
            return "/email"
        case .emailDuplicateTest:
            return "/member/check/email"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendEmail:
            return .post
        case .emailDuplicateTest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .sendEmail(let emailSendingReq):
            return .requestJSONEncodable(emailSendingReq)
        case .emailDuplicateTest(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
