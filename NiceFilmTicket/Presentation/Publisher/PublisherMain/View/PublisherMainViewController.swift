//
//  PublisherMainPageViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/12.
//

import UIKit
import SnapKit
import Combine

class PublisherMainViewController: UIViewController {
    
    private let publisherMainView = PublisherMainView()
    private let publisherMainViewModel: PublisherMainViewModel
    var cancellable: Set<AnyCancellable> = []
    
    init(publisherMainViewModel: PublisherMainViewModel) {
        self.publisherMainViewModel = publisherMainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("PublisherMainViewController(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(publisherMainView)
        
        publisherMainView.tableView.delegate = self
        publisherMainView.tableView.dataSource = self
        publisherMainView.tableView.register(PublisherMainTableViewCell.self, forCellReuseIdentifier: "publishedNftCell")
        
        publisherMainViewModel.getIssuedNft()
        
        publisherMainViewModel.$refreshTokenExpired.sink { [weak self] refreshTokenExpired in
            if refreshTokenExpired {
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(signInService: SignInService(signInRepository: SignInRepository())))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }.store(in: &cancellable)
        publisherMainView.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}

extension PublisherMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "publishedNftCell", for: indexPath) as! PublisherMainTableViewCell
        
        publisherMainViewModel.getNftList(index: indexPath.row, store: &cell.cancellable) { nftItem in
            cell.numLabel.text = (indexPath.row + 1).description
            cell.priceLabel.text = nftItem.nftPrice.description
            cell.nftStockLabel.text = nftItem.nftCount.description
            let text = nftItem.movieTitle
            if text.count > 5 {
                let truncatedText = (text as NSString).substring(to: 5) + "..."
                cell.movieTitleLabel.text = truncatedText
            } else {
                cell.movieTitleLabel.text = text
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
