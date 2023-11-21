//
//  CategoryCollectionViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/02/23.
//

import UIKit
import Cosmos

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var cakeImage: UIImageView!
    
    @IBOutlet weak var addViw: UIView!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var plusLbl: UILabel!
    
    @IBOutlet weak var vegNonvenImg: UIImageView!
    
    @IBOutlet weak var cakeName: UILabel!
    @IBOutlet weak var flavourName: UILabel!
    
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var realPriceLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    
    @IBOutlet weak var speaciallyImg: UIImageView!
    @IBOutlet weak var speaciallyLbl: UILabel!
    
    @IBOutlet weak var eliteLblBtn: UIButton!
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var favBtnView: UIView!

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareBtnView: UIView!

    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var infoBtnView: UIView!

    @IBOutlet weak var poundLbl: UILabel!
    
    @IBOutlet weak var bestPriceLbl: UILabel!

    @IBOutlet weak var bestPriceValueLbl: UILabel!
    
    @IBOutlet weak var PlusMinusView: UIView!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    
    var categoryListDatas: [CategoryDish] = []
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
        
    }
    
    func setUp() {
        setShadow(view: bgView)
        bgView.layer.cornerRadius = 20
        
        addView.layer.borderWidth = 1
        addView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        addView.layer.cornerRadius = 10
        
        flavourName.font = UIFont.systemFont(ofSize: 10)
        flavourName.textColor = UIColor.lightGray
        flavourName.textColor = .black
        
        cakeName.font = UIFont.boldSystemFont(ofSize: 14)
        cakeName.textAlignment = .center
        cakeName.textColor = .black
        
        speaciallyLbl.font = UIFont.systemFont(ofSize: 10)
        speaciallyLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        realPriceLbl.font = UIFont.systemFont(ofSize: 8)
        discountPriceLabel.font = UIFont.boldSystemFont(ofSize: 10)
        discountLbl.font = UIFont.systemFont(ofSize: 8)
        poundLbl.font = UIFont.systemFont(ofSize: 8)
        discountLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        eliteLblBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        addLbl.text = "ADD"
        addLbl.font = UIFont.boldSystemFont(ofSize: 16)
        addLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        addView.cornerRadius = 10
        addView.layer.borderWidth = 1
        addView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        plusLbl.text = "+"
        plusLbl.font = UIFont.boldSystemFont(ofSize: 16)
        plusLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        bestPriceLbl.text = "Best Price"
        bestPriceLbl.font = UIFont.boldSystemFont(ofSize: 11)
        bestPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)

        bestPriceValueLbl.font = UIFont.boldSystemFont(ofSize: 11)
        bestPriceValueLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        // Set the image
        let shareImage = UIImage(named: "shareIconimg")
        // Create a new image with the desired color
        let tintImage = shareImage?.withTintColor(UIColor.black)
        // Set the tinted image as the button's image
        shareBtn.setImage(tintImage, for: .normal)
        
        shareBtnView.layer.cornerRadius = 15
        shareBtnView.layer.borderWidth = 1
        shareBtnView.layer.borderColor = UIColor.lightGray.cgColor
        
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
        
        // Set the image
        let favImage = UIImage(named: "heart")
        // Create a new image with the desired color
        let favImg = favImage?.withTintColor(UIColor(hexFromString: ColorConstant.PRIMARYCOLOR))
        // Set the tinted image as the button's image
        favBtn.setImage(favImg, for: .normal)
        
        favBtnView.layer.cornerRadius = 15
        favBtnView.layer.borderWidth = 1
        favBtnView.layer.borderColor = UIColor.lightGray.cgColor
//        setShadow(view: favBtnView)
        
        // Set the image
        let infoImage = UIImage(named: "InfoImg")
        // Create a new image with the desired color
        let infoImg = infoImage?.withTintColor(UIColor(hexFromString: ColorConstant.PREMIUMCOLOR))
        // Set the tinted image as the button's image
        infoBtn.setImage(infoImg, for: .normal)
        
        infoBtnView.layer.cornerRadius = 15
        infoBtnView.layer.borderWidth = 1
        infoBtnView.layer.borderColor = UIColor.lightGray.cgColor
//        setShadow(view: infoBtnView)
        
        
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
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
