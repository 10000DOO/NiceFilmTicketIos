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
    private let findViewModel: FindIdViewModel
    var cancellables = Set<AnyCancellable>()
    
    init(findViewModel: FindIdViewModel) {
        self.findViewModel = findViewModel
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
        let emailSending = UITapGestureRecognizer(target: self, action: #selector(clickSendButton))
        findIdView.emailSendButton.addGestureRecognizer(emailSending)
        
        let findId = UITapGestureRecognizer(target: self, action: #selector(findId))
        findIdView.checkButton.addGestureRecognizer(findId)
        
        findViewModel.updateErrorMessage(store: &cancellables) { [weak self] result in
            self?.findIdView.errorLabel.text = result
        }
        
        findViewModel.updateFindedId(store: &cancellables) { [weak self] result in
            print(result)
        }
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
    
    @objc func clickSendButton() {
        if findIdView.emailTextField.text != "" {
            findViewModel.sendEmailCode(email: findIdView.emailTextField.text!)
        }
    }
    
    @objc func findId() {
        if findIdView.emailTextField.text != "" && findIdView.emailCodeTextField.text != "" {
            findViewModel.findId(emailCode: findIdView.emailCodeTextField.text!)
        }
    }
}
