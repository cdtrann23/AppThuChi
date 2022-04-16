import UIKit

class ThuNhapViewController: UIViewController {

    @IBOutlet weak var danhMucCollectionView: UICollectionView!
    @IBOutlet weak var DateTextField: UITextField!
    @IBOutlet weak var danhMucTextField: UITextField!
    
    let data = ["Lương", "Thưởng", "Trợ cấp", "Lì xì", "Đánh đề", "Khác"]
    let insetSection = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let itemPerRow: CGFloat = 3.0
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        danhMucCollectionView.delegate = self
        danhMucCollectionView.dataSource = self
        danhMucCollectionView.register(UINib(nibName: "ChiTieuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        createDatePicker()
    }
    
    func createDatePicker(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy"
        DateTextField.text = formatter.string(from: date)
        DateTextField.textColor = .black
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        datePicker.preferredDatePickerStyle = .wheels
        DateTextField.inputView = datePicker
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy"
        DateTextField.text = formatter.string(from: sender.date)
    }
    
}


extension ThuNhapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChiTieuCollectionViewCell

        cell.tenDanhMuc.text = data[indexPath.row]

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding = CGFloat(itemPerRow + 1) * 8
//        let availabelWith = view.frame.width - padding
        let a = view.frame.width - (40 + 16*3)
        let availabelWith = a - padding
        let size = availabelWith / itemPerRow
      
        return CGSize(width: size, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        insetSection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = data[indexPath.item]
        danhMucTextField.text = selectedData
        
        print(danhMucTextField.text)
    }
    
}
