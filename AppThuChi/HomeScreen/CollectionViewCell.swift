import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moneyLabel: UILabel!
    var money: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        var money = Int(moneyLabel.text ?? "") ?? 0
            //print(money)
        if money >= 0 {
            moneyLabel.textColor = UIColor.black
        } else {
            moneyLabel.textColor = UIColor.red
        }
    }

    
}
