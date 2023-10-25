//
//  MovieListDto.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/24/23.
//

import Foundation

struct MovieListDto: Codable {
    let movieDto: [Movie]
    let hasNext: Bool
    let isFirst: Bool
}

struct Movie: Codable {
    let leftMovieId: Int
    let leftMoviePoster: String
    let leftMovieMovieTitle: String
    let rightMovieId: Int?
    let rightMoviePoster: String?
    let rightMovieMovieTitle: String?
}
