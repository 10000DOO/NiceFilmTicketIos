//
//  MyPageViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/7/23.
//

import Foundation
import Combine

class MyPageViewModel: ObservableObject {
    
    private let myNftService: MyNftServiceProtocol
    private let refreshTokenService: RefreshTokenServiceProtocol
    @Published var refreshTokenExpired = false
    @Published var nftData = [NftList]()
    @Published var normalNftCount = 0
    @Published var rareNftCount = 0
    @Published var legendNftCount = 0
    var page = 0
    var fetchMoreResult = false
    var cancellables = Set<AnyCancellable>()
    
    init(myNftService: MyNftServiceProtocol, refreshTokenService: RefreshTokenServiceProtocol) {
        self.myNftService = myNftService
        self.refreshTokenService = refreshTokenService
    }
    
    func getMyNftList(username: String) {
        fetchMoreResult = false
        myNftService.getMyNftList(username: username, page: page, size: 8)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.message {
                        self?.refreshTokenService.issueNewToken()
                            .sink(receiveValue: { [weak self] tokenResult in
                                if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                    self?.refreshTokenExpired = true
                                } else {
                                    self?.getMyNftList(username: username)
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.nftData.append(contentsOf: response.nftList)
                self?.normalNftCount = response.normalCount
                self?.rareNftCount = response.rareCount
                self?.legendNftCount = response.legendCount
                if response.hasNext {
                    self?.fetchMoreResult = true
                    self?.page += 1
                }
            }.store(in: &self.cancellables)
    }
    
    func updateNftData(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (NftList) -> Void) {
        $nftData
            .filter{$0.count > index}
            .sink { nftData in
            completion(nftData[index])
        }.store(in: &store)
    }
    
    func updateNormalNftCount(store: inout Set<AnyCancellable>, completion: @escaping (Int) -> Void) {
        $normalNftCount
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
    
    func updateRareNftCount(store: inout Set<AnyCancellable>, completion: @escaping (Int) -> Void) {
        $rareNftCount
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
    
    func updateLegendNftCount(store: inout Set<AnyCancellable>, completion: @escaping (Int) -> Void) {
        $legendNftCount
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
    
    func refreshTokenExpired(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $refreshTokenExpired
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
}
