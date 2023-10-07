//
//  issueNftRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/06.
//

import Foundation
import Combine
import Moya

protocol IssueNftRepositoryProtocol {
    
    func registerNft(issueNFTReq: IssueNFTReq, countNFTReq: CountNFTReq, poster: [String: Foundation.Data], normal: [String: Foundation.Data], rare: [String: Foundation.Data], legend: [String: Foundation.Data]) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}
