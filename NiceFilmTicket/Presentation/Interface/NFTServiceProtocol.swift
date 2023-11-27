//
//  NFTServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Combine

protocol NFTServiceProtocol {
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTInfo, ErrorResponse>
    
    func getMyNftList(username: String, page: Int, size: Int) -> AnyPublisher<MyNftListDto, ErrorResponse>
    
    func drawNft(firstNft: NFTPickDto, secondNft: NFTPickDto, thirdNft: NFTPickDto) -> AnyPublisher<NewNftData, ErrorResponse>
    
    func actorPatternCheck(actor: String) -> [String]?
    
    func datePatternCheck(date: String) -> Bool
    
    func issueNft(issueNftReq: IssueNFTReq, countNftReq: CountNFTReq, posterImage: [String: Foundation.Data], normalNftImage: [String: Foundation.Data], rareNftImage: [String: Foundation.Data], legendNftImage: [String: Foundation.Data]) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func getNfts(username: String, page: Int, size: Int, completion: @escaping (Result<NFTResponse, ErrorResponse>) -> Void)
}
