//
//  NewOrderHistoryTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 23/08/23.
//

import UIKit

class NewOrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLbl: UILabel!

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
