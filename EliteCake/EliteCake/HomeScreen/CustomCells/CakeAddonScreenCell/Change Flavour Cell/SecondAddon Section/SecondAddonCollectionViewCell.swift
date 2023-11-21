//
//  SecondAddonCollectionViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 06/10/23.
//

import UIKit

class SecondAddonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var flavourImage: UIImageView!
    @IBOutlet weak var flavourName: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var flavourSelectBtn: UIButton!
    
    var flavourValue: Bool = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLightShadow(view: bgView)
        bgView.cornerRadius = 20
        bgView.backgroundColor = UIColor(named: "ViewDarkMode")
        
        flavourName.font = UIFont.boldSystemFont(ofSize: 14)
        priceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        flavourSelectBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        flavourSelectBtn.tintColor = UIColor.gray
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
