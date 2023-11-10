//
//  FindIdViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import UIKit
import Combine

class FindIdViewController: UIViewController {
    
    private let findIdView = FindIdView()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FindIdViewController(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(findIdView)
        self.navigationController?.navigationBar.isHidden = true
        
        hideKeyboardWhenTappedAround()
    }
}

extension FindIdViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
