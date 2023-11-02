//
//  DrawNftViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit

class DrawNftViewController: UIViewController {
    
    private let drawNftView = DrawNftView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("DrawNftViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(drawNftView)
        
        drawNftView.firstNFT.isUserInteractionEnabled = true
        drawNftView.secondNFT.isUserInteractionEnabled = true
        drawNftView.thirdNFT.isUserInteractionEnabled = true
        
        let selectFirstNFT = UITapGestureRecognizer(target: self, action: #selector(selectFirstNFT))
        drawNftView.firstNFT.addGestureRecognizer(selectFirstNFT)
        
        let selectSecondNFT = UITapGestureRecognizer(target: self, action: #selector(selectSecondNFT))
        drawNftView.secondNFT.addGestureRecognizer(selectSecondNFT)
        
        let selectThirdNFT = UITapGestureRecognizer(target: self, action: #selector(selectThirdNFT))
        drawNftView.thirdNFT.addGestureRecognizer(selectThirdNFT)
    }
}

extension DrawNftViewController {
    
    @objc func selectFirstNFT() {
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(myNftService: MyNftService(myNftRepository: MyNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        self.present(myNftVc, animated: true, completion: nil)
    }
    
    @objc func selectSecondNFT() {
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(myNftService: MyNftService(myNftRepository: MyNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        self.present(myNftVc, animated: true, completion: nil)
    }
    
    @objc func selectThirdNFT() {
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(myNftService: MyNftService(myNftRepository: MyNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        self.present(myNftVc, animated: true, completion: nil)
    }
}
