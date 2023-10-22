//
//  BuyerMainViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/20/23.
//

import Foundation
import Combine

class BuyerMainViewModel: ObservableObject {
    
    private let movieListService: MovieListServiceProtocol
    private let refreshTokenService: RefreshTokenServiceProtocol
    @Published var refreshTokenExpired = false
    @Published var movieData = [Movie]()
    var page = 0
    var fetchMoreResult = false
    var sortType = "최신순"
    var cancellables = Set<AnyCancellable>()
    
    init(movieListService: MovieListServiceProtocol, refreshTokenService: RefreshTokenServiceProtocol) {
        self.movieListService = movieListService
        self.refreshTokenService = refreshTokenService
    }
    
    func getMovies(sortType: String) {
        fetchMoreResult = false
        movieListService.getMovies(sortType: sortType, page: page, size: 8)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.message {
                        self?.refreshTokenService.issueNewToken()
                            .sink(receiveValue: { [weak self] tokenResult in
                                if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                    self?.refreshTokenExpired = true
                                } else {
                                    self?.getMovies(sortType: sortType)
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.movieData.append(contentsOf: response.movieDto)
                if response.hasNext {
                    self?.fetchMoreResult = true
                    self?.page += 1
                } else {
                }
            }.store(in: &self.cancellables)
    }
    
    func updateMovieData(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (Movie) -> Void) {
        $movieData
            .filter{$0.count > index}
            .sink { movieData in
            completion(movieData[index])
        }.store(in: &store)
    }
    
    func refreshTokenExpired(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $refreshTokenExpired
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
}
