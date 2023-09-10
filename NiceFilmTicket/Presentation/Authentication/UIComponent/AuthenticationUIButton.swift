//
//  AuthenticationUIButton.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/27.
//

import UIKit

class AuthenticationUIButton: UIButton {

    init(title : String, isHidden: Bool){
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // 텍스트 크기 설정
        self.layer.cornerRadius = 15 // 테두리 둥글기 설정
        self.layer.borderWidth = 1 // 테두리 두께 설정
        self.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor // 테두리 색상 설정
        self.isHidden = isHidden
    }
    
    required init?(coder: NSCoder) {
        fatalError("AuthenticationUIButton : init(coder:) has not been implemented")
    }
}
