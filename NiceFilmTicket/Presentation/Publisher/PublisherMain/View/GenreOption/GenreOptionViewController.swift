//
//  GenreOptionViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/03.
//

import UIKit
import SnapKit

class GenreOptionViewController: UIViewController {
    
    private let genreOptionView = GenreOptionView()
    let allGenres: [MoiveGenre] = [
        .action,
        .adventure,
        .fantasy,
        .scienceFiction,
        .noir,
        .war,
        .horror,
        .thriller,
        .mystery,
        .romance,
        .comedy,
        .drama,
        .animation,
        .art,
        .musical,
        .documentary,
        .mumblecore,
        .education,
        .narrative,
        .experiment,
        .exploitation,
        .disaster,
        .concert,
        .crime,
        .superhero,
        .sport
    ]
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("GenreOptionViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(genreOptionView)
        
        genreOptionView.tableView.delegate = self
        genreOptionView.tableView.dataSource = self
        genreOptionView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension GenreOptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 26
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let genre = allGenres[indexPath.row]
        cell.textLabel?.text = genre.rawValue
        
        return cell
    }
}
