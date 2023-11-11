//
//  DrawNftViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/3/23.
//

import Foundation
import Combine

class DrawNftViewModel: ObservableObject {
    
    private let drawNftService: DrawNftServiceProtocol
    private let refreshTokenService: RefreshTokenServiceProtocol
    var firstNftSelected = false
    var secondNftSelected = false
    var thirdNftSelected = false
    var firstNft: NFTPickDto?
    var secondNft: NFTPickDto?
    var thirdNft: NFTPickDto?
    @Published var drawnNft: NewNftData?
    @Published var refreshTokenExpired = false
    var cancellables = Set<AnyCancellable>()
    
    init(drawNftService: DrawNftServiceProtocol, refreshTokenService: RefreshTokenServiceProtocol) {
        self.drawNftService = drawNftService
        self.refreshTokenService = refreshTokenService
    }
    
    func drawNft() {
        drawNftService.drawNft(firstNft: firstNft!, secondNft: secondNft!, thirdNft: thirdNft!)
            .sink (receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.message {
                        self?.refreshTokenService.issueNewToken()
                            .sink(receiveValue: { [weak self] tokenResult in
                                if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                    self?.refreshTokenExpired = true
                                } else {
                                    self?.drawNft()
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.drawnNft = response
            })
            .store(in: &self.cancellables)
    }
    
    func refreshTokenExpired(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $refreshTokenExpired
            .sink { result in
                completion(result)
            }.store(in: &store)
    }
    
    func drawnNftChanged(store: inout Set<AnyCancellable>, completion: @escaping (NewNftData) -> Void) {
        $drawnNft
            .sink { result in
                if let newNft = result {
                    completion(newNft)
                }
            }.store(in: &store)
    }
}
