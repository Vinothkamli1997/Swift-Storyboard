//
//  MenuDishCollectionViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 09/03/23.
//

import UIKit

class MenuDishCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filterNameLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        filterNameLbl.textColor = UIColor.gray
        filterNameLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
        bgView.layer.borderColor = UIColor.gray.cgColor
        bgView.layer.masksToBounds = true

    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
