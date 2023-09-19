//
//  SplashViewController.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/10.
//

import UIKit
import SnapKit


class SplashViewController : UIViewController {
    
    override func loadView() {
        view = SplashView()
    }
    
    override func viewDidAppear(_ animated : Bool ) {
        super.viewDidAppear(animated)
        
        guard let splashView = view as? SplashView else { return }
        
        UIView.animate(withDuration: 1, animations: {
            splashView.safeAreaView.layer.opacity = 0
            self.view.layoutIfNeeded()
        }) { _ in
            splashView.safeAreaView.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 1.3, animations: {
            splashView.centerYConstraint?.deactivate()
            splashView.imageView.snp.makeConstraints { make in
                splashView.centerYConstraint = make.centerY.equalTo(splashView.snp.top).offset(170).constraint
            }
            self.view.layoutIfNeeded()
            
        }) { _ in
            if UserDefaults.standard.string(forKey: "accessToken") != nil {
                if UserDefaults.standard.string(forKey: "memberType") == "PUBLISHER" {
                    let PublisherTabbarVC = PublisherTapbarViewController()
                    
                    PublisherTabbarVC.modalPresentationStyle = .fullScreen
                    self.present(PublisherTabbarVC, animated: true, completion: nil)
                }
            } else {
                let rootVC = SignInViewController(signInViewModel: SignInViewModel(signInService: SignInService(signInRepository: SignInRepository())))
                let navigationController = UINavigationController(rootViewController:rootVC)
                
                self.navigationController?.pushViewController(rootVC, animated: false)
                
                self.view.window?.rootViewController = navigationController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
