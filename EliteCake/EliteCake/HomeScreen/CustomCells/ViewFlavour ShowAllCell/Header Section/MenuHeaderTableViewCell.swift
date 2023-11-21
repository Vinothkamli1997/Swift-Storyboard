//
//  MenuHeaderTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 09/03/23.
//

import UIKit

class MenuHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var menuHeaderCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        menuHeaderCollectionView.register(MenuDishCollectionViewCell.nib, forCellWithReuseIdentifier: "MenuDishCollectionViewCell")
        menuHeaderCollectionView.dataSource = self
        menuHeaderCollectionView.delegate = self
        
        selectedIndexPath = IndexPath(item: 0, section: 0)
        menuHeaderCollectionView.reloadData()
    }
    
    var selectedIndexPath: IndexPath?

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

extension MenuHeaderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuDishCollectionViewCell", for: indexPath) as? MenuDishCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath == selectedIndexPath {
            cell.filterNameLbl.textColor = UIColor.white
            cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        } else {
            cell.filterNameLbl.textColor = UIColor.gray
            cell.bgView.backgroundColor = UIColor.white
            cell.bgView.layer.borderColor = UIColor.gray.cgColor
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            // If selected cell is already selected, do nothing
            return
        }
        
        // Deselect the previously selected item if a new one is selected
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? MenuDishCollectionViewCell {
                previousCell.filterNameLbl.textColor =  UIColor.gray
                previousCell.bgView.backgroundColor = UIColor.white
                previousCell.bgView.layer.borderColor = UIColor.gray.cgColor
            }
        }
        
        // Update the selected index path and style the new cell
        selectedIndexPath = indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuDishCollectionViewCell {
            cell.filterNameLbl.textColor = UIColor.white
            cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: 50)
    }
    
}
