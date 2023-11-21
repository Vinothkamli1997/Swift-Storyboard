//
//  CartMultiAddOnTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 07/11/23.
//

import UIKit

class CartMultiAddOnTableViewCell: UITableViewCell {

    @IBOutlet weak var cakeNameLbl: UILabel!
    @IBOutlet weak var cakePriceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cakeNameLbl.font = UIFont.systemFont(ofSize: 12)
        cakeNameLbl.textColor = UIColor.gray
        
        cakePriceLbl.font = UIFont.systemFont(ofSize: 12)
        cakePriceLbl.textColor = UIColor.gray
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
