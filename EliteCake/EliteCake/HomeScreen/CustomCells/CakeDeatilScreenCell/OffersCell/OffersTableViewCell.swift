//
//  OffersTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 09/02/23.
//

import UIKit

class OffersTableViewCell: UITableViewCell {

//    @IBOutlet weak var offerLogoImg: UIImageView!
//    @IBOutlet weak var offersLbl: UILabel!
    @IBOutlet weak var percentageLogo: UIImageView!
    @IBOutlet weak var FlatDisCounLbl: UILabel!
    @IBOutlet weak var useCodeLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var discountBtn: UIButton!
    
    
    var context: UIViewController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setShadow(view: bgView)
        bgView.cornerRadius = 10
        bgView.backgroundColor = UIColor(named: "PureWhite")
        
//        offersLbl.text = "Offers Available"
//        offersLbl.font = UIFont.boldSystemFont(ofSize: 18)
//        offersLbl.textColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        FlatDisCounLbl.textColor = UIColor.black
        FlatDisCounLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        useCodeLbl.font = UIFont.systemFont(ofSize: 14)
        useCodeLbl.textColor = UIColor.lightGray
        
        percentageLogo.image = UIImage(named: "coupon")

//        offerLogoImg.image = UIImage(named: "tag")
//        offerLogoImg.tintColor = UIColor.green
        
        discountBtn.setTitle("*T&C", for: .normal)
        discountBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }

    @IBAction func discountBtnAction(_ sender: UIButton) {
        
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
