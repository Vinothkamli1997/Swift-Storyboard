//
//  CusineWithDishTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 10/02/23.
//

import UIKit
import Cosmos

class CusineWithDishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cakeName: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var premiumBtn: UIButton!
    
    @IBOutlet weak var cakeSubtitle: UILabel!
    
    @IBOutlet weak var realPriceLbl: UILabel!
    @IBOutlet weak var discountPriceLbl: UILabel!
    @IBOutlet weak var discountPercentageLbl: UILabel!
    
    @IBOutlet weak var getLowPriceLbl: UILabel!
    @IBOutlet weak var cakeTypeImg: UIImageView!
    @IBOutlet weak var cakeTypeLbl: UILabel!
    
//    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var favBtnView: UIView!

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareBtnView: UIView!

    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var infoBtnView: UIView!

    @IBOutlet weak var cakeImage: UIImageView!
    @IBOutlet weak var addBtnView: UIView!
    
    @IBOutlet weak var PlusMinusView: UIView!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    
    @IBOutlet weak var customizeLbl: UILabel!
    @IBOutlet weak var poundLbl: UILabel!
    @IBOutlet weak var addtextLbl: UILabel!
    @IBOutlet weak var plusLbl: UILabel!
    @IBOutlet weak var landPriceLbl: UILabel!
    @IBOutlet weak var vegorNongImg: UIImageView!
    @IBOutlet weak var availabilityImg: UIImageView!
    @IBOutlet weak var withCouponLbl: UILabel!
    
    var flavourCusineDatasList: [FlavourDish] = []
    var context: UIViewController!
    var indexPath: IndexPath!
    weak var delegate: CusineWithDishTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designSetUp()
        
    }
    
    func designSetUp() {
        //CakeName Lbl
        cakeName.font = UIFont.boldSystemFont(ofSize: 14)

        //Cakeimage shadow and cornerraduis
        setLightShadow(view: cakeImage)
        cakeImage.layer.cornerRadius = 20
        cakeImage.layer.masksToBounds = true
        cakeImage.contentMode = UIView.ContentMode.scaleAspectFill
        
        cakeSubtitle.font = UIFont.systemFont(ofSize: 10)
        cakeSubtitle.textColor = UIColor.gray
        
        realPriceLbl.font = UIFont.systemFont(ofSize: 14)
        realPriceLbl.textColor = UIColor.lightGray
        
        discountPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        discountPercentageLbl.font = UIFont.systemFont(ofSize: 14)
        discountPercentageLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        getLowPriceLbl.font = UIFont.systemFont(ofSize: 12)
        getLowPriceLbl.textColor = UIColor(hexFromString: ColorConstant.PREMIUMCOLOR)
        
        cakeTypeLbl.font = UIFont.systemFont(ofSize: 12)
        
        premiumBtn.backgroundColor = UIColor.red
        premiumBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        premiumBtn.cornerRadius = 5
        premiumBtn.titleLabel?.textColor = UIColor(hexFromString: ColorConstant.BLACK)
        setLightShadow(view: premiumBtn)
        premiumBtn.isUserInteractionEnabled = false
        
        poundLbl.font = UIFont.boldSystemFont(ofSize: 12)
        poundLbl.textColor = UIColor.gray
                
        addBtnView.cornerRadius = 10
        addBtnView.layer.borderWidth = 1
        addBtnView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        countLbl.font = UIFont.boldSystemFont(ofSize: 16)
        countLbl.textColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        addtextLbl.text = "ADD"
        addtextLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        addtextLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        plusLbl.text = "+"
        plusLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        plusLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        getLowPriceLbl.text = "Best Price"
        getLowPriceLbl.font = UIFont.boldSystemFont(ofSize: 10)
        getLowPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        withCouponLbl.text = "with coupon"
        withCouponLbl.font = UIFont.boldSystemFont(ofSize: 12)
        withCouponLbl.textColor = UIColor.gray
        
        
        landPriceLbl.font = UIFont.boldSystemFont(ofSize: 16)
        landPriceLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        
        cakeTypeLbl.font = UIFont.boldSystemFont(ofSize: 12)
        cakeTypeLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        customizeLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
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
        
        favBtnView.layer.cornerRadius = 15
        favBtnView.layer.borderWidth = 1
        favBtnView.layer.borderColor = UIColor.lightGray.cgColor
        
        shareBtnView.layer.cornerRadius = 15
        shareBtnView.layer.borderWidth = 1
        shareBtnView.layer.borderColor = UIColor.lightGray.cgColor
        
        infoBtnView.layer.cornerRadius = 15
        infoBtnView.layer.borderWidth = 1
        infoBtnView.layer.borderColor = UIColor.lightGray.cgColor
        
        // Set the image
        let shareImage = UIImage(named: "shareIconimg")
        // Create a new image with the desired color
        let tintImage = shareImage?.withTintColor(UIColor(named: "TextDarkMode")!)
        // Set the tinted image as the button's image
        shareBtn.setImage(tintImage, for: .normal)
        
        
        favBtn.setImage(UIImage(named: "heart"), for: .normal)
        favBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        // Set the image
        let originalImage = UIImage(named: "InfoImg")
        // Create a new image with the desired color
        let tintedImage = originalImage?.withTintColor(UIColor(hexFromString: ColorConstant.PREMIUMCOLOR))
        // Set the tinted image as the button's image
        infoBtn.setImage(tintedImage, for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cakeImageTapped))
        cakeImage.isUserInteractionEnabled = true
        cakeImage.addGestureRecognizer(tapGesture)
        
        let addViewTapped = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        addBtnView.isUserInteractionEnabled = true
        addBtnView.addGestureRecognizer(addViewTapped)
        
        // Use if you need just to show the stars without getting user's input
        ratingView.settings.updateOnTouch = false

        // Show only fully filled stars
        ratingView.settings.fillMode = .precise
        // Other fill modes: .half, .precise

        // Change the size of the stars
        ratingView.settings.starSize = 16

        // Set the distance between stars
        ratingView.settings.starMargin = 1

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

    @objc private func cakeImageTapped() {
            delegate?.didTapCakeImage(at: indexPath)
        }
    
    @objc private func addButtonTapped() {
            delegate?.didTapAddButton(at: indexPath)
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

protocol CusineWithDishTableViewCellDelegate: AnyObject {
    func didTapCakeImage(at indexPath: IndexPath)
    func didTapAddButton(at indexPath: IndexPath)
}
