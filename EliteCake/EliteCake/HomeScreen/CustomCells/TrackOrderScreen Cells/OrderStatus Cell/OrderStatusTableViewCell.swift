//
//  OrderStatusTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/05/23.
//

import UIKit

class OrderStatusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderStatusCollectionView: UICollectionView!
    
    var trackOrderStatus: [OrderSummaryOrderStatus] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        orderStatusCollectionView.register(OrderStatusCollectionViewCell.nib, forCellWithReuseIdentifier: "OrderStatusCollectionViewCell")
        orderStatusCollectionView.dataSource = self
        orderStatusCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension OrderStatusTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackOrderStatus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderStatusCollectionViewCell", for: indexPath) as? OrderStatusCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Hide horizontalLeftView for the first index
        cell.horizontalLeftView.isHidden = indexPath.item == 0
        
        // Hide horizontalView for the last index
        cell.horizontalView.isHidden = indexPath.item == (collectionView.numberOfItems(inSection: 0) - 1)
        
        cell.orderStatusLbl.text = trackOrderStatus[indexPath.row].msg
        
        let statusIcon: [String] = ["0", "1", "2", "3", "4"]
      
        cell.statusIconBtn.setImage(UIImage(named: statusIcon[indexPath.row]), for: .normal)
        
        print("Track Order ststus details \(trackOrderStatus[indexPath.row].status)")
        
        if trackOrderStatus[indexPath.row].status == "" {
            cell.statusBgView.backgroundColor = UIColor.lightGray
        } else {
            cell.statusBgView.backgroundColor = UIColor(hexFromString: ColorConstant.GREEN)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 70)
    }
}
