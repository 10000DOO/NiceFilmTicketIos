//
//  IssueNftViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/09/30.
//

import Foundation
import Combine

class IssueNftViewModel: ObservableObject {
    
    var posterImageIsSelected = false
    var normalImageIsSelected = false
    var rareImageIsSelected = false
    var legendImageIsSelected = false
    
    init() {
        
    }
    
    func reversePosterImageIsSelected() {
        posterImageIsSelected = !posterImageIsSelected
    }
    
    func reverseNormalImageIsSelected() {
        normalImageIsSelected = !normalImageIsSelected
    }
    
    func reverseRareImageIsSelected() {
        rareImageIsSelected = !rareImageIsSelected
    }
    
    func reverseLegendImageIsSelected() {
        legendImageIsSelected = !legendImageIsSelected
    }
}
