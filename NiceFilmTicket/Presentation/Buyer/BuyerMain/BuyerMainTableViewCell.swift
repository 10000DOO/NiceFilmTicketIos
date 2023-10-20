//
//  BuyerMainTableViewCell.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/19/23.
//

import UIKit
import SnapKit
import Combine

class BuyerMainTableViewCell: UITableViewCell {

    var leftMoiveTitle = UILabel()
    var rightMoiveTitle = UILabel()
    var leftMovieImage = UIImageView()
    var rightMovieImage = UIImageView()
    var cancellable: Set<AnyCancellable> = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("BuyerMainTableViewCell(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable.removeAll()
    }
}

extension BuyerMainTableViewCell {
    private func setView() {
        contentView.addSubview(leftMoiveTitle)
        contentView.addSubview(rightMoiveTitle)
        contentView.addSubview(leftMovieImage)
        contentView.addSubview(rightMovieImage)
        
        leftMovieImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview()
            make.height.equalTo(225)
            make.width.equalTo(150)
        }
        
        rightMovieImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.top.equalToSuperview()
            make.height.equalTo(225)
            make.width.equalTo(150)
        }
        
        leftMoiveTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(leftMovieImage.snp.bottom).offset(10)
        }
        
        rightMoiveTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.top.equalTo(rightMovieImage.snp.bottom).offset(10)
        }
    }
}
