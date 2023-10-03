//
//  MoiveGenre.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/04.
//

import Foundation

enum MoiveGenre: String {
    case action = "액션"
    case adventure = "모험"
    case fantasy = "판타지"
    case scienceFiction = "공상과학"
    case noir = "누아르"
    case war = "전쟁"
    case horror = "공포"
    case thriller = "스릴러"
    case mystery = "미스터리"
    case romance = "로맨스/멜로"
    case comedy = "코디미"
    case drama = "드라마"
    case animation = "애니메이션"
    case art = "예술"
    case musical = "뮤지컬"
    case documentary = "다큐멘터리"
    case mumblecore = "멈블 코어"
    case education = "교육"
    case narrative = "서사"
    case experiment = "실험"
    case exploitation = "엑스플로이테이션"
    case disaster = "재난"
    case concert = "콘서트"
    case crime = "범죄"
    case superhero = "슈퍼히어로"
    case sport = "스포츠"
    
    var name: String {
        return rawValue
    }
}
