//
//  SummaryTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var subTotalCount: UILabel!
    
    @IBOutlet weak var deliveryChargeLbl: UILabel!
    @IBOutlet weak var deliveryChargeCount: UILabel!
    
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var discountCountLbl: UILabel!
    
    @IBOutlet weak var deliverydiscountLbl: UILabel!
    @IBOutlet weak var deliveryDiscountCountLbl: UILabel!
    
    @IBOutlet weak var netDeliveryLbl: UILabel!
    @IBOutlet weak var coinRedemptionLbl: UILabel!
    
    @IBOutlet weak var coinsLbl: UILabel!
    @IBOutlet weak var coinsCount: UILabel!
    
//    @IBOutlet weak var totalLbl: UILabel!
//    @IBOutlet weak var totalCountlbl: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalCountlabel: UILabel!
    
    @IBOutlet weak var redeemView: UIView!
    @IBOutlet weak var redeemLbl: UILabel!
    
    @IBOutlet weak var redeemBtn: UIButton!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //redeemBtn.isHidden = true
        
        subTotalLbl.text = "Subtotal"
        subTotalLbl.font = UIFont.systemFont(ofSize: 16)
        subTotalLbl.textColor = UIColor.gray
        
        subTotalCount.font = UIFont.boldSystemFont(ofSize: 16)
        subTotalCount.textColor = UIColor.gray
        
        deliveryChargeLbl.text = "Delievery Charges"
        deliveryChargeLbl.font = UIFont.systemFont(ofSize: 12)
        deliveryChargeLbl.textColor = UIColor.gray
        
        deliveryChargeCount.font = UIFont.boldSystemFont(ofSize: 12)
        deliveryChargeCount.textColor = UIColor.gray

        discountLbl.text = "Discount"
        discountLbl.font = UIFont.systemFont(ofSize: 12)
        discountLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        discountCountLbl.font = UIFont.boldSystemFont(ofSize: 12)
        discountCountLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                
        coinsLbl.text = "Total Amount"
        coinsLbl.textColor = UIColor.gray
        coinsLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        coinsCount.textColor = UIColor.gray
        coinsCount.font = UIFont.boldSystemFont(ofSize: 14)
        
        deliverydiscountLbl.text = "Delivery Discount"
        deliverydiscountLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        deliverydiscountLbl.font = UIFont.systemFont(ofSize: 12)
        
        deliveryDiscountCountLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
        deliveryDiscountCountLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        netDeliveryLbl.text = "Coin Redemption Discount"
        netDeliveryLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        netDeliveryLbl.font = UIFont.systemFont(ofSize: 12)
        
        coinRedemptionLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        coinRedemptionLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        totalLabel.text = "Amount Payable"
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalLabel.textColor = .black
        
        totalCountlabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalCountlabel.textColor = .black
        
        continueBtn.setTitle("Confirm Order", for: .normal)
        continueBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        continueBtn.tintColor = UIColor.white
        continueBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        continueBtn.layer.cornerRadius = 20
        setShadow(view: continueBtn)
        
        redeemLbl.text = "Redeem"
        redeemLbl.textColor = UIColor.black
        redeemLbl.font = UIFont.systemFont(ofSize: 16)
        
        redeemBtn.setImage(UIImage(systemName: "xmark.octagon.fill"), for: .normal)
        redeemBtn.tintColor = UIColor.green
        
        redeemView.layer.borderWidth = 1
        redeemView.layer.borderColor = UIColor.black.cgColor
        redeemView.layer.cornerRadius = 10
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
