//
//  MyNftTableViewCell.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import UIKit
import Combine
import SnapKit

class MyNftTableViewCell: UITableViewCell {

    var nftImage = UIImageView()
    var nftLevel = UILabel()
    var movieTitle = UILabel()
    var cancellables = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MyNftTableViewCell(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MyNftTableViewCell {
    private func setView() {
        nftLevel.font = .boldSystemFont(ofSize: 20)
        
        contentView.addSubview(nftImage)
        contentView.addSubview(nftLevel)
        contentView.addSubview(movieTitle)
        
        nftImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(113)
            make.width.equalTo(75)
        }
        
        nftLevel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        movieTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
