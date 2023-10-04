//
//  AgeLimit.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/04.
//

import Foundation

enum AgeLimit: String {
    case gRated = "전체관람가"
    case pg12 = "12세 이상 관람가"
    case pg15 = "15세 이상 관람가"
    case pg18 = "18세 이상 관람가"
    
    var name: String {
        return rawValue
    }
}
