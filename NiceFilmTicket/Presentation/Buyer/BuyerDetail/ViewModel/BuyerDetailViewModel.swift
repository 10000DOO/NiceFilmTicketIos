//
//  BuyerDetailViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/27/23.
//

import Foundation
import Combine

class BuyerDetailViewModel: ObservableObject {
    
    private let refreshTokenService: RefreshTokenServiceProtocol
    private let movieDetailService: MovieDetailServiceProtocol
    @Published var refreshTokenExpired = false
    @Published var movieData: MovieDataDTO?
    @Published var buyNftSuccess = true
    var cancellables = Set<AnyCancellable>()
    
    init(refreshTokenService: RefreshTokenServiceProtocol, movieDetailService: MovieDetailServiceProtocol) {
        self.refreshTokenService = refreshTokenService
        self.movieDetailService = movieDetailService
    }
    
    func getMovie(id: Int) {
        movieDetailService.getMovieDetails(id: id)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.message {
                        self?.refreshTokenService.issueNewToken()
                            .sink(receiveValue: { [weak self] tokenResult in
                                if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                    self?.refreshTokenExpired = true
                                } else {
                                    self?.getMovie(id: id)
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.movieData = response
            }.store(in: &self.cancellables)
    }
    
    func buyNft(id: Int) {
        movieDetailService.buyNFt(id: id)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.message {
                        self?.refreshTokenService.issueNewToken()
                            .sink(receiveValue: { [weak self] tokenResult in
                                if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                    self?.refreshTokenExpired = true
                                } else {
                                    self?.getMovie(id: id)
                                }
                            })
                            .store(in: &self!.cancellables)
                    } else if error.error[0].error == ErrorMessage.notExistedNft.message {
                        self?.buyNftSuccess = false
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                self?.buyNftSuccess = true
            }.store(in: &self.cancellables)
    }
    
    func updateMovieData(store: inout Set<AnyCancellable>, completion: @escaping (MovieDataDTO) -> Void) {
        $movieData
            .sink { movieData in
                if movieData != nil {
                    completion(movieData!)
                }
        }.store(in: &store)
    }
    
    func refreshTokenExpired(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $refreshTokenExpired
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
    
    func isBuySuccess(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $buyNftSuccess
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
}
