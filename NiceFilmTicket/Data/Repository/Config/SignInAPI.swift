//
//  SignInAPI.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/10.
//

import Foundation
import Moya

enum SignInAPI{
    case signIn(signInReq: SignInReq)
}

extension SignInAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/signin"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let signInReq):
            return .requestJSONEncodable(signInReq)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
