//
//  FlavourCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 19/01/23.
//

import UIKit

class FlavourCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cakeImg: UIImageView!
    @IBOutlet weak var cakeNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setShadow(view: bgView)
        cakeNameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        cakeNameLbl.textColor = UIColor(named: "TextDarkMode")
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
