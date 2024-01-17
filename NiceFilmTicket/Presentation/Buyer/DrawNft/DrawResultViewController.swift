//
//  DrawResultViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/5/23.
//

import UIKit

class DrawResultViewController: UIViewController {
    
    private let drawResultView = DrawResultView()
    var movieTitle = ""
    var nftLevel = ""
    var nftImage = ""
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("DrawResultViewController(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(drawResultView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawResultView.movieTitle.text = movieTitle
        if nftLevel == "NORMAL" {
            drawResultView.nftLevel.textColor = UIColor(red: 95/255, green: 159/255, blue: 255/255, alpha: 1)
            drawResultView.borderView.layer.borderColor = UIColor(red: 95/255, green: 159/255, blue: 255/255, alpha: 1).cgColor
        }
        if nftLevel == "RARE" {
            drawResultView.nftLevel.textColor = .green
            drawResultView.borderView.layer.borderColor = UIColor.green.cgColor
        }
        if nftLevel == "LEGEND" {
            drawResultView.nftLevel.textColor = .red
            drawResultView.borderView.layer.borderColor = UIColor.red.cgColor
        }
        drawResultView.nftLevel.text = nftLevel
        if let url = URL(string: nftImage) {
            drawResultView.nftImage.configureImage(url: url)
        }
    }
}

extension DrawResultViewController {
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
