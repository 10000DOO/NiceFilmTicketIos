//
//  MovieService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine

class MovieService: MovieServiceProtocol {
    
    private let movieRepository: MovieRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func searchMovie(page: Int, size: Int, movieTitle: String) -> AnyPublisher<MovieListDto, ErrorResponse> {
        return Future<MovieListDto, ErrorResponse> { [weak self] promise in
            self?.movieRepository.searchMovie(page: page, size: size, movieTitle: movieTitle)
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
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDataDTO, ErrorResponse> {
        return Future<MovieDataDTO, ErrorResponse> { [weak self] promise in
            self?.movieRepository.getMovieDetails(id: id)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(ErrorResponse(status: error.status, error: error.error)))
                    case .finished:
                        break
                    }
                } receiveValue: { response in
                    let endIndex = response.data.createdAt.index(response.data.createdAt.startIndex, offsetBy: 10)
                    let movieDto = MovieDataDTO(publisherName: response.data.publisherName, movieTitle: response.data.movieTitle, nftLevel: response.data.nftLevel, saleStartTime: response.data.saleStartTime, saleEndTime: response.data.saleEndTime, runningTime: response.data.runningTime, normalNFTPrice: response.data.normalNFTPrice, director: response.data.director, actors: response.data.actors.joined(separator: ", "), filmRating: response.data.filmRating, movieGenre: response.data.movieGenre, description: response.data.description, createdAt: response.data.createdAt.split(separator: " ").map{ String($0) }.first!, poster: response.data.poster)
                    promise(.success(movieDto))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func buyNFt(id: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { [weak self] promise in
            self?.movieRepository.buyNft(id: id)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(ErrorResponse(status: error.status, error: error.error)))
                    case .finished:
                        break
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }.store(in: &self!.cancellables)
        }.eraseToAnyPublisher()
    }
    
    func getMovies(sortType: String, page: Int, size: Int) -> AnyPublisher<MovieListDto, ErrorResponse> {
        return Future<MovieListDto, ErrorResponse> { [weak self] promise in
            self?.movieRepository.getMovies(sortType: sortType, page: page, size: size)
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

