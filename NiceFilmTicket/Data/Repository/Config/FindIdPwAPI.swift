//
//  FindIdPwAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import Foundation
import Moya

enum FindIdPwAPI{
    case findId(emailCode: String)
}

extension FindIdPwAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .findId:
            return "/find/id"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .findId:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .findId(let emailCode):
            return .requestParameters(parameters: ["code": emailCode], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
