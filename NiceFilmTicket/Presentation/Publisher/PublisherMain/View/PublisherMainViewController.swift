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
        
        publisherMainViewModel.refreshTokenExpired(store: &cancellable) { [weak self] result in
            if result {
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository(), emailService: EmailService(emailRepository: EmailRepository()))))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }
        
        publisherMainView.registerButton.addTarget(self, action: #selector(moveToIssueNftView), for: .touchUpInside)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        publisherMainViewModel.getIssuedNft(store: &cancellable)
        publisherMainView.tableView.reloadData()
    }
}

extension PublisherMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if publisherMainViewModel.nftList.count == 0 {
            return 15
        } else {
            return publisherMainViewModel.nftList.count
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if publisherMainView.tableView.contentOffset.y > (publisherMainView.tableView.contentSize.height - publisherMainView.tableView.bounds.size.height) * 0.8 {
            if publisherMainViewModel.fetchMoreResult {
                publisherMainViewModel.getIssuedNft(store: &cancellable)
                publisherMainView.tableView.reloadData()
            }
        }
    }
}

extension PublisherMainViewController {
    @objc func moveToIssueNftView() {
        let IssueNftViewControler = UIStoryboard(name: "IssueNft", bundle: nil).instantiateViewController(withIdentifier: "IssueNftViewController") as! IssueNftViewController
        IssueNftViewControler.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(IssueNftViewControler, animated: false)
    }
}
