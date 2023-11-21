//
//  CakeDescriptionCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 07/02/23.
//

import UIKit

class CakeDescriptionCell: UITableViewCell {

    @IBOutlet weak var desccriptionLbl: UILabel!
    @IBOutlet weak var descTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.descTitleLbl.text = "Description"
        self.descTitleLbl.textColor = UIColor.black
//        self.descTitleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        self.descTitleLbl.font = UIFont(name: "AvenirNext-Bold", size: 20) // Change the size as needed
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
