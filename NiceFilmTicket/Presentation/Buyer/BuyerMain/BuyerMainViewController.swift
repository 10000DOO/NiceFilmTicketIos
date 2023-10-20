//
//  BuyerMainViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit
import SnapKit

class BuyerMainViewController: UIViewController {

    private let buyerMainView = BuyerMainView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("BuyerMainViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(buyerMainView)
        
        buyerMainView.tableView.delegate = self
        buyerMainView.tableView.dataSource = self
        buyerMainView.tableView.register(BuyerMainTableViewCell.self, forCellReuseIdentifier: "buyerMainTableViewCell")
        
        hideKeyboardWhenTappedAround()
    }
}

extension BuyerMainViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension BuyerMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyerMainTableViewCell", for: indexPath) as! BuyerMainTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
}
