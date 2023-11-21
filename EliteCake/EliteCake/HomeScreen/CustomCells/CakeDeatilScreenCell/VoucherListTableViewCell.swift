//
//  VoucherListTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 29/09/23.
//

import UIKit

class VoucherListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var voucherListTableView: UITableView!

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
