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
    var keyHeight: CGFloat?
    var originFrameHeight: CGFloat?
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
        findIdView.emailCodeTextField.delegate = self
        findIdView.emailTextField.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        originFrameHeight = self.view.frame.size.height
        
        hideKeyboardWhenTappedAround()
        let emailSending = UITapGestureRecognizer(target: self, action: #selector(clickSendButton))
        findIdView.emailSendButton.addGestureRecognizer(emailSending)
        
        let findId = UITapGestureRecognizer(target: self, action: #selector(findId))
        findIdView.checkButton.addGestureRecognizer(findId)
        
        findViewModel.updateErrorMessage(store: &cancellables) { [weak self] result in
            self?.findIdView.errorLabel.text = result
        }
        
        findViewModel.updateFindedId(store: &cancellables) { [weak self] result in
            let findIdResultVC = FindIdResultViewController()
            if result != nil {
                findIdResultVC.findedId = result!
                self?.navigationController?.pushViewController(findIdResultVC, animated: false)
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
        //name으로 하나씩 지우기
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
}

extension FindIdViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
