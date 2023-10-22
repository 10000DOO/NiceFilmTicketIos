//
//  BuyerMainViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit
import SnapKit
import Combine

class BuyerMainViewController: UIViewController {
    
    private let buyerMainView = BuyerMainView()
    private let buyerMainViewModel: BuyerMainViewModel
    var cancellable: Set<AnyCancellable> = []
    
    init(buyerMainViewModel: BuyerMainViewModel) {
        self.buyerMainViewModel = buyerMainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("BuyerMainViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(buyerMainView)
        listUpButtonSet()
        
        buyerMainView.tableView.delegate = self
        buyerMainView.tableView.dataSource = self
        buyerMainView.tableView.register(BuyerMainTableViewCell.self, forCellReuseIdentifier: "buyerMainTableViewCell")
        hideKeyboardWhenTappedAround()
        
        buyerMainViewModel.refreshTokenExpired(store: &cancellable) { [weak self] result in
            if result {
                let signInVC = SignInViewController(signInViewModel: SignInViewModel(signInService: SignInService(signInRepository: SignInRepository())))
                signInVC.modalPresentationStyle = .fullScreen
                self?.present(signInVC, animated: true, completion: nil)
            }
        }
        
        buyerMainViewModel.$movieData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.buyerMainView.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buyerMainViewModel.getMovies(sortType: "최신순")
    }
}

extension BuyerMainViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func listUpButtonSet() {
        let optionHandler = { [weak self] (action: UIAction) in
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor(red: 8/255, green: 30/255, blue: 92/255,alpha: 1)
            ]
            
            let attributedTitle = NSAttributedString(string: action.title, attributes :attributes)
            
            self?.buyerMainView.listUpButton.setAttributedTitle(attributedTitle, for:.normal)
            self?.buyerMainViewModel.sortType = action.title
            self?.buyerMainViewModel.movieData = []
            self?.buyerMainViewModel.page = 0
            self?.buyerMainViewModel.getMovies(sortType: action.title)
        }
        
        buyerMainView.listUpButton.menu = UIMenu(children: [UIAction(title:"최신순", state: .on, handler: optionHandler),
                                                            UIAction(title:"이름순", handler: optionHandler)])
        buyerMainView.listUpButton.showsMenuAsPrimaryAction = true
        buyerMainView.listUpButton.changesSelectionAsPrimaryAction = true
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil)
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}

extension BuyerMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buyerMainViewModel.movieData.count == 0 {
            return 4
        } else {
            return buyerMainViewModel.movieData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyerMainTableViewCell", for: indexPath) as! BuyerMainTableViewCell
        
        buyerMainViewModel.updateMovieData(index: indexPath.row, store: &cell.cancellable) { [weak self] movieData in
            cell.leftMoiveTitle.text = movieData.leftMovieMovieTitle
            self?.downloadImage(url: movieData.leftMoviePoster) { image in
                if let image = image {
                    cell.leftMovieImage.image = image
                }
            }
            if let url = movieData.rightMoviePoster {
                cell.rightMoiveTitle.text = movieData.rightMovieMovieTitle!
                self?.downloadImage(url: url) { image in
                    if let image = image {
                        cell.rightMovieImage.image = image
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if buyerMainView.tableView.contentOffset.y > (buyerMainView.tableView.contentSize.height - buyerMainView.tableView.bounds.size.height) * 0.8 {
            if buyerMainViewModel.fetchMoreResult {
                buyerMainViewModel.getMovies(sortType: buyerMainViewModel.sortType)
                buyerMainView.tableView.reloadData()
            }
        }
    }
}
