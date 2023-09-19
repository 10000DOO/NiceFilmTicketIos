//
//  PublisherMainAPI.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/15.
//

import Foundation
import Moya

enum PublisherMainAPI{
    case getNfts(page: Int, size: Int)
}

extension PublisherMainAPI: TargetType {
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
        case .getNfts(let page, let size):
            return .requestParameters(parameters: ["sortType": "최신순", "page": page, "size": size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
