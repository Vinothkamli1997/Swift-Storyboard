//
//  FilterListTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/03/23.
//

import UIKit

class FilterListTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var filterListLbl: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filterListLbl.font = UIFont.boldSystemFont(ofSize: 14)
        filterListLbl.textColor = UIColor.black
        
        checkBoxBtn.setImage(UIImage(systemName: "squareshape"), for: .normal)
        checkBoxBtn.tintColor = UIColor.black
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
