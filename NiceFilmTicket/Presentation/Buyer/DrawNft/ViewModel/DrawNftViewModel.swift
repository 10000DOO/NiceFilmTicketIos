//
//  DrawNftViewModel.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/3/23.
//

import Foundation
import Combine

class DrawNftViewModel: ObservableObject {
    
    var firstNftSelected = false
    var secondNftSelected = false
    var thirdNftSelected = false
    var firstNft: NFTPickDto?
    var secondNft: NFTPickDto?
    var thirdNft: NFTPickDto?
}
