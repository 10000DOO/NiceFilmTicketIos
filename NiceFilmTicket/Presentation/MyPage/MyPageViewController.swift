//
//  MyPageViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/12.
//

import UIKit
import Combine
import Kingfisher

class MyPageViewController: UIViewController {

    private let myPageView = MyPageView()
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(myPageView)
        listUpButtonSet()
        
        myPageView.searchTextField.delegate = self
        myPageView.tableView.delegate = self
        myPageView.tableView.dataSource = self
        myPageView.searchTableView.delegate = self
        myPageView.searchTableView.dataSource = self
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
    
    func listUpButtonSet() {
        let optionHandler = { [weak self] (action: UIAction) in
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor(red: 8/255, green: 30/255, blue: 92/255,alpha: 1)
            ]
            
            let attributedTitle = NSAttributedString(string: action.title, attributes :attributes)
            
            self?.myPageView.listUpButton.setAttributedTitle(attributedTitle, for:.normal)
//            self?.buyerMainViewModel.sortType = action.title
//            self?.buyerMainViewModel.movieData = []
//            self?.buyerMainViewModel.page = 0
//            self?.buyerMainViewModel.getMovies(sortType: action.title)
        }
        
        myPageView.listUpButton.menu = UIMenu(children: [UIAction(title:"최신순", state: .on, handler: optionHandler),
                                                            UIAction(title:"이름순", handler: optionHandler)])
        myPageView.listUpButton.showsMenuAsPrimaryAction = true
        myPageView.listUpButton.changesSelectionAsPrimaryAction = true
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource, BuyerMainTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func imageViewTapped(in cell: BuyerMainTableViewCell, imageViewIndex: Int) {
        <#code#>
    }
    
    
}

extension MyPageViewController: UITextFieldDelegate {
}
