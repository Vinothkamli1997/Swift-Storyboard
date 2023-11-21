//
//  TImeSlotCollectionViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class TImeSlotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLbl: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
        bgView.layer.borderColor = UIColor.gray.cgColor
        bgView.layer.masksToBounds = true
        
        textLbl.font = UIFont.systemFont(ofSize: 12)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
