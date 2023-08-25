import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    var imageView: UIImageView!
    var centerYConstraint: Constraint?
    var safeAreaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 뷰 생성
        imageView = UIImageView(image: UIImage(named: "SplashImage"))
        view.addSubview(imageView)
        
        // 이미지 뷰의 제약 조건 설정
        imageView.snp.makeConstraints { make in
            centerYConstraint = make.centerY.equalTo(self.view.snp.centerY).constraint
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(270)
            make.height.equalTo(180)
        }
        
        // safeArea의 테두리를 설정
        safeAreaView = UIView()
        safeAreaView.backgroundColor = .clear
        safeAreaView.layer.borderWidth = 8
        safeAreaView.layer.cornerRadius = 10
        safeAreaView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        view.addSubview(safeAreaView)
        
        safeAreaView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 렌더링 피직셀 정렬 옵션 사용
        view.layer.allowsEdgeAntialiasing = true
        
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
                self.centerYConstraint = make.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(120).constraint
            }
            self.view.layoutIfNeeded()
        }) { _ in
            let authenticationVC = AuthenticationViewController()
            authenticationVC.modalPresentationStyle = .fullScreen
            // 현재 뷰 컨트롤러를 AuthenticationViewController로 전환
            self.present(authenticationVC, animated: false, completion: nil)
        }
    }
}
