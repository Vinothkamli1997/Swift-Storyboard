//
//  SelectTimeSlotTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 17/03/23.
//

import UIKit

protocol soltTimeDelegate: AnyObject {
    func selectTime(selectSlot: String)
}

class SelectTimeSlotTableViewCell: UITableViewCell {

    @IBOutlet weak var timeSlotCollectionView: UICollectionView!
    @IBOutlet weak var selectTimeSlotLbl: UILabel!
    
    var timeSlot: [OutletSlot] = []
    var filteredSlot: [Int] = []
    var selectedIndexPath: IndexPath?
    
    
    var delSlotTime: String = ""
    weak var delegate: soltTimeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        timeSlotCollectionView.register(TImeSlotCollectionViewCell.nib, forCellWithReuseIdentifier: "TImeSlotCollectionViewCell")
        timeSlotCollectionView.dataSource = self
        timeSlotCollectionView.delegate = self
        timeSlotCollectionView.showsHorizontalScrollIndicator = false
        timeSlotCollectionView.backgroundColor = UIColor(named: "PureWhite")
        
        selectTimeSlotLbl.text = "Select Delivery Time Slot"
        selectTimeSlotLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        selectedIndexPath = IndexPath(item: 0, section: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension SelectTimeSlotTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeSlot.count
//        return filteredSlot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TImeSlotCollectionViewCell", for: indexPath) as? TImeSlotCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bgView.isUserInteractionEnabled = true
        
        cell.textLbl.text = timeSlot[indexPath.row].deliverySlotName
        
        //        if indexPath == selectedIndexPath {
        //
        //            delegate?.selectTime(selectSlot: timeSlot[indexPath.row].deliverySlotID!)
        //
        //            cell.textLbl.textColor = UIColor.white
        //            cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        //            cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        //        } else {
        //            cell.textLbl.textColor = UIColor.gray
        //            cell.bgView.backgroundColor = UIColor.white
        //            cell.bgView.layer.borderColor = UIColor.gray.cgColor
        //        }
        
        if let slotID = UserDefaults.standard.string(forKey: "SlotID") {
            
            if slotID == timeSlot[indexPath.row].deliverySlotID {
                cell.textLbl.textColor = UIColor.white
                cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
                
            } else {
                cell.textLbl.textColor =  UIColor.gray
                cell.bgView.backgroundColor = UIColor.white
                cell.bgView.layer.borderColor = UIColor.gray.cgColor
            }
        } else if indexPath.row == 0 {
            // This is the 0th index
            
            print("Select by default")
            
            NotificationCenter.default.post(name: .selectSlotID, object: nil, userInfo: ["deliverySlotID": timeSlot[0].deliverySlotID!])
        }
//        else {
//            indexPath
//            cell.textLbl.textColor = UIColor.white
//            cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
//            cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: .selectSlotID, object: nil, userInfo: ["deliverySlotID": timeSlot[indexPath.row].deliverySlotID!])
        
//        // Deselect the previously selected item if a new one is selected
//        if let previousIndexPath = selectedIndexPath {
//            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? TImeSlotCollectionViewCell {
//                previousCell.textLbl.textColor =  UIColor.gray
//                previousCell.bgView.backgroundColor = UIColor.white
//                previousCell.bgView.layer.borderColor = UIColor.gray.cgColor
//            }
//        }
//
//        // Update the selected index path and style the new cell
//        selectedIndexPath = indexPath
//        if let cell = collectionView.cellForItem(at: indexPath) as? TImeSlotCollectionViewCell {
//            cell.textLbl.textColor = UIColor.white
//            cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
//            cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
//        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width)/3 , height: 50)
    }
}
