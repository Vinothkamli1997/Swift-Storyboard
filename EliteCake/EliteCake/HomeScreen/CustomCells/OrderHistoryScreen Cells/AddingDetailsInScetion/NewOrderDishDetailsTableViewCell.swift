//
//  NewOrderDishDetailsTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 07/11/23.
//

import UIKit

class NewOrderDishDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet var vegorNonvegImg: UIImageView!
    
    @IBOutlet var cakeNameLbl: UILabel!
    
    @IBOutlet var cakePriceLbl: UILabel!

    @IBOutlet var cakeQuantityLbl: UILabel!
    
    @IBOutlet var cakeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
