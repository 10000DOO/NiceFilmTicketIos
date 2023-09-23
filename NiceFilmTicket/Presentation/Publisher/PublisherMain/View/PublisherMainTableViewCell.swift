//
//  PublisherMainTableViewCell.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/14.
//

import UIKit
import SnapKit
import Combine

class PublisherMainTableViewCell: UITableViewCell {
    
    var numLabel = UILabel()
    var movieTitleLabel = UILabel()
    var priceLabel = UILabel()
    var nftStockLabel = UILabel()
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    var cancellable: Set<AnyCancellable> = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(numLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(nftStockLabel)
        contentView.addSubview(separatorLineView)
        
        numLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        nftStockLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(45)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-75)
            make.centerY.equalToSuperview()
        }
        
        separatorLineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
