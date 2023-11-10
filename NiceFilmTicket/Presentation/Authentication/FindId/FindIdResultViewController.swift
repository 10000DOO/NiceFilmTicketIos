//
//  FindIdResultViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import UIKit

class FindIdResultViewController: UIViewController {

    private let findIdResultView = FindIdResultView()
    var findedId = ""
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FindIdResultViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(findIdResultView)
        findIdResultView.idLabel.text = findedId
        self.navigationController?.navigationBar.isHidden = true
        
        let gotoLoginVC = UITapGestureRecognizer(target: self, action: #selector(gotoLoginVC))
        findIdResultView.gotoLoginButton.addGestureRecognizer(gotoLoginVC)
    }
}

extension FindIdResultViewController {
    @objc func gotoLoginVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
