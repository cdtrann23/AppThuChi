import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor(named: "TabbarIconColor")
        //self.tabBar.barTintColor = .clear
        self.tabBar.backgroundColor = UIColor(named: "Ink800")
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Thu chi", image: UIImage(named: "thuchi"), selectedImage: UIImage(named: "thuchi"))
        
        
        let planningVC = PlanningViewController()
        planningVC.tabBarItem = UITabBarItem(title: "Vay nợ", image: UIImage(named: "give-money"), selectedImage: UIImage(named: "give-money"))
        
        let reportVC = ReportViewController()
        reportVC.tabBarItem = UITabBarItem(title: "Báo cáo", image: UIImage(named: "fluctuation"), selectedImage: UIImage(named: "fluctuation"))
        
        let accountVC = AccountViewController()
        accountVC.delegate = self
        accountVC.tabBarItem = UITabBarItem(title: "Tài khoản", image: UIImage(named: "account"), selectedImage: UIImage(named: "account"))
        
        let add = UIViewController()
        add.tabBarItem = UITabBarItem(title: "Thêm", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        self.viewControllers = [homeVC, reportVC, add, planningVC,accountVC]
        
        let button = UIButton(configuration: .filled(), primaryAction: .init(handler: { _ in
            let storyboard = UIStoryboard(name: "Bottom", bundle: nil)
            let a = storyboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
            
            
            self.present(a, animated: true, completion: nil)
            
            
        }))
        
        button.configuration?.cornerStyle = .capsule
        button.setImage(UIImage(named: "add-button"), for: .normal)
        
        view.addSubview(button)
        
        
        let margins = view.layoutMarginsGuide
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.widthAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
}

extension TabBarViewController: LogoutDelegate {
    func didLogout() {
        dismiss(animated: true, completion: nil)
    }
}
