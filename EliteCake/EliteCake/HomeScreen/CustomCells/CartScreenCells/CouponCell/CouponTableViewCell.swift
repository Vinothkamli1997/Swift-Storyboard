//
//  CouponTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class CouponTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var offersImage: UIImageView!
    @IBOutlet weak var applyCouponLbl: UILabel!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var trailingBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.backgroundColor = UIColor(named: "PureWhite")
        bgView.layer.cornerRadius = 10
        setLightShadow(view: bgView)
        
        offersImage.image = UIImage(named: "coupon")
        
        applyCouponLbl.text = "Apply Coupon"
        applyCouponLbl.font = UIFont.systemFont(ofSize: 14)
        
        availableLbl.font = UIFont.systemFont(ofSize: 12)
        
        trailingBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
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
