//
//  AnniversaryTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 13/06/23.
//

import UIKit

class AnniversaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headingLbl: UILabel!

    @IBOutlet weak var anniversaryCollectionView: UICollectionView!
    
    var context: UIViewController!
    var birthdayList: [Anniversary] = []
    var anniversaryList: [Anniversary] = []
    
    var eventType: String = ""
    var alertTag: Int = 0
    weak var delegate: AnniversaryCollectionCollectionViewCellDelegate?
    
    var anniversaryImages = ["Parents", "Grandparents", "MaternalGrandParents"]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        anniversaryCollectionView.register(AnniversaryCollectionViewCell.nib, forCellWithReuseIdentifier: "AnniversaryCollectionViewCell")
        anniversaryCollectionView.dataSource = self
        anniversaryCollectionView.delegate = self
        
        headingLbl.font = UIFont.boldSystemFont(ofSize: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize)
        return CGSize(width: targetSize.width, height: size.height)
    }
    
    override var intrinsicContentSize: CGSize {
        return anniversaryCollectionView.contentSize
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}


extension AnniversaryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return anniversaryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnniversaryCollectionViewCell", for: indexPath) as? AnniversaryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self.delegate
        cell.alertTag = indexPath.row
        
        cell.bottomLbl.text = anniversaryList[indexPath.row].relationName
        
        if indexPath.row < anniversaryImages.count {
            let imageName = anniversaryImages[indexPath.row]
            if let image = UIImage(named: imageName) {
                cell.imageView.image = image
                cell.imageView.contentMode = .scaleAspectFill
                cell.imageView.clipsToBounds = true
            } else {
                cell.imageView.image = UIImage(named: "no_image")
            }
        }

        if anniversaryList[indexPath.row].isCreated != 0 {
            cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.checkBtn.tintColor = UIColor(hexFromString: ColorConstant.GREEN)
        } else {
            cell.checkBtn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            cell.checkBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 120, height: 110)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let numberOfColumns: CGFloat = 3
        let spacingBetweenItems: CGFloat = 10
        let totalSpacing = (numberOfColumns - 1) * spacingBetweenItems
        let itemWidth = (collectionViewWidth - totalSpacing) / numberOfColumns
        
        return CGSize(width: itemWidth, height: 110)
    }
}

