import UIKit
import FirebaseFirestore
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    let header = HeaderTableViewCell()
    @IBOutlet weak var thuNhapLable: UILabel!
    @IBOutlet weak var chiTieuLable: UILabel!
    @IBOutlet weak var soDuLable: UILabel!
    var sumThuNhap: Float = 0
    var sumChiTieu: Float = 0

    
    let database = FirebaseFirestore.Firestore.firestore()
    var arrChitieu: [[ChiTieu]] = []
    var arrThunhap: [[ThuNhap]] = []
    var allData = [ChiTieu]()
    var arrDate = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "Header")
        historyTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        historyTableView.sectionHeaderTopPadding = 16
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getAllData()
        
        
    }
    
    func getAllData(){
        arrChitieu.removeAll()
        allData.removeAll()
        arrDate.removeAll()
        arrThunhap.removeAll()
        
        var isGetThu = false
        var isGetChi = false
        
        database.collection("ChiTieu").getDocuments { [weak self] querySnapshot, error in
            guard let strongSelf = self else {return}
            if let err = error {
                print("error:", err)
                isGetChi = true
            } else {
                for document in querySnapshot!.documents {
                    guard let money = document.data()["money"] as? Float,
                          let id = document.data()["id"] as? String,
                          let danhMuc = document.data()["danhMuc"] as? String,
                          let note = document.data()["note"] as? String,
                          let date = document.data()["date"] as? String,
                          let creatorId = document.data()["creatorId"] as? String
                    else {
                        return
                    }
                    
                    let ChiTieu = ChiTieu(id: UUID().uuidString,
                                          money: money,
                                          danhMuc: danhMuc,
                                          note: note,
                                          date: date,
                                          creatorId: creatorId)
                    
                    strongSelf.allData.append(ChiTieu)
                }
                isGetChi = true
            }
            if isGetThu && isGetChi {
                strongSelf.getDate()
            }
        }
        
        database.collection("ThuNhap").getDocuments { [weak self] querySnapshot, error in
            guard let strongSelf = self else {return}
            if let err = error {
                print("error:", err)
                isGetThu = true
            } else {
                for document in querySnapshot!.documents {
                    guard let money = document.data()["money"] as? Float,
                          let id = document.data()["id"] as? String,
                          let danhMuc = document.data()["danhMuc"] as? String,
                          let note = document.data()["note"] as? String,
                          let date = document.data()["date"] as? String,
                          let creatorId = document.data()["creatorId"] as? String
                    else {
                        return
                    }
                    
                    let ChiTieu = ChiTieu(id: UUID().uuidString,
                                          money: money,
                                          danhMuc: danhMuc,
                                          note: note,
                                          date: date,
                                          creatorId: creatorId)
                    
                    strongSelf.allData.append(ChiTieu)
                    //print("________\(ChiTieu)")
                }
                isGetThu = true
            }
            
            if isGetThu && isGetChi {
                strongSelf.getDate()
            }
        }
        
    }
    func getDate(){
        for item in allData {
            //            if arrDate.contains(where: { $0 = item.date }) {}
            if !arrDate.contains(where: { date in
                item.date == date
            }){
                arrDate.append(item.date)
                
            }
        }
        
        for date in arrDate {
            var arrItemInDate = [ChiTieu]()
            for i in allData {
                if i.date == date {
                    arrItemInDate.append(i)
                }
            }
            arrChitieu.append(arrItemInDate)
        }
        historyTableView.reloadData()
    }
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrChitieu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChitieu[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        //arrChitieu[indexPath.section][indexPath.row]
        
        
        cell.tenDanhMuc.text = arrChitieu[indexPath.section][indexPath.row].danhMuc
        cell.note.text = arrChitieu[indexPath.section][indexPath.row].note
        cell.money.text = String(arrChitieu[indexPath.section][indexPath.row].money)
        if arrChitieu[indexPath.section][indexPath.row].money < 0 {
            cell.money.text = String(arrChitieu[indexPath.section][indexPath.row].money)
            sumChiTieu += arrChitieu[indexPath.section][indexPath.row].money
            cell.money.textColor = .red
        }
        //            else {
        //            sumThuNhap += arrChitieu[indexPath.section][indexPath.row].money
        //
        //        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var Tong: Float = 0
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "Header") as! HeaderTableViewCell
        headerCell.frame.size.width = tableView.frame.size.width
        headerCell.monthLabel.textColor = .red
        
        let fulldate = arrDate[section]
        let fulldateArr = fulldate.components(separatedBy: ",")
        headerCell.dateTextLabel.text = fulldateArr[0]
        headerCell.monthLabel.text = fulldateArr[1]
        let date = fulldateArr[1]
        let datearr = date.components(separatedBy: " ")
        headerCell.datenumberLabel.text = datearr[1]
        headerCell.monthLabel.text = "Tháng \(datearr[3]) năm \(datearr[4])"
        
        //headerCell.monthLabel.text = arrDate[section]
        headerCell.sumOfDay.text = String(Tong)
        //thuNhapLable.text = String(sumThuNhap)
        headerView.addSubview(headerCell)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
    
    
}
