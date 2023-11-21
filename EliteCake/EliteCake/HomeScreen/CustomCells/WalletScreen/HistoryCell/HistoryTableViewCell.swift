//
//  HistoryTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 17/03/23.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var historyImage: UIImageView!
    
    @IBOutlet weak var welcomeBonusLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var creditLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        historyImage.image = UIImage(named: "Earn")
        
        welcomeBonusLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        dateTimeLbl.font = UIFont.systemFont(ofSize: 12)
        dateTimeLbl.textColor = UIColor.lightGray
        
        countLbl.font = UIFont.boldSystemFont(ofSize: 14)
        countLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        creditLbl.font = UIFont.boldSystemFont(ofSize: 14)
        creditLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
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
