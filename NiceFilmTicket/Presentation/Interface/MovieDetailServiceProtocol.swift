//
//  BuyerDetailServiceProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/27/23.
//

import Foundation
import Combine

protocol MovieDetailServiceProtocol {
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDataDTO, ErrorResponse>
    
    func buyNFt(id: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}
