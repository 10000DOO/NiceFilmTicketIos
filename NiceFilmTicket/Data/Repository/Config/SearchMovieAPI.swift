//
//  SearchMovieAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/29/23.
//

import Foundation
import Moya

enum SearchMovieAPI{
    case searchMovie(page: Int, size: Int, movieTitle: String)
}

extension SearchMovieAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/movie/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchMovie:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchMovie(let page, let size, let movieTitle):
            return .requestParameters(parameters: ["page": page, "size": size, "movieTitle": movieTitle], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
