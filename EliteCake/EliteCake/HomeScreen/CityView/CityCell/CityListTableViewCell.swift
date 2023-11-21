//
//  CityListTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 23/01/23.
//

import UIKit

class CityListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLbl: UILabel!
    
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
