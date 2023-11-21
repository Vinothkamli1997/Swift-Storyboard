//
//  PopularHeaderTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 06/03/23.
//

import UIKit

class PopularHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var popularLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        popularLbl.text = "Popular This Week"
        popularLbl.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Nib Register
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
