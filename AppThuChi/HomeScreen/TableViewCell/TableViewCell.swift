import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var CellImgDanhMuc: UIImageView!
    @IBOutlet weak var tenDanhMuc: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var money: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        money.textColor = UIColor(named: "TabbarIconColor")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
