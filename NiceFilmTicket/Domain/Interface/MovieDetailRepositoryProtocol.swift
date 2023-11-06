//
//  BuyerDetailRepositoryProtocol.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/27/23.
//

import Foundation
import Combine
import Moya

protocol MovieDetailRepositoryProtocol {
 
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetail, ErrorResponse>
    
    func buyNft(id: Int) -> AnyPublisher<CommonSuccessRes, ErrorResponse>
}
