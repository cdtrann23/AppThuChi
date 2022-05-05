import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var datenumberLabel: UILabel!
    @IBOutlet weak var sumOfDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

       
    }

    
    func settext(){
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
