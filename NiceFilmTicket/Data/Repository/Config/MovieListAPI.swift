//
//  MovieListAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/20/23.
//

import Foundation
import Moya

enum MovieListAPI{
    case getMovies(sortType: String, page: Int, size: Int)
}

extension MovieListAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMovies(let sortType, let page, let size):
            return .requestParameters(parameters: ["sortType": sortType, "page": page, "size": size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
