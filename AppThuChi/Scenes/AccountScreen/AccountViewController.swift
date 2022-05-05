import UIKit

protocol LogoutDelegate {
    func didLogout()
}

class AccountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = 50
        
    
    }

    @IBAction func logoutButton(_ sender: Any) {
        FirebaseAuthManager.shared.logout { [weak self] status in
            
            guard let strongSelf = self else { return }
            
            if status {
                let userDefault = UserDefaults.standard
                userDefault.removeObject(forKey: "login")
                userDefault.removeObject(forKey: "uid")
//                strongSelf.dismiss(animated: true, completion: nil)
                strongSelf.delegate?.didLogout()
            } else {
                let message = "Đăng xuất thất bại"
                AlertHelper.showAlert(message: message, viewController: strongSelf)
            }
        }
    }
    
    
}
