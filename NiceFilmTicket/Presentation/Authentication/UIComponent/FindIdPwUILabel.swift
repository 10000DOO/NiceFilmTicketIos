//
//  FindIdPwUILabel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/27.
//

import UIKit

class FindIdPwUILabel: UILabel {

    init(text : String){
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 15)
        self.textColor = .darkGray
        self.isUserInteractionEnabled = true //클릭 이벤트 허용
    }
    
    required init?(coder: NSCoder) {
        fatalError("FindIdPwUILabel : init(coder:) has not been implemented")
    }

}
