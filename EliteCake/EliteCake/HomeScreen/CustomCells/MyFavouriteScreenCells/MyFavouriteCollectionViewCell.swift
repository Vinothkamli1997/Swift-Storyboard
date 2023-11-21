//
//  MyFavouriteCollectionViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 20/03/23.
//

import UIKit
import Cosmos

class MyFavouriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var vegNonVegImg: UIImageView!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var favBtnView: UIView!
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var dishFlavourNameLbl: UILabel!
    
    @IBOutlet weak var realPriceLbl: UILabel!
    @IBOutlet weak var discountPriceLbl: UILabel!
    @IBOutlet weak var discountPercentageLbl: UILabel!
    
    @IBOutlet weak var seeMore: UILabel!
    
    @IBOutlet weak var shareBtnView: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 20
        bgView.backgroundColor = UIColor(named: "ViewDarkMode")
        setShadow(view: bgView)
        
        dishNameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        dishFlavourNameLbl.text = "In Simplistic Cakes"
        dishFlavourNameLbl.font = UIFont.systemFont(ofSize: 12)
        
        realPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        discountPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        discountPriceLbl.textColor = UIColor.lightGray
        
        discountPercentageLbl.font = UIFont.boldSystemFont(ofSize: 14)
        discountPercentageLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        seeMore.text = "See Details"
        seeMore.font = UIFont.systemFont(ofSize: 12)
        
        
        favBtnView.backgroundColor = UIColor.white
        favBtnView.layer.borderWidth = 1
        favBtnView.layer.borderColor = UIColor.lightGray.cgColor
        favBtnView.layer.cornerRadius = 15
        
        favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        shareBtn.setImage(UIImage(named: "shareIconimg"), for: .normal)
        shareBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        shareBtnView.backgroundColor = UIColor.white
        shareBtnView.layer.borderWidth = 1
        shareBtnView.layer.borderColor = UIColor.lightGray.cgColor
        shareBtnView.layer.cornerRadius = 15
        
        
        
        // Use if you need just to show the stars without getting user's input
        ratingView.settings.updateOnTouch = false
        
        // Show only fully filled stars
        ratingView.settings.fillMode = .precise
        // Other fill modes: .half, .precise
        
        // Change the size of the stars
        ratingView.settings.starSize = 15
        
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
    
    
    @IBAction func shareBtnAction(_ sender: UIButton) {
        let referralCode = "Eliet Cakes"
        let appStoreURLString = "https://play.google.com/store/apps/details?id=com.tt.yumbox.elitecake"
        
        guard let encodedAppStoreURLString = appStoreURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let appToShare = "\(referralCode)\n\(encodedAppStoreURLString)"
        
        let itemsToShare: [Any] = [appToShare]
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        // Customize the activity view controller if needed
        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            // Handle completion or dismissal of the activity view controller if needed
        }
        
        // Get the parent view controller that contains the table view
        if let parentViewController = self.context {
            parentViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}
