import UIKit

class BottomSheetViewController: UIViewController {

    let inComeVC = InComeViewController()
    let spending = SpendViewController()
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(inComeVC)
        addChild(spending)
        
        self.view.addSubview(inComeVC.view)
        self.view.addSubview(spending.view)
        
        inComeVC.didMove(toParent: self)
        spending.didMove(toParent: self)
        
        inComeVC.view.frame = self.view.bounds
        spending.view.frame = self.view.bounds
        spending.view.isHidden = true
        
    }

    @IBAction func TouchSegment(_ sender: Any) {
        
        inComeVC.view.isHidden = true
        spending.view.isHidden = true


        if segment.selectedSegmentIndex == 0 {
            inComeVC.view.isHidden = true
        } else {
            spending.view.isHidden = true
        }
    }
    
}
