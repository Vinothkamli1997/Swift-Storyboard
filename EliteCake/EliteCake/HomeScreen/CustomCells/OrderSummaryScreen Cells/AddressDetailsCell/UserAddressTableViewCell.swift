//
//  UserAddressTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 04/05/23.
//

import UIKit

class UserAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var logoImg: UIView!
    
    @IBOutlet weak var addressTitleLbl: UILabel!
    
    @IBOutlet weak var phoneNumberLbl: UILabel!

    @IBOutlet weak var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = UIColor.white
        bgView.cornerRadius = 10
        setShadow(view: bgView)
        
        profileImg.image = UIImage(named: "Yum_Box_Logo")
        profileImg.layer.cornerRadius = 20
        
        nameLbl.font = UIFont.boldSystemFont(ofSize: 20)
        phoneNumberLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        addressTitleLbl.text = "Delivery Address"
        addressTitleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        addressLbl.font = UIFont.systemFont(ofSize: 12)
        addressLbl.textColor = UIColor.gray
        
        logoImg.backgroundColor = UIColor.white
        logoImg.layer.cornerRadius = 20
        setShadow(view: logoImg)
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
