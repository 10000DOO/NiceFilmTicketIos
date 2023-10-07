//
//  AgeLimitViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/04.
//

import UIKit

class AgeLimitViewController: UIViewController {
    
    private let ageLimitView = AgeLimitView()
    weak var issueNftDelegate: IssueNftViewDelegate?
    private let ageLimit: [AgeLimit] = [
        .G_RATED,
        .PG12,
        .PG15,
        .PG18
    ]

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("AgeLimitViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(ageLimitView)
        
        ageLimitView.tableView.delegate = self
        ageLimitView.tableView.dataSource = self
        ageLimitView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension AgeLimitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ageLimit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let ageLimit = ageLimit[indexPath.row]
        cell.textLabel?.text = ageLimit.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAgeLimit = ageLimit[indexPath.row]
        issueNftDelegate?.setAgeLimit(age: selectedAgeLimit)
        self.dismiss(animated: true, completion: nil)
    }
}
