//
//  BuyerMainTableViewCellDelegate.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/24/23.
//

import UIKit

protocol BuyerMainTableViewCellDelegate: AnyObject {

    func imageViewTapped(in cell: BuyerMainTableViewCell, imageViewIndex: Int)
}
