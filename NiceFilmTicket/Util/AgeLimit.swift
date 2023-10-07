//
//  AgeLimit.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/04.
//

import Foundation

enum AgeLimit: String {
    case G_RATED = "전체관람가"
    case PG12 = "12세 이상 관람가"
    case PG15 = "15세 이상 관람가"
    case PG18 = "18세 이상 관람가"
    
    var name: String {
        return rawValue
    }
}
