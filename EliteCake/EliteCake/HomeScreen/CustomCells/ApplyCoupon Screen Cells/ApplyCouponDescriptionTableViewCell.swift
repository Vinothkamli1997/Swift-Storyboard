//
//  ApplyCouponDescriptionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 17/05/23.
//

import UIKit

class ApplyCouponDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var descriptionLbl: UILabel!

    @IBOutlet weak var bottomView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
