//
//  OrderHistoryHeaderCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 06/11/23.
//

import UIKit

class OrderHistoryHeaderCell: UITableViewHeaderFooterView {
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet var vegorNonvegImg: UIImageView!
    
    @IBOutlet var cakeNameLbl: UILabel!
    
    @IBOutlet var cakePriceLbl: UILabel!

    @IBOutlet var cakeQuantityLbl: UILabel!
    
    @IBOutlet var cakeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cakeNameLbl.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
