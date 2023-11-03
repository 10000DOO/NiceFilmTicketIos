//
//  DrawNftViewDelegate.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/3/23.
//

import Foundation

protocol DrawNftViewDelegate: AnyObject {
    func setSelectedNft(nftInfo: NFTPickDto)
}
