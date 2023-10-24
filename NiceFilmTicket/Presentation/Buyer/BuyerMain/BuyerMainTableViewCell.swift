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
    weak var delegate: BuyerMainTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(leftImageTapped))
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped))
        
        leftMovieImage.isUserInteractionEnabled = true
        rightMovieImage.isUserInteractionEnabled = true
        
        leftMovieImage.addGestureRecognizer(leftTapGesture)
        rightMovieImage.addGestureRecognizer(rightTapGesture)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("BuyerMainTableViewCell(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable.removeAll()
    }
}

extension BuyerMainTableViewCell {
    
    @objc func leftImageTapped() {
        delegate?.imageViewTapped(in:self, imageViewIndex:0)
    }
    
    @objc func rightImageTapped() {
        delegate?.imageViewTapped(in:self, imageViewIndex:1)
    }
    
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
