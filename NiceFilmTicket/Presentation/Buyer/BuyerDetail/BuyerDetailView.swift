//
//  BuyerDetailView.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/25/23.
//

import UIKit
import SnapKit
import Foundation

class BuyerDetailView: UIView {
    
    var logoImageView = UIImageView(image: UIImage(named: "Logo"))
    var movieImage = UIImageView()
    var movieTitle = UILabel()
    var scrollView = UIScrollView()
    var contentView = UIView()
    var nftLevel = UILabel()
    var lineView = UIView()
    var salePeriod = UILabel()
    var buyButton = AuthenticationUIButton(title: "원", isHidden: false)
    var bottomLineView = UIView()
    var director = UILabel()
    var directorContent = UILabel()
    var actors = UILabel()
    var actorContent = UILabel()
    var movieInfo = UILabel()
    var plot = UILabel()
    var plotContent = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("BuyerDetailView(coder:) has not been implemented")
    }
}

extension BuyerDetailView {
    private func setView() {
        self.snp.makeConstraints { make in
            make.self.width.equalTo(UIScreen.main.bounds.width)
            make.self.height.equalTo(UIScreen.main.bounds.height)
        }
        setLogo()
        setScrollView()
        setMovieImage()
        setMovieTitle()
        setNftLevel()
        setDividLine()
        setSalePeriod()
        setBuyButton()
        setBottomDividLine()
        setDirector()
        setDirectorContent()
        setActors()
        setActorContent()
        setMovieInfo()
        setPlot()
        setPlotContent()
    }
    
    private func setLogo() {
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(130)
            make.height.equalTo(75)
        }
    }
    
    private func setScrollView() {
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
    
    private func setMovieImage() {
        movieImage.image = UIImage(named: "Logo")
        contentView.addSubview(movieImage)
        
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(225)
        }
    }
    
    private func setMovieTitle() {
        movieTitle.text = "스미스 머신"
        movieTitle.font = .boldSystemFont(ofSize: 40)
        
        contentView.addSubview(movieTitle)
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    private func setNftLevel() {
        nftLevel.text = "NORMAL"
        nftLevel.font = .boldSystemFont(ofSize: 25)
        nftLevel.textColor = UIColor(red: 95/255, green: 159/255, blue: 255/255, alpha: 1)
        
        contentView.addSubview(nftLevel)
        
        nftLevel.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    private func setDividLine() {
        lineView.backgroundColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 0.3)
        contentView.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nftLevel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(2)
        }
    }
    
    private func setSalePeriod() {
        salePeriod.text = "23.11.11 ~ 23.12.13"
        salePeriod.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(salePeriod)
        
        salePeriod.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    private func setBuyButton() {
        buyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        contentView.addSubview(buyButton)
        
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(salePeriod.snp.bottom).offset(20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    
    private func setBottomDividLine() {
        bottomLineView.backgroundColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 0.3)
        contentView.addSubview(bottomLineView)
        
        bottomLineView.snp.makeConstraints { make in
            make.top.equalTo(buyButton.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(2)
        }
    }
    
    private func setDirector() {
        director.text = "감독 :"
        director.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(director)
        
        director.snp.makeConstraints { make in
            make.top.equalTo(bottomLineView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setDirectorContent() {
        directorContent.text = "이건준"
        directorContent.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(directorContent)
        
        directorContent.snp.makeConstraints { make in
            make.top.equalTo(bottomLineView.snp.bottom).offset(20)
            make.leading.equalTo(director.snp.trailing).offset(10)
        }
    }

    private func setActors() {
        actors.text = "배우 :"
        actors.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(actors)
        
        actors.snp.makeConstraints { make in
            make.top.equalTo(director.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setActorContent() {
        actorContent.text = "만두"
        actorContent.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(actorContent)
        
        actorContent.snp.makeConstraints { make in
            make.top.equalTo(director.snp.bottom).offset(20)
            make.leading.equalTo(actors.snp.trailing).offset(10)
        }
    }
    
    private func setMovieInfo() {
        movieInfo.text = "23.11.11 | 12세 관람가 | 120분 | 액션"
        movieInfo.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(movieInfo)
        
        movieInfo.snp.makeConstraints { make in
            make.top.equalTo(actorContent.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }

    private func setPlot() {
        plot.text = "줄거리"
        plot.font = .boldSystemFont(ofSize: 30)
        contentView.addSubview(plot)
        
        plot.snp.makeConstraints { make in
            make.top.equalTo(movieInfo.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setPlotContent() {
        plotContent.numberOfLines = 0
        plotContent.text = "어느 한적한 마을의 조그마한 약재상."
        plotContent.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(plotContent)
        
        plotContent.snp.makeConstraints { make in
            make.top.equalTo(plot.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
}
