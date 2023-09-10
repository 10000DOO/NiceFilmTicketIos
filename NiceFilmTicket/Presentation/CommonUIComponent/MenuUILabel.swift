//
//  MenuUILabel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/27.
//

import UIKit

class MenuUILabel: UILabel {

    init(text: String, size: UIFont){
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .center
        self.font = size
        self.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MenuUILabel : init(coder:) has not been implemented")
    }
}
