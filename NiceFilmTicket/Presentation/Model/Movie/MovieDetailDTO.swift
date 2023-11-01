//
//  MovieDetailDTO.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/27/23.
//

import Foundation

struct MovieDataDTO: Codable {
    let publisherName: String
    let movieTitle: String
    let nftLevel: String
    let saleStartTime: String
    let saleEndTime: String
    let runningTime: Int
    let normalNFTPrice: Int
    let director: String
    let actors: String
    let filmRating: String
    let movieGenre: String
    let description: String
    let createdAt: String
    let poster: String
}
