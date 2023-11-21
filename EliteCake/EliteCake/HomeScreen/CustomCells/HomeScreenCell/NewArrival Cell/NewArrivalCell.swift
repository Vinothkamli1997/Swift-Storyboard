//
//  NewArrivalCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 19/01/23.
//

import UIKit
import Cosmos

class NewArrivalCell: UICollectionViewCell {

    @IBOutlet var cakeNameLbl: UILabel!
    @IBOutlet weak var newArrivalImg: UIImageView!
    @IBOutlet var subTitleLbl: UILabel!
    @IBOutlet var vegorNonvegImg: UIImageView!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var orderNowBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet var bestPriceLbl: UILabel!
    @IBOutlet var landingPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Set corner radius
        setLightShadow(view: newArrivalImg)
        newArrivalImg.layer.cornerRadius = 20
        newArrivalImg.layer.masksToBounds = true
        
        setLightShadow(view: orderNowBtn)
        orderNowBtn.cornerRadius = 10
        orderNowBtn.setTitle(HomeConstant.orderNow, for: .normal)
        orderNowBtn.tintColor = UIColor.white
        orderNowBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
     
        bestPriceLbl.text = "Best Price"
        bestPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        bestPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        landingPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        landingPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)

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
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
