//
//  SignUpViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/26.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    private var signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signUpView)
        
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //뒤로가기 제스쳐는 살리고 백버튼 지우기
        self.navigationController?.navigationBar.isHidden = true
        
        hideKeyboardWhenTappedAround()
    }
}

extension SignUpViewController {
    //키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthenticationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
