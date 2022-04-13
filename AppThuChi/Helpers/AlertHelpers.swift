import UIKit

class AlertHelper {
    class func showAlert(message: String, viewController: UIViewController) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
