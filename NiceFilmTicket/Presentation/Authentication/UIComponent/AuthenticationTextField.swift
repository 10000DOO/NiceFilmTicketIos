//
//  AuthenticationTextField.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/27.
//

import UIKit

class AuthenticationTextField: UITextField {
    
    init(placeholder: String, isSecureTextEntry: Bool, backgroundColor: UIColor, isHidden: Bool, font: UIFont) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        self.layer.masksToBounds = true
        self.font = font
        self.backgroundColor = backgroundColor
        self.isSecureTextEntry = isSecureTextEntry
        self.placeholder = " \(placeholder)"
        self.isHidden = isHidden
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("AuthenticationTextField : init(coder:) has not been implemented")
    }
}
