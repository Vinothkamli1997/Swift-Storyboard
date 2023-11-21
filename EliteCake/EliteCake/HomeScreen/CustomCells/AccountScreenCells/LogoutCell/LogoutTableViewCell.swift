//
//  LogoutTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 14/03/23.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    @IBOutlet weak var logOutBgView: UIView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var logoutLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        logOutBgView.backgroundColor = UIColor(hexFromString: ColorConstant.ADDITEMPINK)
        logOutBgView.layer.cornerRadius = 10
        
        logoutBtn.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), for: .normal)
        logoutBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        logoutLbl.text = "Log out"
        logoutLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
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
