//
//  MovieServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    
    func searchMovie(page: Int, size: Int, movieTitle: String) -> AnyPublisher<MovieListDto, ErrorResponse>
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDataDTO, ErrorResponse>
    
    func buyNFt(id: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func getMovies(sortType: String, page: Int, size: Int) -> AnyPublisher<MovieListDto, ErrorResponse>
}

