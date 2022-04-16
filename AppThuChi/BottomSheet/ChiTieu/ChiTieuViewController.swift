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
        UIImage(named: "restaurant"),
        UIImage(named: "more"),
        UIImage(named: "restaurant"),
        UIImage(named: "more"),
        UIImage(named: "restaurant"),
        UIImage(named: "more"),
        UIImage(named: "restaurant")
    ]
    
    let insetSection = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let itemPerRow: CGFloat = 3.0
    
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
        
        danhMucCollectionView.delegate = self
        danhMucCollectionView.dataSource = self
        danhMucCollectionView.register(UINib(nibName: "ChiTieuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        createDatePicker()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let money = moneyTextField.text,
              let danhMuc = danhMucTextField.text,
              let note = noteTextField.text
        else {
            return
        }
        
        let chitieu = ChiTieu(id: UUID().uuidString,
                              money: Float(money) ?? 0.0,
                              danhMuc: danhMuc,
                              note: note,
                              date: "\(datePicker.date)",
                              creatorId: UserDefaults.standard.string(forKey: "uid") ?? "")
        let database = FirebaseFirestore.Firestore.firestore()
        database.collection("ChiTieu").addDocument(data: chitieu.dictionary)
    }
    
    
    func createDatePicker(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy"
        dateTextField.text = formatter.string(from: date)
        dateTextField.textColor = .black
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputView = datePicker
                

    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy"
        dateTextField.text = formatter.string(from: sender.date)
//        print(datePicker.date)
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
