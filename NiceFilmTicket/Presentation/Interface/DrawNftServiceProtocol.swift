//
//  DrawNftServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/5/23.
//

import Foundation
import Combine

protocol DrawNftServiceProtocol {
    
    func drawNft(firstNft: NFTPickDto, secondNft: NFTPickDto, thirdNft: NFTPickDto) -> AnyPublisher<NewNftData, ErrorResponse>
}
