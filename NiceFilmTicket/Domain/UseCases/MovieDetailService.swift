//
//  BuyerDetailService.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/27/23.
//

import Foundation
import Combine

class MovieDetailService: MovieDetailServiceProtocol {
    
    private let movieDetailRepository: MovieDetailRepositoryProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(movieDetailRepository: MovieDetailRepositoryProtocol) {
        self.movieDetailRepository = movieDetailRepository
    }
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDataDTO, ErrorResponse> {
        return Future<MovieDataDTO, ErrorResponse> { [weak self] promise in
            self?.movieDetailRepository.getMovieDetails(id: id)
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
}
