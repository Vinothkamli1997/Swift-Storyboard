//
//  CartHeaderTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class CartHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var deliveryBgView: UIView!
    
    @IBOutlet weak var takeAwayView: UIView!
    @IBOutlet weak var takeAwayBtn: UIButton!
    @IBOutlet weak var takeAwayImage: UIImageView!
    
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var deliveryBtn: UIButton!
    @IBOutlet weak var deliveryImage: UIImageView!
    
//    @IBOutlet weak var imageLogo: UIImageView!
//
//    @IBOutlet weak var outletName: UILabel!
//    @IBOutlet weak var ddressLbl: UILabel!
    
    @IBOutlet weak var singleTypeLbl: UILabel!
    @IBOutlet weak var singleDelTpeView: UIView!
    @IBOutlet weak var singleTypeImage: UIImageView!

    
    var context: UIViewController!
    var backBtnScreenType: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLbl.text = "Cart"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        titleLbl.textColor = UIColor.black
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = .black

        takeAwayBtn.setTitle("Take Away", for: .normal)
        let takeAwayImg = UIImage(named: "delivery-boy")?.withRenderingMode(.alwaysTemplate)
        takeAwayImage.image = takeAwayImg
        takeAwayImage.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        takeAwayView.backgroundColor = UIColor.white
        takeAwayView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
        deliveryBtn.setTitle("Delivery", for: .normal)
        let deliveryImg = UIImage(named: "motorbike")?.withRenderingMode(.alwaysTemplate)
        deliveryImage.image = deliveryImg
        deliveryImage.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        singleDelTpeView.backgroundColor = UIColor(hexFromString: ColorConstant.LIGHTBLUE)
        singleDelTpeView.layer.cornerRadius = 10
        setLightShadow(view: singleDelTpeView)
        
        deliveryBgView.backgroundColor = UIColor(hexFromString: ColorConstant.LIGHTBLUE)
        deliveryBgView.layer.cornerRadius = 10
        setLightShadow(view: deliveryBgView)
                
        let takeAwayTapGesture = UITapGestureRecognizer(target: self, action: #selector(takeAwayViewTapped))
        takeAwayView.addGestureRecognizer(takeAwayTapGesture)
        
        let deliveryTapGesture = UITapGestureRecognizer(target: self, action: #selector(deliveryViewTapped))
        deliveryView.addGestureRecognizer(deliveryTapGesture)
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
    
    @IBAction func takeAwayBtn(_ sender: UIButton) {
        takeAwayView.backgroundColor = UIColor.white
        deliveryView.backgroundColor = nil
        takeAwayView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
        
    }
    
    @IBAction func deliveryBtn(_ sender: UIButton) {
        deliveryView.backgroundColor = UIColor.white
        takeAwayView.backgroundColor = nil
        deliveryView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
    }
    
    @objc func takeAwayViewTapped() {
        takeAwayView.backgroundColor = UIColor.white
        deliveryView.backgroundColor = nil
        takeAwayView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
    }
    
    @objc func deliveryViewTapped() {
        deliveryView.backgroundColor = UIColor.white
        takeAwayView.backgroundColor = nil
        deliveryView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
    }
}
