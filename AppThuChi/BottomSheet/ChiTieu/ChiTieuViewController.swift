import UIKit
import FirebaseFirestore

class ChiTieuViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var danhMucTextField: UITextField!

    @IBOutlet weak var danhMucCollectionView: UICollectionView!
    @IBOutlet weak var anhDanhMuc: UIImageView!
    
    var datePicker = UIDatePicker()
    let data = ["Ăn uống", "Điện", "Nước", "Nhà", "Đi lại", "Khác"]
    let img = [
        UIImage(named: "eating"),
        UIImage(named: "electric"),
        UIImage(named: "water"),
        UIImage(named: "home"),
        UIImage(named: "gas"),
        UIImage(named: "more")
    ]
    
    let insetSection = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let itemPerRow: CGFloat = 3.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        danhMucCollectionView.delegate = self
        danhMucCollectionView.dataSource = self
        danhMucCollectionView.register(UINib(nibName: "ChiTieuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        createDatePicker()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let money = moneyTextField.text,
              let danhMuc = danhMucTextField.text,
              let note = noteTextField.text,
              let date = dateTextField.text
        else {
            return
        }
        
        let chitieu = ChiTieu(id: UUID().uuidString,
                              money: (Float(money) ?? 0.0) * -1,
                              danhMuc: danhMuc,
                              note: note,
                              date: date,
                              creatorId: UserDefaults.standard.string(forKey: "uid") ?? "")
        let database = FirebaseFirestore.Firestore.firestore()
        database.collection("ChiTieu").addDocument(data: chitieu.dictionary)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func createDatePicker(){
        
        //datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "vi_VN")
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputView = datePicker
        dateTextField.text = formatDate(date: Date())

    }
    
    
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        dateTextField.text = formatDate(date: datePicker.date)

    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.dateFormat = "EEEE, d MMM yyyy"
        return formatter.string(from: date)
    }
}

extension ChiTieuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChiTieuCollectionViewCell

        
        cell.tenDanhMuc.text = data[indexPath.row]
        cell.anhDanhMucCell.image = img[indexPath.row]
        

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding = CGFloat(itemPerRow + 1) * 8
//        let availabelWith = view.frame.width - padding
        let a = collectionView.frame.width
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = data[indexPath.item]
        danhMucTextField.text = selectedData
        anhDanhMuc.image = img[indexPath.row]
    }
}
