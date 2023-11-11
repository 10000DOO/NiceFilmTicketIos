//
//  IssueNftViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/09/30.
//

import Foundation
import Combine

class IssueNftViewModel: ObservableObject {
    
    private let issueNftService: IssueNftServiceProtocol
    private let refreshTokenService: RefreshTokenServiceProtocol
    var posterImageIsSelected = false
    var normalImageIsSelected = false
    var rareImageIsSelected = false
    var legendImageIsSelected = false
    var posterImageName = ""
    var normalImageName = ""
    var rareImageName = ""
    var legendImageName = ""
    @Published var registerIsSuccess = false
    @Published var refreshTokenExpired = false
    var cancellables = Set<AnyCancellable>()
    
    init(issueNftService: IssueNftServiceProtocol, refreshTokenService: RefreshTokenServiceProtocol) {
        self.issueNftService = issueNftService
        self.refreshTokenService = refreshTokenService
    }
    
    func reversePosterImageIsSelected() {
        posterImageIsSelected = !posterImageIsSelected
    }
    
    func reverseNormalImageIsSelected() {
        normalImageIsSelected = !normalImageIsSelected
    }
    
    func reverseRareImageIsSelected() {
        rareImageIsSelected = !rareImageIsSelected
    }
    
    func reverseLegendImageIsSelected() {
        legendImageIsSelected = !legendImageIsSelected
    }
    
    func posterImageName(name: String) {
        posterImageName = name
    }
    
    func normalImageName(name: String) {
        normalImageName = name
    }
    
    func rareImageName(name: String) {
        rareImageName = name
    }
    
    func legendImageName(name: String) {
        legendImageName = name
    }
    
    func actorPatternCheck(actor: String) -> [String]? {
        issueNftService.actorPatternCheck(actor: actor)
    }
    
    func datePatternCheck(date: String) -> Bool {
        issueNftService.datePatternCheck(date: date)
    }
    
    func issueNft(issueNftReq: IssueNFTReq, countNftReq: CountNFTReq, posterImage: [String: Foundation.Data], normalNftImage: [String: Foundation.Data], rareNftImage: [String: Foundation.Data], legendNftImage: [String: Foundation.Data]) {
        issueNftService.issueNft(issueNftReq: issueNftReq, countNftReq: countNftReq, posterImage: posterImage, normalNftImage: normalNftImage, rareNftImage: rareNftImage, legendNftImage: legendNftImage)
            .sink (receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if error.error[0].error == ErrorMessage.expiredToken.message {
                        self?.refreshTokenService.issueNewToken()
                            .sink(receiveValue: { [weak self] tokenResult in
                                if tokenResult == ErrorMessage.expiredRefreshToken.message {
                                    self?.refreshTokenExpired = true
                                } else {
                                    self?.issueNft(issueNftReq: issueNftReq, countNftReq: countNftReq, posterImage: posterImage, normalNftImage: normalNftImage, rareNftImage: rareNftImage, legendNftImage: legendNftImage)
                                }
                            })
                            .store(in: &self!.cancellables)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.registerIsSuccess = true
            })
            .store(in: &self.cancellables)
    }
    
    func registerIsSuccess(store: inout Set<AnyCancellable>, completion: @escaping (Bool) -> Void) {
        $registerIsSuccess
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
