//
//  SearchMovieService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/29/23.
//

import Foundation
import Combine

class SearchMovieService: SearchMovieServiceProtocol {
    
    private let searchMovieRepository: SearchMovieRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(searchMovieRepository: SearchMovieRepositoryProtocol) {
        self.searchMovieRepository = searchMovieRepository
    }
    
    func searchMovie(page: Int, size: Int, movieTitle: String) -> AnyPublisher<MovieListDto, ErrorResponse> {
        return Future<MovieListDto, ErrorResponse> { [weak self] promise in
            self?.searchMovieRepository.searchMovie(page: page, size: size, movieTitle: movieTitle)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(ErrorResponse(status: error.status, error: error.error)))
                    case .finished:
                        break
                    }
                } receiveValue: { response in
                    var movie = [Movie]()
                    if response.data.hasNext {
                        for i in 0..<(response.data.movieListDtos.count - 1) / 2{
                            let data = Movie(leftMovieId: response.data.movieListDtos[i * 2].id, leftMoviePoster: response.data.movieListDtos[i * 2].poster, leftMovieMovieTitle: response.data.movieListDtos[i * 2].movieTitle, rightMovieId: response.data.movieListDtos[(i * 2) + 1].id, rightMoviePoster: response.data.movieListDtos[(i * 2) + 1].poster, rightMovieMovieTitle: response.data.movieListDtos[(i * 2) + 1].movieTitle)
                            movie.append(data)
                        }
                    } else {
                        if response.data.movieListDtos.count % 2 == 1 {
                            for i in 0..<(response.data.movieListDtos.count - 1) / 2{
                                let data = Movie(leftMovieId: response.data.movieListDtos[i * 2].id, leftMoviePoster: response.data.movieListDtos[i * 2].poster, leftMovieMovieTitle: response.data.movieListDtos[i * 2].movieTitle, rightMovieId: response.data.movieListDtos[(i * 2) + 1].id, rightMoviePoster: response.data.movieListDtos[(i * 2) + 1].poster, rightMovieMovieTitle: response.data.movieListDtos[(i * 2) + 1].movieTitle)
                                movie.append(data)
                            }
                            movie.append(Movie(leftMovieId: response.data.movieListDtos[response.data.movieListDtos.count - 1].id,
                                               leftMoviePoster: response.data.movieListDtos[response.data.movieListDtos.count - 1].poster,
                                               leftMovieMovieTitle: response.data.movieListDtos[response.data.movieListDtos.count - 1].movieTitle,
                                               rightMovieId: nil,
                                               rightMoviePoster: nil,
                                               rightMovieMovieTitle: nil))
                        } else {
                            for i in 0..<response.data.movieListDtos.count / 2{
                                let data = Movie(leftMovieId: response.data.movieListDtos[i * 2].id, leftMoviePoster: response.data.movieListDtos[i * 2].poster, leftMovieMovieTitle: response.data.movieListDtos[i * 2].movieTitle, rightMovieId: response.data.movieListDtos[(i * 2) + 1].id, rightMoviePoster: response.data.movieListDtos[(i * 2) + 1].poster, rightMovieMovieTitle: response.data.movieListDtos[(i * 2) + 1].movieTitle)
                                movie.append(data)
                            }
                        }
                    }
                    promise(.success(MovieListDto(movieDto: movie, hasNext: response.data.hasNext, isFirst: response.data.isFirst)))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
}
