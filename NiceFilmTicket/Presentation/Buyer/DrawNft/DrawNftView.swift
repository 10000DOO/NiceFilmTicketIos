//
//  DrawNftView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/1/23.
//

import UIKit
import SnapKit

class DrawNftView: UIView {
    
    var logoImageView = UIImageView(image: UIImage(named: "Logo"))
    var titleTextLabel = UILabel()
    var explanationTextLabel = UILabel()
    var scrollView = UIScrollView()
    var contentView = UIView()
    var firstNFT = UIImageView()
    var secondNFT = UIImageView()
    var thirdNFT = UIImageView()
    var drawButton = AuthenticationUIButton(title: "뽑기", isHidden: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("DrawNftView(coder:) has not been implemented")
    }
}

extension DrawNftView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setLogo()
        setTitleLabel()
        setExplanationLabel()
        setScrollView()
        setFirstNFT()
        setSecondImageNFT()
        setThirdIImageNFT()
        setDrawButton()
    }
    
    private func setLogo() {
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func setTitleLabel() {
        titleTextLabel.text = "[ NFT뽑기 ]"
        titleTextLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        titleTextLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.addSubview(titleTextLabel)
        
        titleTextLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(logoImageView.snp.bottom).offset(25)
        }
    }
    
    func setExplanationLabel() {
        explanationTextLabel.text = "NFT 3개로 뽑기를 이용하실 수 있습니다.\n랜덤 등급의 NFT가 1개 지급됩니다."
        explanationTextLabel.numberOfLines = 2
        explanationTextLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(explanationTextLabel)
        
        explanationTextLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleTextLabel.snp.bottom).offset(25)
        }
    }
    
    private func setScrollView() {
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(explanationTextLabel.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(590)
        }
    }
    
    private func setFirstNFT() {
        firstNFT.image = UIImage(systemName: "plus.circle.fill")
        firstNFT.layer.borderWidth = 2
        firstNFT.layer.cornerRadius = 10
        firstNFT.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        firstNFT.contentMode = .scaleAspectFit
        firstNFT.tintColor = .lightGray
        contentView.addSubview(firstNFT)
        
        firstNFT.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(225)
        }
    }
    
    private func setSecondImageNFT() {
        secondNFT.image = UIImage(systemName: "plus.circle.fill")
        secondNFT.layer.borderWidth = 2
        secondNFT.layer.cornerRadius = 10
        secondNFT.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        secondNFT.contentMode = .scaleAspectFit
        secondNFT.tintColor = .lightGray
        contentView.addSubview(secondNFT)
        
        secondNFT.snp.makeConstraints { make in
            make.top.equalTo(firstNFT.snp.bottom).offset(20)
            make.centerX.equalTo(contentView.snp.centerX).multipliedBy(0.5)
            make.width.equalTo(150)
            make.height.equalTo(225)
        }
    }

    private func setThirdIImageNFT() {
        thirdNFT.image = UIImage(systemName: "plus.circle.fill")
        thirdNFT.layer.borderWidth = 2
        thirdNFT.layer.cornerRadius = 10
        thirdNFT.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        thirdNFT.contentMode = .scaleAspectFit
        thirdNFT.tintColor = .lightGray
        contentView.addSubview(thirdNFT)
        
        thirdNFT.snp.makeConstraints { make in
            make.top.equalTo(secondNFT.snp.top)
            make.centerX.equalTo(contentView.snp.centerX).multipliedBy(1.5)
            make.width.equalTo(150)
            make.height.equalTo(225)
        }
    }
    
    private func setDrawButton() {
        drawButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        contentView.addSubview(drawButton)
        
        drawButton.snp.makeConstraints { make in
            make.top.equalTo(secondNFT.snp.bottom).offset(20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
}
