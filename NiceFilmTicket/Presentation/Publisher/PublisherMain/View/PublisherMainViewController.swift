//
//  PublisherMainPageViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/12.
//

import UIKit
import SnapKit

class PublisherMainViewController: UIViewController {

    private let publisherMainView = PublisherMainView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(publisherMainView)
    }
}
