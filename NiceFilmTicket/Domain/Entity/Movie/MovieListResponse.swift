//
//  MovieListResponse.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/20/23.
//

import Foundation

struct MovieListResponse: Codable {
    let status: Int
    let data: MovieListData
}

struct MovieListData: Codable {
    let movieListDtos: [MovieDto]
    let hasNext: Bool
    let isFirst: Bool
}

struct MovieDto: Codable {
    let id: Int
    let poster: String
    let movieTitle: String
}
