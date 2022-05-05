import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var registerOL: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerOL.layer.cornerRadius = 8
        emailTF.layer.cornerRadius = 8
        fullNameTF.layer.cornerRadius = 8
        userNameTF.layer.cornerRadius = 8
        passwordTF.layer.cornerRadius = 8
    }

    @IBAction func registerButton(_ sender: Any) {
        guard let mail = emailTF.text, let password = passwordTF.text else {
            return
        }
        
        FirebaseAuthManager.shared.register(mail: mail, matKhau: password) { [weak self] status, data in
            guard let strongSelf = self else { return }
            if status {
                UserDefaults.standard.setValue(true, forKey: "login")
                UserDefaults.standard.setValue(data ?? "", forKey: "uid")
                // register success
                let homeVC = TabBarViewController()
                let navigation = UINavigationController(rootViewController: homeVC)
                navigation.modalPresentationStyle = .fullScreen
                strongSelf.present(navigation, animated: true, completion: nil)
            } else {
                UserDefaults.standard.setValue(false, forKey: "login")
                // register failed
                if let messageError = data {
                    AlertHelper.showAlert(message: messageError, viewController: strongSelf)
                } else {
                    AlertHelper.showAlert(message: "Đã xảy ra lỗi", viewController: strongSelf)
                }
            }
        }
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
