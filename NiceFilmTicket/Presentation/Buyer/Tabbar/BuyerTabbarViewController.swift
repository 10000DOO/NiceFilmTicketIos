//
//  BuyerTabbarViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/08.
//

import UIKit

class BuyerTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let buyerMainVC = BuyerMainViewController(buyerMainViewModel: BuyerMainViewModel(movieListService: MovieListService(movieListRepository: MovieListRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository()), searchMovieService: SearchMovieService(searchMovieRepository: SearchMovieRepository())))
        let drawNftVC = DrawNftViewController(drawNftViewModel: DrawNftViewModel(drawNftService: DrawNftService(drawNftRepository: DrawNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        let myPageVC = MyPageViewController(myPageViewModel: MyPageViewModel(myNftService: MyNftService(myNftRepository: MyNftRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        
        self.viewControllers = [UINavigationController(rootViewController: buyerMainVC), drawNftVC, myPageVC]
        
        UITabBar.appearance().backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        if let items = self.tabBar.items {
            if let houseFillImage = UIImage(systemName: "house.fill") {
                let blueHouseFillImage = houseFillImage.withTintColor(UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)).withRenderingMode(.alwaysOriginal)
                items[0].selectedImage = blueHouseFillImage
                items[0].image = UIImage(systemName: "house.fill")
            }
            
            if let myPageFillImage = UIImage(systemName: "arrow.2.squarepath") {
                let blueMyPageFillImage = myPageFillImage.withTintColor(UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)).withRenderingMode(.alwaysOriginal)
                items[1].selectedImage = blueMyPageFillImage
                items[1].image = UIImage(systemName: "arrow.2.squarepath")
            }
            
            if let myPageFillImage = UIImage(systemName: "person.fill") {
                let blueMyPageFillImage = myPageFillImage.withTintColor(UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)).withRenderingMode(.alwaysOriginal)
                items[2].selectedImage = blueMyPageFillImage
                items[2].image = UIImage(systemName: "person.fill")
            }
        }
    }
}
