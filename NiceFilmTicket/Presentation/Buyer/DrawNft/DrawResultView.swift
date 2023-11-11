//
//  DrawResultView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/5/23.
//

import UIKit
import SnapKit

class DrawResultView: UIView {
    
    var borderView = UIView()
    var movieTitle = UILabel()
    var nftImage = UIImageView()
    var nftLevel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("DrawResultView(coder:) has not been implemented")
    }
}

extension DrawResultView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        self.backgroundColor = .black.withAlphaComponent(0.8)
        setBorderView()
        setMovieTitle()
        setNftImage()
        setNftLevel()
    }
    
    private func setBorderView() {
        borderView.backgroundColor = .clear
        borderView.layer.borderWidth = 8
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        self.addSubview(borderView)
        
        borderView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(UIEdgeInsets(top :20 , left :20 , bottom :20 , right :20 ))
        }
    }
    
    private func setMovieTitle() {
        movieTitle.textColor = .white
        movieTitle.font = UIFont.boldSystemFont(ofSize: 40)
        self.addSubview(movieTitle)
        
        movieTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setNftImage() {
        self.addSubview(nftImage)
        
        nftImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(225)
            make.width.equalTo(150)
            make.bottom.equalTo(movieTitle.snp.top).offset(-20)
        }
    }
    
    private func setNftLevel() {
        nftLevel.font = UIFont.boldSystemFont(ofSize: 25)
        self.addSubview(nftLevel)
        
        nftLevel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(movieTitle.snp.bottom).offset(20)
        }
    }
}
