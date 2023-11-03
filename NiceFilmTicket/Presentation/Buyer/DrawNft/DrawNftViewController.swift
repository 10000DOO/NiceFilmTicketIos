//
//  DrawNftViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit
import Kingfisher

class DrawNftViewController: UIViewController {
    
    private let drawNftView = DrawNftView()
    private let drawNftViewModel: DrawNftViewModel
    init(drawNftViewModel: DrawNftViewModel) {
        self.drawNftViewModel = drawNftViewModel
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
        drawNftViewModel.firstNftSelected = true
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(myNftService: MyNftService(myNftRepository: MyNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        myNftVc.delegate = self
        self.present(myNftVc, animated: true, completion: nil)
    }
    
    @objc func selectSecondNFT() {
        drawNftViewModel.secondNftSelected = true
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(myNftService: MyNftService(myNftRepository: MyNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        myNftVc.delegate = self
        self.present(myNftVc, animated: true, completion: nil)
    }
    
    @objc func selectThirdNFT() {
        drawNftViewModel.thirdNftSelected = true
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(myNftService: MyNftService(myNftRepository: MyNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        myNftVc.delegate = self
        self.present(myNftVc, animated: true, completion: nil)
    }
}

extension DrawNftViewController: DrawNftViewDelegate {
    func setSelectedNft(nftInfo: NFTPickDto) {
        if drawNftViewModel.firstNftSelected {
            drawNftViewModel.firstNft = nftInfo
            if let url = URL(string: nftInfo.poster) {
                drawNftView.firstNFT.kf.setImage(with: url)
            }
            drawNftViewModel.firstNftSelected = false
        }
        
        if drawNftViewModel.secondNftSelected {
            drawNftViewModel.secondNft = nftInfo
            if let url = URL(string: nftInfo.poster) {
                drawNftView.secondNFT.kf.setImage(with: url)
            }
            drawNftViewModel.secondNftSelected = false
        }
        
        if drawNftViewModel.thirdNftSelected {
            drawNftViewModel.thirdNft = nftInfo
            if let url = URL(string: nftInfo.poster) {
                drawNftView.thirdNFT.kf.setImage(with: url)
            }
            drawNftViewModel.thirdNftSelected = false
        }
    }
}
