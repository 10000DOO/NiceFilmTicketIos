//
//  MovieAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Moya

enum MovieAPI{
    case getMovies(sortType: String, page: Int, size: Int)
    case getMovieDetail(id: Int)
    case buyMovie(id: Int)
    case searchMovie(page: Int, size: Int, movieTitle: String)
}

extension MovieAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "/movie"
        case .getMovieDetail(let id):
            return "/movie/detail/\(id)"
        case .buyMovie(let id):
            return "/nft/buy/\(id)"
        case .searchMovie:
            return "/movie/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        case .getMovieDetail:
            return .get
        case .buyMovie:
            return .post
        case .searchMovie:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMovies(let sortType, let page, let size):
            return .requestParameters(parameters: ["sortType": sortType, "page": page, "size": size], encoding: URLEncoding.queryString)
        case .getMovieDetail:
            return .requestPlain
        case .buyMovie:
            return .requestPlain
        case .searchMovie(let page, let size, let movieTitle):
            return .requestParameters(parameters: ["page": page, "size": size, "movieTitle": movieTitle], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
