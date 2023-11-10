//
//  FindPwViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/10/23.
//

import UIKit
import Combine

class FindPwViewController: UIViewController {
    
    private let findPwView = FindPwView()
    private let findPwViewModel: FindPwViewModel
    var keyHeight: CGFloat?
    var originFrameHeight: CGFloat?
    var cancellables = Set<AnyCancellable>()
    
    init(findPwViewModel: FindPwViewModel) {
        self.findPwViewModel = findPwViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FindPwViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(findPwView)
        findPwView.emailCodeTextField.delegate = self
        findPwView.idTextField.delegate = self
        findPwView.emailTextField.delegate = self
        hideKeyboardWhenTappedAround()
        
        originFrameHeight = self.view.frame.size.height
        self.navigationController?.navigationBar.isHidden = true
        
        let emailSending = UITapGestureRecognizer(target: self, action: #selector(clickSendButton))
        findPwView.emailSendButton.addGestureRecognizer(emailSending)
        
        let findPw = UITapGestureRecognizer(target: self, action: #selector(findPw))
        findPwView.checkButton.addGestureRecognizer(findPw)
        
        findPwViewModel.updateErrorMessage(store: &cancellables) { [weak self] result in
            self?.findPwView.errorLabel.text = result
        }
        
        findPwViewModel.updateCode(store: &cancellables) { [weak self] result in
            if result {
                findPwViewModel.findPw(
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension FindPwViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        keyHeight = keyboardHeight
        
        if originFrameHeight! <= self.view.frame.size.height {
            self.view.frame.size.height -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if originFrameHeight! > self.view.frame.size.height {
            self.view.frame.size.height += keyHeight ?? 0
        }
    }
    
    @objc func clickSendButton() {
        if findPwView.emailTextField.text != "" {
            findPwViewModel.sendEmailCode(email: findPwView.emailTextField.text!)
        }
    }
    
    @objc func findPw() {
        if findPwView.idTextField.text != "" && findPwView.emailTextField.text != "" && findPwView.emailCodeTextField.text != "" {
            findPwViewModel.checkEmailCode(emailCode: findPwView.emailCodeTextField.text!)
        }
    }
}

extension FindPwViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
