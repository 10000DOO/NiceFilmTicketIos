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
    weak var issueNftDelegate: IssueNftViewDelegate?
    private let allGenres: [MovieGenre] = [
        .ACTION,
        .ADVENTURE,
        .FANTASY,
        .SCIENCEFICTION,
        .NOIR,
        .WAR,
        .HORROR,
        .THRILLER,
        .MYSTERY,
        .ROMANCE,
        .COMEDY,
        .DRAMA,
        .ANIMATION,
        .ART,
        .MUSICAL,
        .DOCUMENTARY,
        .MUMBLECORE,
        .EDUCATION,
        .NARRATIVE,
        .EXPERIMENT,
        .EXPLOITATION,
        .DISASTER,
        .CONCERT,
        .CRIME,
        .SUPERHERO,
        .SPORT
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
        return allGenres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let genre = allGenres[indexPath.row]
        cell.textLabel?.text = genre.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGenre = allGenres[indexPath.row]
        issueNftDelegate?.setGenre(genre: selectedGenre)
        self.dismiss(animated: true, completion: nil)
    }
}
