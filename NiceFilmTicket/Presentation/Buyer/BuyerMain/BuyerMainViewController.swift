//
//  BuyerMainViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit
import SnapKit
import Combine
import Kingfisher

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
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(buyerMainView)
        listUpButtonSet()
        
        buyerMainView.searchTextField.delegate = self
        buyerMainView.tableView.delegate = self
        buyerMainView.tableView.dataSource = self
        buyerMainView.searchTableView.delegate = self
        buyerMainView.searchTableView.dataSource = self
        buyerMainView.searchTableView.register(BuyerMainTableViewCell.self, forCellReuseIdentifier: "buyerMainTableViewCell")
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
        
        buyerMainViewModel.$searchedMovieData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.buyerMainView.searchTableView.reloadData()
            }
            .store(in: &cancellable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if buyerMainView.searchTextField.text == "" {
            buyerMainView.searchTableView.isHidden = true
            if buyerMainViewModel.movieData.count == 0 {
                buyerMainViewModel.getMovies(sortType: "최신순")
            }
        }
    }
}

extension BuyerMainViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BuyerMainViewController.dismissKeyboard))
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

extension BuyerMainViewController: UITableViewDelegate, UITableViewDataSource, BuyerMainTableViewCellDelegate {
    func imageViewTapped(in cell: BuyerMainTableViewCell, imageViewIndex: Int) {
        if buyerMainView.searchTableView.isHidden {
            if let indexPath = buyerMainView.tableView.indexPath(for :cell){
                if imageViewIndex == 0 {
                    let detailVC = BuyerDetailViewController(buyerDetailViewModel: BuyerDetailViewModel(refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository()), movieDetailService: MovieDetailService(movieDetailRepository: MovieDetailRepository())))
                    detailVC.movieId = buyerMainViewModel.movieData[indexPath.row].leftMovieId
                    self.navigationController?.pushViewController(detailVC, animated: false)
                } else if imageViewIndex == 1 {
                    let detailVC = BuyerDetailViewController(buyerDetailViewModel: BuyerDetailViewModel(refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository()), movieDetailService: MovieDetailService(movieDetailRepository: MovieDetailRepository())))
                    detailVC.movieId = buyerMainViewModel.movieData[indexPath.row].rightMovieId
                    self.navigationController?.pushViewController(detailVC, animated: false)
                }
            }
        } else {
            if let indexPath = buyerMainView.searchTableView.indexPath(for :cell){
                if indexPath.row < buyerMainViewModel.searchedMovieData.count {
                    if imageViewIndex == 0 {
                        let detailVC = BuyerDetailViewController(buyerDetailViewModel: BuyerDetailViewModel(refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository()), movieDetailService: MovieDetailService(movieDetailRepository: MovieDetailRepository())))
                        detailVC.movieId = buyerMainViewModel.searchedMovieData[indexPath.row].leftMovieId
                        self.navigationController?.pushViewController(detailVC, animated: false)
                    } else if imageViewIndex == 1 {
                        if buyerMainViewModel.searchedMovieData[indexPath.row].rightMovieId != nil {
                            let detailVC = BuyerDetailViewController(buyerDetailViewModel: BuyerDetailViewModel(refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository()), movieDetailService: MovieDetailService(movieDetailRepository: MovieDetailRepository())))
                            detailVC.movieId = buyerMainViewModel.searchedMovieData[indexPath.row].rightMovieId
                            self.navigationController?.pushViewController(detailVC, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == buyerMainView.tableView {
            if buyerMainViewModel.movieData.count == 0 {
                return 4
            } else {
                return buyerMainViewModel.movieData.count
            }
        } else {
            if buyerMainViewModel.searchedMovieData.count == 0 {
                return 4
            } else {
                return buyerMainViewModel.searchedMovieData.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyerMainTableViewCell", for: indexPath) as! BuyerMainTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        
        if tableView == buyerMainView.tableView {
            buyerMainViewModel.updateMovieData(index: indexPath.row, store: &cell.cancellable) { movieData in
                cell.leftMoiveTitle.text = movieData.leftMovieMovieTitle
                if let url = URL(string: movieData.leftMoviePoster) {
                    cell.leftMovieImage.kf.setImage(with: url)
                }
                
                if movieData.rightMovieId != nil {
                    if let url = URL(string: movieData.rightMoviePoster!) {
                        cell.rightMoiveTitle.text = movieData.rightMovieMovieTitle!
                        cell.rightMovieImage.kf.setImage(with:url)
                    }
                } else {
                    cell.rightMoiveTitle.text = ""
                    cell.rightMovieImage.image = nil
                }
            }
        } else {
            buyerMainViewModel.updateSearchedMovieData(index: indexPath.row, store: &cell.cancellable) { movieData in
                cell.leftMoiveTitle.text = movieData.leftMovieMovieTitle
                if let url = URL(string: movieData.leftMoviePoster) {
                    cell.leftMovieImage.kf.setImage(with: url)
                }
                
                if movieData.rightMovieId != nil {
                    if let url = URL(string: movieData.rightMoviePoster!) {
                        cell.rightMoiveTitle.text = movieData.rightMovieMovieTitle!
                        cell.rightMovieImage.kf.setImage(with:url)
                    }
                } else {
                    cell.rightMoiveTitle.text = ""
                    cell.rightMovieImage.image = nil
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if buyerMainView.searchTableView.isHidden {
            if buyerMainView.tableView.contentOffset.y > (buyerMainView.tableView.contentSize.height - buyerMainView.tableView.bounds.size.height) * 0.8 {
                if buyerMainViewModel.fetchMoreResult {
                    buyerMainViewModel.getMovies(sortType: buyerMainViewModel.sortType)
                }
            }
        } else {
            if buyerMainView.searchTableView.contentOffset.y > (buyerMainView.searchTableView.contentSize.height - buyerMainView.searchTableView.bounds.size.height) * 0.8 {
                if buyerMainViewModel.fetchMoreSearchedMovieData {
                    buyerMainViewModel.searchMovie(movieTitle: buyerMainView.searchTextField.text ?? "")
                }
            }
        }
    }
}

extension BuyerMainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText = textField.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        var searchText = currentText.replacingCharacters(in: stringRange, with: string)
        
        print(searchText)
        buyerMainViewModel.fetchForPaging = false
        buyerMainViewModel.fetchMoreSearchedMovieData = false
        buyerMainViewModel.searchPage = 0
        if searchText != "" {
            buyerMainViewModel.searchMovie(movieTitle: searchText)
            buyerMainView.tableView.isHidden = true
            buyerMainView.searchTableView.isHidden = false
        } else {
            buyerMainView.tableView.isHidden = false
            buyerMainView.searchTableView.isHidden = true
        }
        buyerMainViewModel.fetchForPaging = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
