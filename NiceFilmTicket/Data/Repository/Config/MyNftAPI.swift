//
//  MyNftAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import Foundation
import Moya

enum MyNftAPI {
    case getMyNft(username: String, page: Int, size: Int)
}

extension MyNftAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .getMyNft:
            return "/nft/pick/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyNft:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMyNft(let username, let page, let size):
            return .requestParameters(parameters: ["username": username, "page": page, "size": size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
