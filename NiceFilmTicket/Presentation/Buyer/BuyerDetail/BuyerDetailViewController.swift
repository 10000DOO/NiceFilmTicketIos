//
//  BuyerDetailViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 10/25/23.
//

import UIKit
import Combine
import Kingfisher

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
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(signInService: SignInService(signInRepository: SignInRepository())))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }
        
        buyerDetailViewModel.updateMovieData(store: &cancellable) { [weak self] movieData in
            if let url = URL(string: movieData.poster) {
                self?.buyerDetailView.movieImage.kf.setImage(with: url)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buyerDetailViewModel.getMovie(id: movieId!)
    }
}
