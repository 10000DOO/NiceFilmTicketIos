//
//  MovieRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetail, ErrorResponse>
    
    func buyNft(id: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func getMovies(sortType: String, page: Int, size: Int) -> AnyPublisher<MovieListResponse, ErrorResponse>
    
    func searchMovie(page: Int, size: Int, movieTitle: String) -> AnyPublisher<MovieListResponse, ErrorResponse>
}
