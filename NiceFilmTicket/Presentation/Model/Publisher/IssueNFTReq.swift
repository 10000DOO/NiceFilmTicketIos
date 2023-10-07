//
//  IssueNFTReq.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/05.
//

import Foundation

struct IssueNFTReq: Codable {
    var movieTitle: String
    var movieGenre: String
    var filmRating: String
    var releaseDate: String
    var director: String
    var actors: [String]
    var runningTime: Int
    var normalNFTPrice: Int
    var saleStartDate: String
    var saleEndDate: String
    var overView: String
}
