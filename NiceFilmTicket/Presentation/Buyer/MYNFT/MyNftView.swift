//
//  MyNftView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import UIKit
import SnapKit

class MyNftView: UIView {
    
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("MyNftView(coder:) has not been implemented")
    }
}

extension MyNftView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setTableView()
    }
    
    private func setTableView() {
        tableView.separatorStyle = .none
        self.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
