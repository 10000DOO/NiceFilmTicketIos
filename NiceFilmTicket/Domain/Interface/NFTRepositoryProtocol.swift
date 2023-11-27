//
//  NFTRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Foundation
import Combine
import Moya

protocol NFTRepositoryProtocol {
    
    func registerNft(issueNFTReq: IssueNFTReq, countNFTReq: CountNFTReq, poster: [String: Foundation.Data], normal: [String: Foundation.Data], rare: [String: Foundation.Data], legend: [String: Foundation.Data]) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
    
    func drawNft(drawNftReq: DrawNftReq) -> AnyPublisher<DrawNftRes, ErrorResponse>
    
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTData, ErrorResponse>
    
    func getNfts(username: String, page: Int, size: Int, completion: @escaping (Result<NFTList, ErrorResponse>) -> Void)
}
