//
//  RefreshTokenAPI.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/16.
//

import Foundation
import Moya

enum RefreshTokenAPI{
    case refreshToken
}

extension RefreshTokenAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .refreshToken:
            return "/token/issue"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .refreshToken:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .refreshToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!, "refreshToken" : UserDefaults.standard.string(forKey: "refreshToken")!]
    }
}
