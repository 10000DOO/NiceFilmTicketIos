//
//  PublisherMainViewModel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/15.
//

import Foundation
import Combine

class PublisherMainViewModel: ObservableObject {
    
    private let publisherMainService: PublisherMainServiceProtocol
    private let refreshTokenService: RefreshTokenServiceProtocol
    @Published var nftList: [NFTItem] = []
    @Published var refreshTokenExpired = false
    var cancellables = Set<AnyCancellable>()
    var page = 0
    var fetchMoreResult = false
    
    init(publisherMainService: PublisherMainServiceProtocol, refreshTokenService: RefreshTokenServiceProtocol) {
        self.publisherMainService = publisherMainService
        self.refreshTokenService = refreshTokenService
    }
    
    func getIssuedNft() {
        fetchMoreResult = false
        publisherMainService.getNfts(page: page, size: 15) { [weak self] result in
            switch result {
            case .success(let response):
                self?.nftList.append(contentsOf: response.nftListDtos)
                if response.hasNext {
                    self?.fetchMoreResult = true
                    self?.page += 1
                }
            case .failure(let error):
                if error.error[0].error == ErrorMessage.expiredToken.message {
                    self?.refreshTokenService.issueNewToken()
                        .sink(receiveValue: { tokenResult in
                            if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                self?.refreshTokenExpired = true
                            } else {
                                self?.getIssuedNft()
                            }
                        }).store(in: &self!.cancellables)
                }
            }
        }
    }
    
    func getNftList(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (NFTItem) -> Void) {
        $nftList
            .filter{$0.count > index}
            .sink { nfts in
            completion(nfts[index])
        }.store(in: &store)
    }
}
