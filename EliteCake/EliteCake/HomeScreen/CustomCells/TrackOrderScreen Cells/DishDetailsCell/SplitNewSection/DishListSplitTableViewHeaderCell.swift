//
//  DishListSplitTableViewHeaderCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 06/11/23.
//

import UIKit

class DishListSplitTableViewHeaderCell: UITableViewCell {
        
    @IBOutlet weak var vegNonVegTypeImage: UIImageView!
    @IBOutlet weak var dishname: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishQuantity: UILabel!
    @IBOutlet weak var dishTotalPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
