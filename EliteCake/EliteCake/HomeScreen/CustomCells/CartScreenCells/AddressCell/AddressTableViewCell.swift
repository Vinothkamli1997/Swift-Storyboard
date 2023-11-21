//
//  AddressTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var selectAddressLbl: UILabel!
    @IBOutlet weak var deliveryTYpeLbl: UILabel!
    @IBOutlet weak var changeBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.backgroundColor = UIColor(named: "PureWhite")
        bgView.layer.cornerRadius = 10
        setShadow(view: bgView)
        
        deliveryLbl.text = "Delivery at"
        deliveryLbl.font = UIFont.systemFont(ofSize: 14)
        deliveryLbl.textColor = UIColor.lightGray
        
        selectAddressLbl.font = UIFont.systemFont(ofSize: 14)
        
        deliveryTYpeLbl.font = UIFont.systemFont(ofSize: 12)
        deliveryTYpeLbl.textColor = UIColor.gray
        deliveryTYpeLbl.isHidden = true
        
        changeBtn.setTitle("Change", for: .normal)
        changeBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        changeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        locationImage.image = UIImage(named: "location")
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
