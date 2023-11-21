//
//  FilterTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/03/23.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterNameLbl: UILabel!
    @IBOutlet weak var filterCountLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filterCountLbl.isHidden = true
        filterNameLbl.textColor = UIColor.black
        filterNameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        filterCountLbl.font = UIFont.boldSystemFont(ofSize: 16)
        filterCountLbl.textColor = UIColor.black
        
        bgView.backgroundColor = UIColor(named: "LightGray")
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
