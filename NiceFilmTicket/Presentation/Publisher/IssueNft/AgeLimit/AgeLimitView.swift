//
//  AgeLimitView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/04.
//

import UIKit
import SnapKit

class AgeLimitView: UIView {
    var tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("AgeLimitView(coder:) has not been implemented")
    }
}

extension AgeLimitView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-80)
        }
    }
}
