//
//  ViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/08/24.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트 라벨 생성
        let label = UILabel()
        label.text = "기본 테스트 입니다."
        label.textAlignment = .center // 텍스트 정렬을 가운데로 설정
        
        // 라벨을 화면에 추가하고, 제약 조건 설정
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.backgroundColor = .white
        
    }
    
    
}

