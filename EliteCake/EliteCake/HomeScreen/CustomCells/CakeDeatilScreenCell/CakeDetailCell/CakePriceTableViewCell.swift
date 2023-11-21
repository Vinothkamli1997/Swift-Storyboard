//
//  CakePriceTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 06/02/23.
//

import UIKit
import Cosmos

class CakePriceTableViewCell: UITableViewCell {

    @IBOutlet weak var vegorNonvegImg: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    
//    @IBOutlet weak var rateView: CosmosView!

    @IBOutlet weak var cakeName: UILabel!
    @IBOutlet weak var cakeSubtitle: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var realPrice: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var ordernowBtn: UIButton!
    @IBOutlet weak var getitLbl: UILabel!
    @IBOutlet weak var getitPriceLbl: UILabel!
//    @IBOutlet weak var withCouponLbl: UILabel!
    @IBOutlet weak var poundSizeLbl: UILabel!
    
    @IBOutlet weak var offerLogoImg: UIImageView!
    @IBOutlet weak var offersLbl: UILabel!
    
    var cakeDetailResponse: Dish?
    var cakeDetailDishId: CakeDetailParameters? = nil
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cakeName.font = UIFont.boldSystemFont(ofSize: 18.0)
        cakeName.textColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        cakeSubtitle.font = UIFont.systemFont(ofSize: 16.0)
        cakeSubtitle.textColor = UIColor.lightGray
        
        
        discountPrice.font = UIFont.boldSystemFont(ofSize: 18.0)
        discountPrice.textColor = UIColor(hexFromString: ColorConstant.BLACK)

        setLightShadow(view: ordernowBtn)
        
        ordernowBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        ordernowBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        getitLbl.text = "Best Price"
        getitLbl.font = UIFont.boldSystemFont(ofSize: 14)
        getitLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        getitPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        getitPriceLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
//        withCouponLbl.text = "with coupon"
//        withCouponLbl.font = UIFont.boldSystemFont(ofSize: 14)
//        withCouponLbl.textColor = UIColor.darkGray
        
        poundSizeLbl.font = UIFont.boldSystemFont(ofSize: 16)
        poundSizeLbl.textColor = UIColor.darkGray
        
        offersLbl.isHidden = true
        offerLogoImg.isHidden = true
        
        offersLbl.visiblity(gone: true, dimension: 0.0, attribute: .height)
        offerLogoImg.visiblity(gone: true, dimension: 0.0, attribute: .height)
        
        // Use if you need just to show the stars without getting user's input
        ratingView.settings.updateOnTouch = false

        // Show only fully filled stars
        ratingView.settings.fillMode = .precise
        // Other fill modes: .half, .precise

        // Change the size of the stars
        ratingView.settings.starSize = 17

        // Set the distance between stars
        ratingView.settings.starMargin = 3

        // Set the color of a filled star
        ratingView.settings.filledColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)

        // Set the border color of an empty star
        ratingView.settings.emptyBorderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        // Set the border color of a filled star
        ratingView.settings.filledBorderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }

    @IBAction func ordernowBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
        vc.dish_id = (cakeDetailDishId?.dish.dishID)!
        context.navigationController?.pushViewController(vc, animated: true)
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
