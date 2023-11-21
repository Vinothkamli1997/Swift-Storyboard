//
//  DishDetailsTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 22/02/23.
//

import UIKit
import Cosmos

class DishDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var cakeImage: UIImageView!
    
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet weak var vegNonvegImg: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var cakeName: UILabel!
    
    @IBOutlet weak var cakeFlavourName: UILabel!
    
    @IBOutlet weak var discountPriceLbl: UILabel!
    @IBOutlet weak var realPriceLbl: UILabel!
    @IBOutlet weak var discountPercentage: UILabel!
    @IBOutlet weak var poundLbl: UILabel!
    
    @IBOutlet weak var getLowPriceLbl: UILabel!
    @IBOutlet weak var landingPriceLbl: UILabel!
    
    @IBOutlet weak var availabilityTypeImg: UIImageView!
    @IBOutlet weak var cakeBakedTypeLbl: UILabel!
    
    @IBOutlet weak var cakeTypeLbl: UIButton!
    
    @IBOutlet weak var favBtnView: UIView!
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var shareBtnView: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var infoBtnView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var plusLbl: UILabel!
    
    @IBOutlet weak var couponLbl: UILabel!
    @IBOutlet weak var customizeLbl: UILabel!
    
    @IBOutlet weak var PlusMinusView: UIView!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.backgroundColor = UIColor(named: "PureWhite")
        setShadow(view: bgView)
        
        cakeFlavourName.font = UIFont.systemFont(ofSize: 12)
        cakeFlavourName.textColor = UIColor.lightGray
        
        cakeName.font = UIFont.boldSystemFont(ofSize: 14)
        
        cakeBakedTypeLbl.font = UIFont.systemFont(ofSize: 12)
        cakeBakedTypeLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        realPriceLbl.font = UIFont.systemFont(ofSize: 14)
        realPriceLbl.textColor = UIColor.lightGray
        discountPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        discountPercentage.font = UIFont.systemFont(ofSize: 14)
        discountPercentage.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        getLowPriceLbl.text = "Best Price"
        getLowPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        getLowPriceLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        landingPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        landingPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        customizeLbl.font = UIFont.boldSystemFont(ofSize: 10)
        
        couponLbl.text = "with coupon"
        couponLbl.font = UIFont.boldSystemFont(ofSize: 12)
        couponLbl.textColor = UIColor.gray
        
        cakeTypeLbl.backgroundColor = UIColor.red
        cakeTypeLbl.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        cakeTypeLbl.cornerRadius = 5
        cakeTypeLbl.titleLabel?.textColor = UIColor(hexFromString: ColorConstant.BLACK)
        setLightShadow(view: cakeTypeLbl)
        cakeTypeLbl.isUserInteractionEnabled = false
        
        addLbl.text = "ADD"
        addLbl.font = UIFont.boldSystemFont(ofSize: 16)
        addLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        favBtnView.layer.borderWidth = 1
        favBtnView.layer.borderColor = UIColor.lightGray.cgColor
        favBtnView.layer.cornerRadius = 18
        
        favBtn.setImage(UIImage(named: "heart"), for: .normal)
        favBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        shareBtnView.layer.borderWidth = 1
        shareBtnView.layer.borderColor = UIColor.lightGray.cgColor
        shareBtnView.layer.cornerRadius = 18
        
        infoBtnView.layer.borderWidth = 1
        infoBtnView.layer.borderColor = UIColor.lightGray.cgColor
        infoBtnView.layer.cornerRadius = 18
        
        addView.cornerRadius = 10
        addView.layer.borderWidth = 2
        addView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        PlusMinusView.cornerRadius = 10
        PlusMinusView.layer.borderWidth = 2
        PlusMinusView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        minusBtn.setTitle("-", for: .normal)
        minusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        minusBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        plusBtn.setTitle("+", for: .normal)
        plusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        plusBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        countLbl.text = "1"
        countLbl.font = UIFont.boldSystemFont(ofSize: 16)
        countLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        plusLbl.text = "+"
        plusLbl.font = UIFont.boldSystemFont(ofSize: 16)
        plusLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        // Set the image
        let originalImage = UIImage(named: "InfoImg")
        // Create a new image with the desired color
        let tintedImage = originalImage?.withTintColor(UIColor(hexFromString: ColorConstant.PREMIUMCOLOR))
        // Set the tinted image as the button's image
        infoBtn.setImage(tintedImage, for: .normal)
        
        // Set the image
        let shareImage = UIImage(named: "shareIconimg")
        // Create a new image with the desired color
        let shareImg = shareImage?.withTintColor(UIColor.black)
        // Set the tinted image as the button's image
        shareBtn.setImage(shareImg, for: .normal)
        
        
        // Use if you need just to show the stars without getting user's input
        ratingView.settings.updateOnTouch = false

        // Show only fully filled stars
        ratingView.settings.fillMode = .precise
        // Other fill modes: .half, .precise

        // Change the size of the stars
        ratingView.settings.starSize = 16

        // Set the distance between stars
        ratingView.settings.starMargin = 3

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
        
//        let yourImage = UIImage(named: "pinNew")
        
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
