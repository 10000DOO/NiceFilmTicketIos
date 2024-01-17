//
//  DrawNftViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit
import Combine

class DrawNftViewController: UIViewController {
    
    private let drawNftView = DrawNftView()
    private let drawNftViewModel: DrawNftViewModel
    var cancellables = Set<AnyCancellable>()
    
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
        
        drawNftViewModel.refreshTokenExpired(store: &cancellables) { [weak self] result in
            if result {
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository(), emailService: EmailService(emailRepository: EmailRepository()))))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }

        drawNftViewModel.drawnNftChanged(store: &cancellables) { [weak self] newNftData in
            let drawResultVC = DrawResultViewController()
            drawResultVC.modalPresentationStyle = .overCurrentContext
            drawResultVC.movieTitle = newNftData.movieName
            drawResultVC.nftLevel = newNftData.nftLevel
            drawResultVC.nftImage = newNftData.mediaUrl
            self?.present(drawResultVC, animated: true, completion: nil)
        }
        
        let selectFirstNFT = UITapGestureRecognizer(target: self, action: #selector(selectFirstNFT))
        drawNftView.firstNFT.addGestureRecognizer(selectFirstNFT)
        
        let selectSecondNFT = UITapGestureRecognizer(target: self, action: #selector(selectSecondNFT))
        drawNftView.secondNFT.addGestureRecognizer(selectSecondNFT)
        
        let selectThirdNFT = UITapGestureRecognizer(target: self, action: #selector(selectThirdNFT))
        drawNftView.thirdNFT.addGestureRecognizer(selectThirdNFT)
        
        let drawNft = UITapGestureRecognizer(target: self, action: #selector(drawNft))
        drawNftView.drawButton.addGestureRecognizer(drawNft)
    }
}

extension DrawNftViewController {
    
    @objc func selectFirstNFT() {
        drawNftViewModel.firstNftSelected = true
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(nftService: NFTService(nftRepository: NFTRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        myNftVc.delegate = self
        self.present(myNftVc, animated: true, completion: nil)
    }
    
    @objc func selectSecondNFT() {
        drawNftViewModel.secondNftSelected = true
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(nftService: NFTService(nftRepository: NFTRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        myNftVc.delegate = self
        self.present(myNftVc, animated: true, completion: nil)
    }
    
    @objc func selectThirdNFT() {
        drawNftViewModel.thirdNftSelected = true
        let myNftVc = MyNftViewController(myNftViewModel: MyNftViewModel(nftService: NFTService(nftRepository: NFTRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        myNftVc.delegate = self
        self.present(myNftVc, animated: true, completion: nil)
    }
    
    @objc func drawNft() {
        if drawNftViewModel.firstNft != nil && drawNftViewModel.secondNft != nil && drawNftViewModel.thirdNft != nil {
            drawNftViewModel.drawNft()
        }
    }
}

extension DrawNftViewController: DrawNftViewDelegate {
    func setSelectedNft(nftInfo: NFTPickDto) {
        if drawNftViewModel.firstNftSelected {
            if nftInfo != drawNftViewModel.secondNft && nftInfo != drawNftViewModel.thirdNft {
                drawNftViewModel.firstNft = nftInfo
                if let url = URL(string: nftInfo.poster) {
                    drawNftView.firstNFT.configureImage(url: url)
                }
                drawNftViewModel.firstNftSelected = false
            }
        }
        
        if drawNftViewModel.secondNftSelected {
            if nftInfo != drawNftViewModel.firstNft && nftInfo != drawNftViewModel.thirdNft {
                drawNftViewModel.secondNft = nftInfo
                if let url = URL(string: nftInfo.poster) {
                    drawNftView.secondNFT.configureImage(url: url)
                }
                drawNftViewModel.secondNftSelected = false
            }
        }
        
        if drawNftViewModel.thirdNftSelected {
            if nftInfo != drawNftViewModel.firstNft && nftInfo != drawNftViewModel.secondNft {
                drawNftViewModel.thirdNft = nftInfo
                if let url = URL(string: nftInfo.poster) {
                    drawNftView.thirdNFT.configureImage(url: url)
                }
                drawNftViewModel.thirdNftSelected = false
            }
        }
    }
}
