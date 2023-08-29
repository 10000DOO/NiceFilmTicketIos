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
          let authenticationVC = AuthenticationViewController()
          let navigationController = UINavigationController(rootViewController:authenticationVC)
          self.view.window?.rootViewController=navigationController
          self.view.window?.makeKeyAndVisible()
      }
   }
}
