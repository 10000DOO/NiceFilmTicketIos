//
//  DrawNftAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/3/23.
//

import Foundation
import Moya

enum DrawNftAPI {
    case drawNft(drawNftReq: DrawNftReq)
}

extension DrawNftAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .drawNft:
            return "/nft/pick"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .drawNft:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .drawNft(let drawNftReq):
            return .requestJSONEncodable(drawNftReq)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
