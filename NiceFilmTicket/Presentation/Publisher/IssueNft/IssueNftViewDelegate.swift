//
//  IssueNftViewDelegate.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/04.
//

import Foundation

protocol IssueNftViewDelegate: AnyObject {
    func setGenre(genre: MoiveGenre)
    
    func setAgeLimit(age: AgeLimit)
}
