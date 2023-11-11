//
//  MyNftViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import Foundation
import Combine

class MyNftViewModel: ObservableObject {
    
    private let myNftService: MyNftServiceProtocol
    private let refreshTokenService: RefreshTokenServiceProtocol
    @Published var refreshTokenExpired = false
    @Published var nftData = [NFTPickDto]()
    var fetchMoreResult = false
    var page = 0
    var cancellables = Set<AnyCancellable>()
    
    init(myNftService: MyNftServiceProtocol, refreshTokenService: RefreshTokenServiceProtocol) {
        self.myNftService = myNftService
        self.refreshTokenService = refreshTokenService
    }
    
    func getMyNft(username: String, size: Int) {
        fetchMoreResult = false
        myNftService.getMyNft(username: username, page: page, size: size)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.message {
                        self?.refreshTokenService.issueNewToken()
                            .sink(receiveValue: { [weak self] tokenResult in
                                if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                    self?.refreshTokenExpired = true
                                } else {
                                    self?.getMyNft(username: username, size: size)
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.nftData.append(contentsOf: response.nftPickDtos)
                if response.hasNext {
                    self?.fetchMoreResult = true
                    self?.page += 1
                }
            }.store(in: &self.cancellables)
    }
    
    func updateNftData(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (NFTPickDto) -> Void) {
        $nftData
            .filter{$0.count > index}
            .sink { nftData in
            completion(nftData[index])
        }.store(in: &store)
    }
    
    func refreshTokenExpired(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $refreshTokenExpired
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
}
