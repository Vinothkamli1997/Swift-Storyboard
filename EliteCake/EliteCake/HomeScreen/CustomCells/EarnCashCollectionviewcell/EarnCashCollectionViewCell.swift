//
//  EarnCashCollectionViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 28/07/23.
//

import UIKit

class EarnCashCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var onAddingLbl: UILabel!
    
    @IBOutlet weak var addMoreLbl: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var innerImage: UIImageView!
    
    @IBOutlet weak var claimLbl: UILabel!
    
    @IBOutlet weak var claimBtnView: UIView!
        
    @IBOutlet weak var claimBtnLabel: UIView!

    @IBOutlet weak var claimBtnImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLbl.font = UIFont.boldSystemFont(ofSize: 18)
        priceLbl.textColor = UIColor.white
        
        claimLbl.textColor = UIColor.white
        claimLbl.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
