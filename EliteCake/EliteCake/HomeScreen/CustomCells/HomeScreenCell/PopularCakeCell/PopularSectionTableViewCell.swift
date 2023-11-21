//
//  PopularSectionTableViewCell.swift
//  EliteCake
//
//  Created by apple on 20/01/23.
//

import UIKit
import Cosmos
class PopularSectionTableViewCell: UITableViewCell {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var leftimgView: UIView!
    @IBOutlet var rightimgView: UIView!
    @IBOutlet var popularLbl: UILabel!
//    @IBOutlet weak var popularLblView: UIView!
    
    @IBOutlet var trendImg: UIImageView!
    @IBOutlet var trendingLbl: UILabel!
    
    @IBOutlet var cakeNameLbl: UILabel!
    @IBOutlet var subNameLbl: UILabel!
        
    @IBOutlet var realPrice: UILabel!
    @IBOutlet var offerPrice: UILabel!
    @IBOutlet var discountLbl: UILabel!
    
    @IBOutlet var orderBtn: UIButton!
    @IBOutlet var vegornonvegImg: UIImageView!
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rigntImage: UIImageView!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet var poundLbl: UILabel!
    @IBOutlet var bestPriceLbl: UILabel!
    @IBOutlet var landingPriceLbl: UILabel!
    @IBOutlet var withCouponLbl: UILabel!

    var dish_id: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
//        popularLbl.text = HomeConstant.popularWeek
        
        cakeNameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        subNameLbl.font = UIFont.systemFont(ofSize: 14)
        
        orderBtn.setTitle(HomeConstant.orderNow, for: .normal)
        orderBtn.tintColor = UIColor.white
        orderBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        orderBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        orderBtn.cornerRadius = 10
        setLightShadow(view: orderBtn)
        
        setLightShadow(view: bgView)
        bgView.cornerRadius = 20
        
        trendingLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        trendImg.image = UIImage(named: "medal")
        
        realPrice.textColor = UIColor(named: "TextDarkMode")
        offerPrice.textColor = UIColor(named: "TextDarkMode")
        cakeNameLbl.textColor = UIColor(named: "TextDarkMode")
        discountLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        poundLbl.textColor = UIColor.darkGray
        poundLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        bestPriceLbl.text = "Best Price"
        bestPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        bestPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        landingPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        landingPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)

        withCouponLbl.text = "with coupon"
        withCouponLbl.font = UIFont.boldSystemFont(ofSize: 14)
        withCouponLbl.textColor = UIColor.gray
        
        // Use if you need just to show the stars without getting user's input
        ratingView.settings.updateOnTouch = false

        // Show only fully filled stars
        ratingView.settings.fillMode = .precise
        // Other fill modes: .half, .precise

        // Change the size of the stars
        ratingView.settings.starSize = 15

        // Set the distance between stars
        ratingView.settings.starMargin = 2

        // Set the color of a filled star
        ratingView.settings.filledColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)

        // Set the border color of an empty star
        ratingView.settings.emptyBorderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        // Set the border color of a filled star
        ratingView.settings.filledBorderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state

    }
    
    //Nib Register
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

//View Wifth Hide
//extension UIView {
//    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutConstraint.Attribute = .height) -> Void {
//        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
//            constraint.constant = gone ? 0.0 : dimension
//            self.layoutIfNeeded()
//            self.isHidden = gone
//        }
//    }
//}
