import UIKit

class InComeViewController: UIViewController {
    

    @IBOutlet weak var danhMucCollectionView: UICollectionView!
    let data = ["Lương", "Thưởng tết", "Lì xì", "Học bổng", "Khác","Thưởng tết", "Khác"]
    let insetSection = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let itemPerRow: CGFloat = 3.0


    @IBOutlet weak var dateTextField: UITextField!
    var commercialPopUp: Popup!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .systemCyan
        
        

        danhMucCollectionView.delegate = self
        danhMucCollectionView.dataSource = self
        danhMucCollectionView.register(UINib(nibName: "inComeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
    }
    
    @IBAction func PopUpTap(_ sender: Any) {
        self.commercialPopUp = Popup (frame:self.view.frame)
        self.commercialPopUp.backToView.addTarget (self, action: #selector (closeBtnTapped), for:
                                                     .touchUpInside)

        self.view.addSubview (commercialPopUp)
    }
    
    @objc func closeBtnTapped(){

        self.commercialPopUp.removeFromSuperview()
        
        dateTextField.text = commercialPopUp.formatDate(date: commercialPopUp.dateTimePicker.date)

    }
    
    
}

extension InComeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! inComeCollectionViewCell

        cell.tenDanhMuc.text = data[indexPath.row]

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding = CGFloat(itemPerRow + 1) * insetSection.left
//        let availabelWith = view.frame.width - padding
        let availabelWith = 278 - padding
        let size = availabelWith / itemPerRow
      
        return CGSize(width: size, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        insetSection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        insetSection.left
    }
}
