//
//  ApplyCouponTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/05/23.
//

import UIKit

class ApplyCouponTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flatBgView: UIView!
    
    @IBOutlet weak var flatDiscountLbl: UILabel!
    
    @IBOutlet weak var flatLeftBgView: UIView!
    
    @IBOutlet weak var flatRigthView: UIView!
    
    @IBOutlet weak var discountApplyBtn: UIButton!
    
    @IBOutlet weak var discountcontentLbl: UILabel!
    
    @IBOutlet weak var borderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        discountApplyBtn.setTitle("Apply", for: .normal)
        discountApplyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        discountApplyBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                
        //        let borderLayer = CAShapeLayer()
        //        borderLayer.strokeColor = UIColor.black.cgColor
        //        borderLayer.lineDashPattern = [4,4]
        //        borderLayer.frame = flatBgView.bounds
        //        borderLayer.fillColor = nil
        //        borderLayer.path = UIBezierPath(roundedRect: flatBgView.bounds, cornerRadius: 0).cgPath
        //        flatBgView.layer.addSublayer(borderLayer)
        
        flatBgView.backgroundColor = UIColor(hexFromString: ColorConstant.FLATBGGREEN)
        
        flatLeftBgView.layer.cornerRadius = 15
        
        flatRigthView.layer.cornerRadius = 15
        
        flatDiscountLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        borderView.backgroundColor = UIColor.lightGray
        
        discountcontentLbl.textColor = UIColor(named: "TextDarkMode")
        discountcontentLbl.numberOfLines = 0
        discountcontentLbl.lineBreakMode = .byWordWrapping
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
