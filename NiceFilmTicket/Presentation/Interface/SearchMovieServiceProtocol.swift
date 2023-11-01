//
//  SearchMovieService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/29/23.
//

import Foundation
import Combine

protocol SearchMovieServiceProtocol {
    
    func searchMovie(page: Int, size: Int, movieTitle: String) -> AnyPublisher<MovieListDto, ErrorResponse>
}
