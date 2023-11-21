//
//  CakeDetailQuantityCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 16/02/23.
//

import UIKit
import Cosmos
import iOSDropDown

class CakeDetailQuantityCell: UITableViewCell {
    
    @IBOutlet weak var detailBtn: UIButton!
    
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    
    @IBOutlet weak var cakeNameLbl: UILabel!
    @IBOutlet weak var vegNonvegImg: UIImageView!
    @IBOutlet weak var cakeImage: UIImageView!
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dropDown: DropDown!
    
    @IBOutlet weak var addFavBtn: UIButton!
    
    var context: UIViewController!
    var addonDish: AddonDish? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Cakeimage shadow and cornerraduis
        setLightShadow(view: cakeImage)
        cakeImage.layer.cornerRadius = 20
        cakeImage.layer.masksToBounds = true
        cakeImage.contentMode = UIView.ContentMode.scaleAspectFill
        
        detailBtn.setTitle("Click here to see the details", for: .normal)
        detailBtn.tintColor = .black
        detailBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        setShadow(view: detailBtn)
        
        setLightShadow(view: detailBtn)
        detailBtn.cornerRadius = 10
        
        minusBtn.layer.borderWidth = 1.0
        minusBtn.layer.borderColor = UIColor.lightGray.cgColor
        minusBtn.layer.cornerRadius = 10.0
        minusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        minusBtn.setTitle("-", for: .normal)
        
        addFavBtn.isHidden = false
        addFavBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        detailBtn.setTitle("Click here to see the details", for: .normal)
        detailBtn.tintColor = .black
        detailBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        let imageName = "heart"
        let originalImage = UIImage(named: imageName)
        let tintedImage = originalImage?.withTintColor(.red)
        addFavBtn.setImage(tintedImage, for: .normal)
        
        // Assuming you have a UIButton instance named myButton
        plusBtn.layer.borderWidth = 1.0
        plusBtn.layer.borderColor = UIColor.lightGray.cgColor
        plusBtn.layer.cornerRadius = 10.0
        plusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        plusBtn.setTitle("+", for: .normal)
        
        countLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        countLbl.font = UIFont.boldSystemFont(ofSize: 16)
                
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
        
        // Set the optional ID values
        dropDown.optionIds = [1, 23, 54, 22]
        
        // Set the row height to 50
        dropDown.rowHeight = 50
        
        // Disable search
        dropDown.isSearchEnable = false
        
        // Set the selected row color to white
        dropDown.selectedRowColor = UIColor.white
        
        // Set the arrow size to 15
        dropDown.arrowSize = 15
        
        // Set the content mode to center
        dropDown.contentMode = .center
        
        // Set the font to system font with size 12
        dropDown.font = UIFont.boldSystemFont(ofSize: 12)
        dropDown.layer.borderColor = UIColor(named: "GrayColor")?.cgColor
        dropDown.layer.cornerRadius = 10
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        context.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func plusBtnAction(_ sender: UIButton) {
        var newCount = 0
        if let count = Int(countLbl.text ?? "1") {
            newCount = count + 1
            countLbl.text = "\(newCount)"
        }
        
        NotificationCenter.default.post(name: .addOnDishPriceAdded, object: nil, userInfo: ["count": newCount])
    }
    
    @IBAction func minusBtnAction(_ sender: UIButton) {
        var newCount = 0
        if let count = Int(countLbl.text ?? "1") {
            newCount = max(0, count - 1)
            countLbl.text = "\(newCount)"
        }
        
        if countLbl.text == "0" {
            context.navigationController?.popViewController(animated: true)
        }
        
        NotificationCenter.default.post(name: .addOnDishPriceremoved, object: nil, userInfo: ["count": newCount])
    }
    
    @IBAction func detailBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = addonDish!.dishID
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
