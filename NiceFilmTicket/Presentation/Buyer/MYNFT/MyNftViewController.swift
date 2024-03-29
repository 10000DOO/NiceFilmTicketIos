//
//  MyNftViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/2/23.
//

import UIKit
import SnapKit
import Combine

class MyNftViewController: UIViewController {

    private let myNftView = MyNftView()
    private let myNftViewModel: MyNftViewModel
    weak var delegate: DrawNftViewDelegate?
    var cancellables = Set<AnyCancellable>()
    
    init(myNftViewModel: MyNftViewModel) {
        self.myNftViewModel = myNftViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MyNftViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myNftView)
        
        myNftView.tableView.delegate = self
        myNftView.tableView.dataSource = self
        
        myNftView.tableView.register(MyNftTableViewCell.self, forCellReuseIdentifier: "myNftTableViewCell")
        
        myNftViewModel.refreshTokenExpired(store: &cancellables) { [weak self] result in
            if result {
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository(), emailService: EmailService(emailRepository: EmailRepository()))))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }
        
        myNftViewModel.$nftData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.myNftView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myNftViewModel.getMyNft(username: UserDefaults.standard.string(forKey: "username")!, size: 8)
    }
}

extension MyNftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myNftViewModel.nftData.count == 0 {
            return 8
        } else {
            return myNftViewModel.nftData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myNftTableViewCell", for: indexPath) as! MyNftTableViewCell
        cell.selectionStyle = .none
        
        myNftViewModel.updateNftData(index: indexPath.row, store: &cell.cancellables) { nftData in
            if let url = URL(string: nftData.poster) {
                cell.nftImage.configureImage(url: url)
            }
            if nftData.nftLevel == "NORMAL" {
                cell.nftLevel.textColor = UIColor(red: 50/255, green: 173/255, blue: 230/255, alpha: 1)
            } else if nftData.nftLevel == "RARE" {
                cell.nftLevel.textColor = .green
            } else {
                cell.nftLevel.textColor = .red
            }
            cell.nftLevel.text = nftData.nftLevel
            let text = nftData.movieTitle
            if text.count > 5 {
                let truncatedText = (text as NSString).substring(to: 5) + "..."
                cell.movieTitle.text = truncatedText
            } else {
                cell.movieTitle.text = text
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNft = myNftViewModel.nftData[indexPath.row]
        delegate?.setSelectedNft(nftInfo: selectedNft)
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if myNftView.tableView.contentOffset.y > (myNftView.tableView.contentSize.height - myNftView.tableView.bounds.size.height) * 0.8 {
            if myNftViewModel.fetchMoreResult {
                myNftViewModel.getMyNft(username: UserDefaults.standard.string(forKey: "username")!, size: 8)
            }
        }
    }
}
