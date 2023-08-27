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
        //뒤로가기 제스쳐는 살리고 백버튼 지우기
        self.navigationController?.navigationBar.isHidden = true
        
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
        let signUpText = MenuUILabel(text: "회원가입", size: UIFont.boldSystemFont(ofSize: 25))
        view.addSubview(signUpText)
        
        // 회원가입 텍스트 제약 조건
        signUpText.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(logoImageView.snp.bottom).offset(-110)
        }
        
        //이메일 입력 텍스트 필드
        let emailTextField = AuthenticationTextField(placeholder: "  이메일", isSecureTextEntry: false, backgroundColor: .clear, isHidden: false, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(signUpText.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(view.snp.leading).inset(30)
            make.trailing.equalTo(view.snp.trailing).inset(30)
        }
    }
}
