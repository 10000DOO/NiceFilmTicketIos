//
//  SignUpViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/26.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let logoImageView = UIImageView(image: UIImage(named: "Logo"))
        view.addSubview(logoImageView)
        
        // 로고이미지 뷰의 제약 조건 설정
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(350)
            make.height.equalTo(450)
        }
        
        // 회원가입 텍스트 레이블 생성
        let signUpText = UILabel()
        signUpText.text = "회원가입"
        signUpText.textAlignment = .center
        signUpText.font = UIFont.boldSystemFont(ofSize: 25)
        signUpText.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        view.addSubview(signUpText)
        
        // 개인로그인 텍스트 제약 조건
        signUpText.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.top.equalTo(logoImageView.snp.bottom).offset(-110)
        }
    }
}
