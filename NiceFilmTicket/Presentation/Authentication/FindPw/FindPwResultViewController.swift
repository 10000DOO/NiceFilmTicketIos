//
//  FindPwResultViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/11/23.
//

import UIKit
import Combine

class FindPwResultViewController: UIViewController {

    private let findPwResultView = FindPwResultView()
    private let findPwResultViewModel: FindPwResultViewModel
    var email = ""
    var keyHeight: CGFloat?
    var originFrameHeight: CGFloat?
    var cancellables = Set<AnyCancellable>()
    
    init(findPwResultViewModel: FindPwResultViewModel) {
        self.findPwResultViewModel = findPwResultViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FindPwResultViewController(coder:) has not been implemented")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(findPwResultView)
        self.navigationController?.navigationBar.isHidden = true
        originFrameHeight = self.view.frame.size.height
        findPwResultView.pwTextField.delegate = self
        findPwResultView.pwCheckTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        
        let findPw = UITapGestureRecognizer(target: self, action: #selector(findPw))
        findPwResultView.findPwButton.addGestureRecognizer(findPw)
        
        findPwResultViewModel.subscribeToPasswordError(store: &cancellables) { [weak self] passwordErrorMessage in
            DispatchQueue.main.async {
                if passwordErrorMessage == ErrorMessage.availablePassword.message {
                    if self?.findPwResultView.errorLabel.text != ErrorMessage.passwordNotMatching.message {
                        self?.findPwResultView.errorLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
                        self?.findPwResultView.errorLabel.text = passwordErrorMessage
                    }
                } else {
                    self?.findPwResultView.errorLabel.textColor = .red
                    self?.findPwResultView.errorLabel.text = passwordErrorMessage
                }
            }
        }
        
        findPwResultViewModel.subscribeToPasswordMatchingError(store: &cancellables) { [weak self] passwordErrorMessage in
            DispatchQueue.main.async {
                if passwordErrorMessage == ErrorMessage.passwordMatching.message {
                    if self?.findPwResultView.errorLabel.text != ErrorMessage.wrongPasswordPattern.message {
                        self?.findPwResultView.errorLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
                        self?.findPwResultView.errorLabel.text = passwordErrorMessage
                    }
                } else {
                    self?.findPwResultView.errorLabel.textColor = .red
                    self?.findPwResultView.errorLabel.text = passwordErrorMessage
                }
            }
        }
        
        findPwResultViewModel.subscribeToNewPwError(store: &cancellables) { [weak self] error in
            self?.findPwResultView.errorLabel.textColor = .red
            self?.findPwResultView.errorLabel.text = error
        }
        
        findPwResultViewModel.subscribeToNewPwSuccess(store: &cancellables) { [weak self] result in
            if result {
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension FindPwResultViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BuyerMainViewController.dismissKeyboard))
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
    
    @objc func findPw() {
        if findPwResultView.pwTextField.text != "" && findPwResultView.pwCheckTextField.text != "" && (findPwResultView.errorLabel.text == ErrorMessage.availablePassword.message || findPwResultView.errorLabel.text == ErrorMessage.passwordMatching.message)  {
            let newPwDto = NewPwDto(password: findPwResultView.pwTextField.text!, email: email)
            findPwResultViewModel.findPw(newPwDto: newPwDto)
        }
    }
}

extension FindPwResultViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.findPwResultView.pwTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            findPwResultViewModel.passwordMatching(password: updatedText, passwordForCheck: self.findPwResultView.pwCheckTextField.text ?? "")
            findPwResultViewModel.passwordPatternCheck(password: updatedText)
        }
        
        if textField == self.findPwResultView.pwCheckTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            findPwResultViewModel.passwordMatching(password: self.findPwResultView.pwTextField.text ?? "", passwordForCheck: updatedText)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
