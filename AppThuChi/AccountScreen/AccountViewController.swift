import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = 50
        
    
    }

    @IBAction func logoutButton(_ sender: Any) {
        FirebaseAuthManager.shared.logout { [weak self] status in
            
            guard let strongSelf = self else { return }
            
            if status {
//                let userDefault = UserDefaults.standard
//                userDefault.removeObject(forKey: "login")
//                userDefault.removeObject(forKey: "uid")
                strongSelf.dismiss(animated: true, completion: nil)
            } else {
                let message = "Đăng xuất thất bại"
                AlertHelper.showAlert(message: message, viewController: strongSelf)
            }
        }
    }
    
    
}
