import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var CellImgDanhMuc: UIImageView!
    @IBOutlet weak var tenDanhMuc: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var money: UILabel!
    
    var data : ChiTieu? {
        didSet {
            if let data = data {
                tenDanhMuc.text = data.danhMuc
                note.text = data.note
                money.text = String(data.money)
                
                money.textColor = data.money < 0 ? UIColor.red : UIColor.systemCyan
                CellImgDanhMuc.image = UIImage(named: getImgCategoryName(data.danhMuc))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        money.textColor = UIColor(named: "TabbarIconColor")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
