//
//  MovieListRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/20/23.
//

import Foundation
import Combine
import Moya

protocol MovieListRepositoryProtocol {
    
    func getMovies(sortType: String, page: Int, size: Int) -> AnyPublisher<MovieListResponse, ErrorResponse>
}
