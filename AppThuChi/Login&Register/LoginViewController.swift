import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginTF: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTF.layer.cornerRadius = 8
        emailTF.layer.cornerRadius = 8
        passwordTF.layer.cornerRadius = 8
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTF.text = ""
        passwordTF.text = ""
    }

    @IBAction func loginButton(_ sender: Any) {
        guard let mail = emailTF.text, let password = passwordTF.text else {
            return
        }
        
        FirebaseAuthManager.shared.login(mail: mail, matKhau: password) { [weak self] status, data in
            guard let strongSelf = self else { return }
            if status {
                UserDefaults.standard.setValue(true, forKey: "login")
                UserDefaults.standard.setValue(data ?? "", forKey: "uid")
                // login success
                let homeVC = TabBarViewController()
                let navigation = UINavigationController(rootViewController: homeVC)
                navigation.modalPresentationStyle = .fullScreen
                strongSelf.present(navigation, animated: true, completion: nil)
            } else {
                UserDefaults.standard.setValue(false, forKey: "login")
                // login failed
                if let messageError = data {
                    AlertHelper.showAlert(message: messageError, viewController: strongSelf)
                } else {
                    AlertHelper.showAlert(message: "Đã xảy ra lỗi", viewController: strongSelf)
                }
            }
        }
    }

    @IBAction func goToRegister(_ sender: Any) {
        let registerVC = RegisterViewController()
        present(registerVC, animated: true, completion: nil)
    }
}
