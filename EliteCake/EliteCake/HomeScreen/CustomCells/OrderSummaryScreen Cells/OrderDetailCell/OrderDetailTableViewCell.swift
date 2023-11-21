//
//  OrderDetailTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 04/05/23.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var callbtnView: UIView!

    @IBOutlet weak var callBtn: UIButton!
    
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var deliveryTypeLbl: UILabel!
    
    @IBOutlet weak var orderLogo: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var vegNonVegImg: UIImageView!
    
    @IBOutlet weak var cakeNameLbl: UILabel!
    
    @IBOutlet weak var summaryLbl: UILabel!
    
    @IBOutlet weak var rightSideBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        bgView.backgroundColor = UIColor.white
        bgView.cornerRadius = 10
        setShadow(view: bgView)
        
        logoImage.image = UIImage(named: "Yum_Box_Logo")
        
        nameLbl.text = "Elite Cakes"
        nameLbl.textColor = UIColor(hexFromString: ColorConstant.BLACK)
        nameLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        addressLbl.textColor = UIColor.gray
        addressLbl.font = UIFont.systemFont(ofSize: 14)
        
        callBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        titleLbl.text = "Order Details"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        cakeNameLbl.font = UIFont.systemFont(ofSize: 16)
        cakeNameLbl.textColor = UIColor.gray
        
        detailView.layer.borderWidth = 1
        detailView.layer.borderColor = UIColor.green.cgColor
        detailView.layer.cornerRadius = 5
                
        deliveryTypeLbl.textColor = UIColor.systemGreen
        deliveryTypeLbl.font = UIFont.systemFont(ofSize: 14)
        
        summaryLbl.text = "View order summary"
        summaryLbl.font = UIFont.systemFont(ofSize: 12)
        summaryLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        rightSideBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        rightSideBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        vegNonVegImg.image = UIImage(named: "vegImage")
        
        orderLogo.image = UIImage(named: "Yum_Box_Logo")
        
        callbtnView.backgroundColor = UIColor.white
        callbtnView.layer.cornerRadius = 18
        setShadow(view: callbtnView)
        
        callBtn.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        callBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
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
