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
    case findPw(newPwDto: NewPwDto)
}

extension FindIdPwAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .findId:
            return "/find/id"
        case .findPw:
            return "/find/pw"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .findId:
            return .get
        case .findPw:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .findId(let emailCode):
            return .requestParameters(parameters: ["code": emailCode], encoding: URLEncoding.queryString)
        case .findPw(let newPwDto):
            return .requestJSONEncodable(newPwDto)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
