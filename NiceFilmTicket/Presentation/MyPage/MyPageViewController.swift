//
//  MyPageViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/12.
//

import UIKit
import Combine

class MyPageViewController: UIViewController {

    private let myPageView = MyPageView()
    private let myPageViewModel: MyPageViewModel
    var cancellable = Set<AnyCancellable>()
    
    init(myPageViewModel: MyPageViewModel) {
        self.myPageViewModel = myPageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MyPageViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(myPageView)

        myPageView.tableView.delegate = self
        myPageView.tableView.dataSource = self
        myPageView.tableView.register(BuyerMainTableViewCell.self, forCellReuseIdentifier: "buyerMainTableViewCell")
        hideKeyboardWhenTappedAround()
        
        myPageViewModel.refreshTokenExpired(store: &cancellable) { [weak self] result in
            if result {
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository(), emailService: EmailService(emailRepository: EmailRepository()))))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }
        
        myPageViewModel.updateNormalNftCount(store: &cancellable) { [weak self] result in
            self?.myPageView.normalCount.text = result.description
        }
        
        myPageViewModel.updateRareNftCount(store: &cancellable) { [weak self] result in
            self?.myPageView.rareCount.text = result.description
        }
        
        myPageViewModel.updateLegendNftCount(store: &cancellable) { [weak self] result in
            self?.myPageView.legendCount.text = result.description
        }
        
        myPageViewModel.$nftData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.myPageView.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if myPageViewModel.nftData.count == 0 {
            myPageViewModel.getMyNftList(username: UserDefaults.standard.string(forKey: "username")!)
        }
    }
}

extension MyPageViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BuyerMainViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myPageViewModel.nftData.count == 0 {
            return 4
        } else {
            return myPageViewModel.nftData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyerMainTableViewCell", for: indexPath) as! BuyerMainTableViewCell
        cell.selectionStyle = .none
        
        myPageViewModel.updateNftData(index: indexPath.row, store: &cell.cancellable) { nftData in
            cell.leftMoiveTitle.text = nftData.leftMovieTitle
            if let url = URL(string: nftData.leftPoster) {
                cell.leftMovieImage.configureImage(url: url)
            }
            
            if nftData.rightMovieTitle != nil {
                if let url = URL(string: nftData.rightPoster!) {
                    cell.rightMoiveTitle.text = nftData.rightMovieTitle!
                    cell.rightMovieImage.configureImage(url: url)
                }
            } else {
                cell.rightMoiveTitle.text = ""
                cell.rightMovieImage.image = nil
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if myPageView.tableView.contentOffset.y > (myPageView.tableView.contentSize.height - myPageView.tableView.bounds.size.height) * 0.8 {
            if myPageViewModel.fetchMoreResult {
                myPageViewModel.getMyNftList(username: UserDefaults.standard.string(forKey: "username")!)
            }
        }
    }
}
