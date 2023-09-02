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
}

extension EmailAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .sendEmail:
            return "/email"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendEmail:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendEmail(let emailSendingReq):
            return .requestJSONEncodable(emailSendingReq)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
