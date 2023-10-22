//
//  MovieListServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/20/23.
//

import Foundation
import Combine

protocol MovieListServiceProtocol {
    
    func getMovies(sortType: String, page: Int, size: Int) -> AnyPublisher<MovieListDto, ErrorResponse>
}
