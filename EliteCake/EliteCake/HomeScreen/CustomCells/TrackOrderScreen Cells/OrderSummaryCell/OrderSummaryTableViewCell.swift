//
//  OrderSummaryTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/05/23.
//

import UIKit

class OrderSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderDetails: UILabel!
    @IBOutlet weak var orderNumLbl: UILabel!
    @IBOutlet weak var orderNumValueLbl: UILabel!
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var paymentValueLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateValueLbl: UILabel!
    @IBOutlet weak var phoneNumLbl: UILabel!
    @IBOutlet weak var phoneNumvalueLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var deliveryValueLbl: UILabel!
    @IBOutlet weak var deliveryTypeLbl: UILabel!
    @IBOutlet weak var deliveryTypeValueLbl: UILabel!
    
    @IBOutlet weak var callLbl: UILabel!
    @IBOutlet weak var callNumberLbl: UILabel!

    
    @IBOutlet weak var headerLineView: UIView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        orderDetails.text = "Order Details"
        orderDetails.font = UIFont.boldSystemFont(ofSize: 16)

        orderNumLbl.text = "Order Number"
        orderNumLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        orderNumValueLbl.font = UIFont.systemFont(ofSize: 14)
        orderNumValueLbl.textColor = UIColor.gray
        
        paymentLbl.text = "Payment"
        paymentLbl.font = UIFont.boldSystemFont(ofSize: 14)

        paymentValueLbl.font = UIFont.systemFont(ofSize: 14)
        paymentValueLbl.textColor = UIColor.gray
        
        deliveryTypeLbl.text = "Delivery Type"
        deliveryTypeLbl.font = UIFont.boldSystemFont(ofSize: 14)

        deliveryTypeValueLbl.font = UIFont.systemFont(ofSize: 14)
        deliveryTypeValueLbl.textColor = UIColor.gray
        
        dateLbl.text = "Date"
        dateLbl.font = UIFont.boldSystemFont(ofSize: 14)

        dateValueLbl.font = UIFont.systemFont(ofSize: 14)
        dateValueLbl.textColor = UIColor.gray
        
        phoneNumLbl.text = "Phone Number"
        phoneNumLbl.font = UIFont.boldSystemFont(ofSize: 14)

        phoneNumvalueLbl.font = UIFont.systemFont(ofSize: 14)
        phoneNumvalueLbl.textColor = UIColor.gray
        
        deliveryLbl.text = "Delivery to"
        deliveryLbl.font = UIFont.boldSystemFont(ofSize: 14)

        deliveryValueLbl.font = UIFont.systemFont(ofSize: 14)
        deliveryValueLbl.textColor = UIColor.gray
        
        deliveryLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        callLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        callLbl.font = UIFont.boldSystemFont(ofSize: 20)

        callNumberLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        callNumberLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        headerLineView.backgroundColor = UIColor.gray
        bottomLineView.backgroundColor = UIColor.gray
        topLineView.backgroundColor = UIColor.gray
        
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
