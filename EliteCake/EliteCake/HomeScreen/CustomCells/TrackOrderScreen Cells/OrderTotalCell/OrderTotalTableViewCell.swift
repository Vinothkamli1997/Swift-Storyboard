//
//  OrderTotalTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/05/23.
//

import UIKit

class OrderTotalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemTotalLbl: UILabel!
    
    @IBOutlet weak var itemTotalValueLbl: UILabel!
    
    @IBOutlet weak var couponLbl: UILabel!
    
    @IBOutlet weak var couponValueLbl: UILabel!
    
    @IBOutlet weak var coinsLbl: UILabel!
    
    @IBOutlet weak var coinsValueLbl: UILabel!
    
    @IBOutlet weak var taxLbl: UILabel!
    
    @IBOutlet weak var deliveryChargeLbl: UILabel!
    
    @IBOutlet weak var grandTotalLbl: UILabel!
    
    @IBOutlet weak var taxValueLbl: UILabel!
    
    @IBOutlet weak var deliverychargeValueLbl: UILabel!
    
    @IBOutlet weak var grandTotalValueLbl: UILabel!
    
//    @IBOutlet weak var savingsView: UIView!
//
//    @IBOutlet weak var totalSavingsLbl: UILabel!
//
//    @IBOutlet weak var savingsValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemTotalLbl.text = "Item Total"
        itemTotalLbl.font = UIFont.systemFont(ofSize: 14)
        
        itemTotalValueLbl.font = UIFont.boldSystemFont(ofSize: 14)

        coinsLbl.text = "Coins"
        coinsLbl.font = UIFont.systemFont(ofSize: 12)
        coinsLbl.textColor = UIColor(hexFromString: ColorConstant.LIGHT_GREEN)
        
        coinsValueLbl.font = UIFont.systemFont(ofSize: 12)
        coinsValueLbl.textColor = UIColor(hexFromString: ColorConstant.LIGHT_GREEN)

        couponLbl.text = "Coupon"
        couponLbl.font = UIFont.systemFont(ofSize: 12)
        couponLbl.textColor = UIColor(hexFromString: ColorConstant.LIGHT_GREEN)
        
        couponValueLbl.font = UIFont.systemFont(ofSize: 12)
        couponValueLbl.textColor = UIColor(hexFromString: ColorConstant.LIGHT_GREEN)

        taxLbl.text = "Taxes"
        taxLbl.font = UIFont.systemFont(ofSize: 12)
        
        taxValueLbl.text = "Coupon"
        taxValueLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        
        deliveryChargeLbl.text = "Delivery Charges"
        deliveryChargeLbl.font = UIFont.systemFont(ofSize: 12)
        
        deliverychargeValueLbl.text = "Coupon"
        deliverychargeValueLbl.font = UIFont.boldSystemFont(ofSize: 12)

        grandTotalLbl.text = "GRAND TOTAL"
        grandTotalLbl.font = UIFont.boldSystemFont(ofSize: 18)

        grandTotalValueLbl.font = UIFont.boldSystemFont(ofSize: 18)

        
//        savingsView.isHidden = true
//        savingsView.visiblity(gone: true, dimension: 0.0, attribute: .height)
//
//        savingsView.backgroundColor = UIColor(hexFromString: ColorConstant.LIGHT_GREEN)
//        savingsView.layer.borderColor = UIColor.green.cgColor
//        savingsView.layer.borderWidth = 1
//        savingsView.layer.cornerRadius = 10
//        setShadow(view: savingsView)
//
//        totalSavingsLbl.text = "YOUR TOTAL SAVINGS"
//        totalSavingsLbl.font = UIFont.systemFont(ofSize: 14)
//        totalSavingsLbl.textColor = UIColor.green
//
//        savingsValueLbl.font = UIFont.systemFont(ofSize: 14)
//        savingsValueLbl.textColor = UIColor.green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
