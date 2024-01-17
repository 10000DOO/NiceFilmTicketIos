//
//  BuyerDetailViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/25/23.
//

import UIKit
import Combine

class BuyerDetailViewController: UIViewController {

    private let buyerDetailView = BuyerDetailView()
    private let buyerDetailViewModel: BuyerDetailViewModel
    var cancellable = Set<AnyCancellable>()
    var movieId: Int?
    
    init(buyerDetailViewModel: BuyerDetailViewModel) {
        self.buyerDetailViewModel = buyerDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("BuyerDetailViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(buyerDetailView)
        
        buyerDetailViewModel.refreshTokenExpired(store: &cancellable) { [weak self] result in
            if result {
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository(), emailService: EmailService(emailRepository: EmailRepository()))))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }
        
        buyerDetailViewModel.updateMovieData(store: &cancellable) { [weak self] movieData in
            if let url = URL(string: movieData.poster) {
                self?.buyerDetailView.movieImage.configureImage(url: url)
            }
            self?.buyerDetailView.movieTitle.text = movieData.movieTitle
            self?.buyerDetailView.nftLevel.text = movieData.nftLevel
            self?.buyerDetailView.salePeriod.text = "\(movieData.saleStartTime) ~ \(movieData.saleEndTime)"
            self?.buyerDetailView.buyButton.setTitle("\(movieData.normalNFTPrice)원", for: .normal)
            self?.buyerDetailView.directorContent.text = movieData.director
            self?.buyerDetailView.actorContent.text = movieData.actors
            self?.buyerDetailView.movieInfo.text = "\(movieData.createdAt) | \(movieData.filmRating) | \(movieData.runningTime)분 | \(movieData.movieGenre)"
            self?.buyerDetailView.plotContent.text = movieData.description
        }
        
        let purchaseNft = UITapGestureRecognizer(target: self, action: #selector(purchaseNft))
        buyerDetailView.buyButton.addGestureRecognizer(purchaseNft)
        
        buyerDetailViewModel.isBuySuccess(store: &cancellable) { [weak self] result in
            if !result {
                let alert = UIAlertController(title: "구매 실패", message: "존재하지 않는 NFT입니다.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                
                alert.addAction(confirm)
                
                self?.present(alert, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buyerDetailViewModel.getMovie(id: movieId ?? 1)
    }
}

extension BuyerDetailViewController {
    @objc func purchaseNft() {
        let alert = UIAlertController(title: "구매하시겠습니까?", message: "구매 후 취소하실 수 없습니다.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "네", style: .default) { [weak self] action in
            self?.buyerDetailViewModel.buyNft(id: self?.movieId ?? 1)
        }
        let cancel = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
