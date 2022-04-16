import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    let database = FirebaseFirestore.Firestore.firestore()
    var arrChitieu: [[ChiTieu]] = []
    var allData = [ChiTieu]()
    var arrDate = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "Header")
        historyTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
                
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
                    print(ChiTieu)
                }
                isGetChi = true
//                print(strongSelf.allData.count)
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
                    print(ChiTieu)
                }
                isGetThu = true
//                print(strongSelf.allData.count)
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
        print(arrDate.count)
        print(arrDate)
        
        for date in arrDate {
            var arrItemInDate = [ChiTieu]()
            for i in allData {
                if i.date == date {
                    arrItemInDate.append(i)
                }
            }
            
            
            arrChitieu.append(arrItemInDate)
        }
        print(arrChitieu)
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
        //        arrChitieu[indexPath.section][indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "Header") as! HeaderTableViewCell
        
        headerView.addSubview(headerCell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
}
