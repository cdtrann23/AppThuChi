import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = .systemOrange
        self.tabBar.barTintColor = .gray
        self.tabBar.backgroundColor = .green
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Thu chi", image: UIImage(named: "walletclick"), selectedImage: UIImage(named: "wallet"))
        
        
        let planningVC = PlanningViewController()
        planningVC.tabBarItem = UITabBarItem(title: "Báo cáo", image: UIImage(named: "statisticsclick"), selectedImage: UIImage(named: "statistics"))

        let reportVC = ReportViewController()
        reportVC.tabBarItem = UITabBarItem(title: "Vay nợ", image: UIImage(named: "debit-card_click"), selectedImage: UIImage(named: "debit-card"))
        
        let accountVC = AccountViewController()
        accountVC.tabBarItem = UITabBarItem(title: "Tài khoản", image: UIImage(named: "user_acc_click"), selectedImage: UIImage(named: "user_acc"))
        
        let add = UIViewController()
        add.tabBarItem = UITabBarItem(title: "Thêm", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        self.viewControllers = [homeVC, reportVC, add, planningVC,accountVC]
        
        view.addSubview(button)
        
        let margins = view.layoutMarginsGuide
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15).isActive = true

        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        
//
//        let button = UIButton(configuration: .filled(), primaryAction: .init(handler: { _ in
//            let storyboard = UIStoryboard(name: "BottomSheet", bundle: nil)
//            let a = storyboard.instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
//
//            self.present(a, animated: true, completion: nil)
//        }))
//
//
//        button.setTitle("Thêm", for: .normal)
//        button.configuration?.cornerStyle = .capsule
//
//
//
//        view.addSubview(button)
//
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 50).isActive = true


    }
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

        
        button.setTitleColor(.white, for: .normal)
        //button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 50
        button.setBackgroundImage(UIImage(named: "addButton"), for: .normal)


        return button
    }()
    
    @objc private func didTapButton() {

        let BottomSheetVC = BottomSheetViewController()

        BottomSheetVC.modalTransitionStyle = .coverVertical
        present(BottomSheetVC, animated: true, completion: nil)
    }

}
