import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    var imageView: UIImageView!
    var centerYConstraint: Constraint?
    var safeAreaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 이미지 뷰 생성
        imageView = UIImageView(image: UIImage(named: "SplashImage"))
        view.addSubview(imageView)
        
        // 이미지 뷰의 제약 조건 설정
        imageView.snp.makeConstraints { make in
            centerYConstraint = make.centerY.equalTo(view.snp.centerY).constraint
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(350)
            make.height.equalTo(450)
        }
        
        // safeArea의 테두리를 설정
        safeAreaView = UIView()
        safeAreaView.backgroundColor = .clear
        safeAreaView.layer.borderWidth = 8
        safeAreaView.layer.cornerRadius = 10
        safeAreaView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        view.addSubview(safeAreaView)
        
        safeAreaView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            // 테두리의 투명도를 0으로 설정하여 흐려져서 사라지도록 함
            self.safeAreaView.layer.opacity = 0
            
            self.view.layoutIfNeeded()
        }) { _ in
            // 애니메이션 완료 후 safeAreaView 제거
            self.safeAreaView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.3, animations: {
            //로고 올라가는 애니메이션
            self.centerYConstraint?.deactivate()
            self.imageView.snp.makeConstraints { make in
                self.centerYConstraint = make.centerY.equalTo(self.view.snp.top).offset(200).constraint
            }
            self.view.layoutIfNeeded()
        }) { _ in
            //AuthenticationViewController를 루트뷰로 설정해서 navigationController 적용
            let authenticationVC = AuthenticationViewController()
            let navigationController = UINavigationController(rootViewController: authenticationVC)
            self.view.window?.rootViewController = navigationController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
