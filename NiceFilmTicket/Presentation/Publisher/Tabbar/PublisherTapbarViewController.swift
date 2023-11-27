//
//  PublisherTapbarViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/12.
//

import UIKit

class PublisherTapbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publisherMainVC = PublisherMainViewController(publisherMainViewModel: PublisherMainViewModel(nftService: NFTService(nftRepository: NFTRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        let myPageVC = MyPageViewController(myPageViewModel: MyPageViewModel(nftService: NFTService(nftRepository: NFTRepository()), refreshTokenService: RefreshTokenService(refreshTokenRepository: RefreshTokenRepository())))
        
        self.viewControllers = [UINavigationController(rootViewController: publisherMainVC), myPageVC]
        
        UITabBar.appearance().backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        if let items = self.tabBar.items {
            if let houseFillImage = UIImage(systemName: "house.fill") {
                let blueHouseFillImage = houseFillImage.withTintColor(UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)).withRenderingMode(.alwaysOriginal)
                items[0].selectedImage = blueHouseFillImage
                items[0].image = UIImage(systemName: "house.fill")
            }
            
            if let myPageFillImage = UIImage(systemName: "person.fill") {
                let blueMyPageFillImage = myPageFillImage.withTintColor(UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)).withRenderingMode(.alwaysOriginal)
                items[1].selectedImage = blueMyPageFillImage
                items[1].image = UIImage(systemName: "person.fill")
            }
        }
    }
}
