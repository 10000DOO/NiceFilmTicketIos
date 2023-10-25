//
//  BuyerDetailViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/25/23.
//

import UIKit

class BuyerDetailViewController: UIViewController {

    private var buyerDetailView = BuyerDetailView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("BuyerDetailViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        buyerDetailView = BuyerDetailView(frame: view.bounds)
        view.addSubview(buyerDetailView)
    }
}
