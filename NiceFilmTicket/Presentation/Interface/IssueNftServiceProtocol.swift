//
//  IssueNftServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/05.
//

import Foundation
import Combine

protocol IssueNftServiceProtocol {
    func actorPatternCheck(actor: String) -> [String]?
    
    func datePatternCheck(date: String) -> Bool
    
    func issueNft(issueNftReq: IssueNFTReq, countNftReq: CountNFTReq, posterImage: [String: Foundation.Data], normalNftImage: [String: Foundation.Data], rareNftImage: [String: Foundation.Data], legendNftImage: [String: Foundation.Data]) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}
