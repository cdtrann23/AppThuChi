import UIKit

class ChiTieuViewController: UIViewController {

    @IBOutlet weak var danhMucCollectionView: UICollectionView!
    
    let data = ["Ăn uống", "Điện", "Nước", "Nhà", "Đi lại", "Khác"]
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

    }
}

extension ChiTieuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
    
    
}
