//
//  FirstSectionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 08/06/23.
//

import UIKit

protocol FirstSectionTableViewCellDelegate: AnyObject {
    func didSelectRelation(relationID: String)
}

class FirstSectionTableViewCell: UITableViewCell, FirstSectionCollectionCollectionViewCellDelegate {
    
    func eventImageTapped(_ alert: FirstSectionCollectionCollectionViewCell, alertTag: Int) {
        selectedIndex = alertTag
        firstSectionCollectionView.reloadData()
    }
    
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var firstSectionCollectionView: UICollectionView!
    
//    let siblingImages = ["Father", "Mother", "Son", "Daughter", "GrandMother", "GrandFather", "Sibling1", "Sibling2"]
    var birthdayImages = ["Father", "Mother", "Son", "Daughter", "Grandmother", "GrandFather", "Sibling1", "Sibling2", "Friends&Family"]
    
    var context: UIViewController!
    var birthdayList: [Anniversary] = []
    var anniversaryList: [Anniversary] = []
    
    var eventType: String = ""
    var alertTag: Int = 0
    var selectedIndex: Int = -1
    var imagePath: String?

    
    weak var delegate: FirstSectionCollectionCollectionViewCellDelegate?
    weak var selectedRelationdelegate: FirstSectionTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstSectionCollectionView.register(FirstSectionCollectionCollectionViewCell.nib, forCellWithReuseIdentifier: "FirstSectionCollectionCollectionViewCell")
        firstSectionCollectionView.dataSource = self
        firstSectionCollectionView.delegate = self
        
        headingLbl.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize)
        return CGSize(width: targetSize.width, height: size.height)
    }
    
    override var intrinsicContentSize: CGSize {
        return firstSectionCollectionView.contentSize
    }
    
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}


extension FirstSectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return birthdayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstSectionCollectionCollectionViewCell", for: indexPath) as? FirstSectionCollectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self.delegate
        cell.alertTag = indexPath.row
        
        cell.bottomLbl.text = birthdayList[indexPath.row].relationName

        if birthdayList[indexPath.row].imagePath != "" {
            print("Addevent if ")
            if let imageUrl = URL(string: birthdayList[indexPath.row].imagePath) {
                
                // Load the image from the URL
                cell.imageView.sd_setImage(with: imageUrl)
                cell.imageView.contentMode = .scaleAspectFill
                cell.imageView.clipsToBounds = true
            }
        } else if indexPath.row < birthdayImages.count {
            print("Addevent Else if ")
            let imageName = birthdayImages[indexPath.row]
            if let image = UIImage(named: imageName) {
                cell.imageView.image = image
                cell.imageView.contentMode = .scaleAspectFill
                cell.imageView.clipsToBounds = true
            } else {
                print("Addevent Else")
                cell.imageView.image = UIImage(named: "no_image")
            }
        }

        
        if birthdayList[indexPath.row].isCreated != 0 {
            cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.checkBtn.tintColor = UIColor(hexFromString: ColorConstant.GREEN)
        } else {
            cell.checkBtn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            cell.checkBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 110)
    }
}
