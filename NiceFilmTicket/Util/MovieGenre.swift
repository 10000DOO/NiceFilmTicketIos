//
//  MovieGenre.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/04.
//

import Foundation

enum MovieGenre: String {
    case ACTION = "액션"
    case ADVENTURE = "모험"
    case FANTASY = "판타지"
    case SCIENCEFICTION = "공상과학"
    case NOIR = "누아르"
    case WAR = "전쟁"
    case HORROR = "공포"
    case THRILLER = "스릴러"
    case MYSTERY = "미스터리"
    case ROMANCE = "로맨스/멜로"
    case COMEDY = "코디미"
    case DRAMA = "드라마"
    case ANIMATION = "애니메이션"
    case ART = "예술"
    case MUSICAL = "뮤지컬"
    case DOCUMENTARY = "다큐멘터리"
    case MUMBLECORE = "멈블 코어"
    case EDUCATION = "교육"
    case NARRATIVE = "서사"
    case EXPERIMENT = "실험"
    case EXPLOITATION = "엑스플로이테이션"
    case DISASTER = "재난"
    case CONCERT = "콘서트"
    case CRIME = "범죄"
    case SUPERHERO = "슈퍼히어로"
    case SPORT = "스포츠"
    
    var name: String {
        return rawValue
    }
}
