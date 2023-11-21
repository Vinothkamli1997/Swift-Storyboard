//
//  NewCartDishListDetailsTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 08/11/23.
//

import UIKit

class NewCartDishListDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet var vegorNonvegImg: UIImageView!
    
    @IBOutlet var cakeNameLbl: UILabel!
    
    @IBOutlet var addOnCount: UILabel!

    @IBOutlet var showLbl: UILabel!
    
    @IBOutlet var cakeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cakeNameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        showLbl.text = "Show"
        showLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        showLbl.font = UIFont.systemFont(ofSize: 12)
        
        addOnCount.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        addOnCount.font = UIFont.systemFont(ofSize: 12)
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
