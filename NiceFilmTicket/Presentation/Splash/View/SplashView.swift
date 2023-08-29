//
//  SplashView.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/29.
//

import UIKit
import SnapKit

class SplashView: UIView {
    
    var imageView: UIImageView!
    var centerYConstraint: Constraint?
    var safeAreaView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        // 이미지 뷰 생성
        imageView = UIImageView(image: UIImage(named: "SplashImage"))
        self.addSubview(imageView)
        
        // 이미지 뷰의 제약 조건 설정
        imageView.snp.makeConstraints { make in
            centerYConstraint = make.centerY.equalTo(self.snp.centerY).constraint
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(210)
            make.height.equalTo(150)
        }
        
        // safeArea의 테두리를 설정
        safeAreaView = UIView()
        safeAreaView.backgroundColor = .clear
        safeAreaView.layer.borderWidth = 8
        safeAreaView.layer.cornerRadius = 10
        safeAreaView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        self.addSubview(safeAreaView)
        
        safeAreaView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(UIEdgeInsets(top :50 , left :50 , bottom :50 , right :50 ))
        }
    }
    
    required init?(coder aDecoder : NSCoder ) {
        fatalError("SplashView(coder:) has not been implemented")
    }
}
