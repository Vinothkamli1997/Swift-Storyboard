//
//  SuggestionCollectionViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/02/23.
//

import UIKit
import Cosmos

class SuggestionCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var suggestionCakeImg: UIImageView!
    @IBOutlet weak var cakeName: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var vegNonvegImg: UIImageView!
    @IBOutlet weak var orderNowBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet var bestPriceLbl: UILabel!
    @IBOutlet var landingPriceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLightShadow(view: suggestionCakeImg)
        
        // Set corner radius
        suggestionCakeImg.layer.cornerRadius = 20
        suggestionCakeImg.layer.masksToBounds = true
        
        cakeName.font = UIFont.boldSystemFont(ofSize: 14)
        cakeName.textColor = UIColor(named: "TextDarkMode")
        
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.textColor = UIColor.lightGray
        
        
        priceLbl.font = UIFont.boldSystemFont(ofSize: 16)
        priceLbl.textColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        orderNowBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        setLightShadow(view: orderNowBtn)
        orderNowBtn.setTitle(HomeConstant.orderNow, for: .normal)
        orderNowBtn.tintColor = UIColor.white
        orderNowBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        orderNowBtn.cornerRadius = 10
        
        bestPriceLbl.text = "Best Price"
        bestPriceLbl.font = UIFont.boldSystemFont(ofSize: 12)
        bestPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        landingPriceLbl.font = UIFont.boldSystemFont(ofSize: 12)
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
