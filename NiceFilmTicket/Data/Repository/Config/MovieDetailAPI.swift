//
//  MovieDetailAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/25/23.
//

import Foundation
import Moya

enum MovieDetailAPI{
    case getMovieDetail(id: Int)
    case buyMovie(id: Int)
}

extension MovieDetailAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .getMovieDetail(let id):
            return "/movie/detail/\(id)"
        case .buyMovie(let id):
            return "/nft/buy/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieDetail:
            return .get
        case .buyMovie:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getMovieDetail:
            return .requestPlain
        case .buyMovie:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
