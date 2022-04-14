import UIKit

class ChiTieuViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Second VC will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Second VC will disappear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
}
