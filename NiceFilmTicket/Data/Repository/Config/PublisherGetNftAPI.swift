//
//  PublisherGetNftAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/20/23.
//

import Foundation
import Moya

enum PublisherGetNftAPI{
    case getNfts(username: String, page: Int, size: Int)
}

extension PublisherGetNftAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .getNfts:
            return "/nft"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNfts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getNfts(let username, let page, let size):
            return .requestParameters(parameters: ["sortType": "최신순", "username": username, "page": page, "size": size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
