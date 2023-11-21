//
//  SingleOrderHistoryTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 06/11/23.
//

import UIKit

class SingleOrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView1: UIView!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var cakeImage: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var viewMenuLbl: UILabel!
    
    @IBOutlet weak var viewMenuBtn: UIButton!
    
    @IBOutlet weak var secondView: UIView!
            
    @IBOutlet weak var reorderBtn: UIButton!
    
    @IBOutlet weak var ratingBgView: UIView!
    @IBOutlet weak var ratingTitleLbl: UILabel!
    
    @IBOutlet weak var ratingView1: UIView!
    @IBOutlet weak var ratingViewLabel1: UILabel!
    @IBOutlet weak var ratingViewImage1: UIImageView!
    
    @IBOutlet weak var ratingView2: UIView!
    @IBOutlet weak var ratingViewLabel2: UILabel!
    @IBOutlet weak var ratingViewImage2: UIImageView!
    
    @IBOutlet weak var ratingView3: UIView!
    @IBOutlet weak var ratingViewLabel3: UILabel!
    @IBOutlet weak var ratingViewImage3: UIImageView!
    
    @IBOutlet weak var ratingView4: UIView!
    @IBOutlet weak var ratingViewLabel4: UILabel!
    @IBOutlet weak var ratingViewImage4: UIImageView!
    
    @IBOutlet weak var ratingView5: UIView!
    @IBOutlet weak var ratingViewLabel5: UILabel!
    @IBOutlet weak var ratingViewImage5: UIImageView!
        
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var callBtn: UIView!
    @IBOutlet weak var callUsLbl: UILabel!

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dishPriceLbl: UILabel!
    @IBOutlet weak var trailingBtn: UIButton!
    
    @IBOutlet weak var dishListView: UIView!
    @IBOutlet weak var dishListName: UILabel!
    @IBOutlet weak var dishListCakeVagImage: UIImageView!
    @IBOutlet weak var dishListCakeImage: UIImageView!
    
    @IBOutlet weak var addonDishListView: UIView!
    @IBOutlet weak var addonDishName: UILabel!
    @IBOutlet weak var addonDishPrice: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        designSetUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func designSetUp() {
        bgView1.backgroundColor = UIColor.white
        bgView1.layer.cornerRadius = 20
        setShadow(view: bgView1)
        
        titleLbl.text = "Elite Cakes"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        setShadow(view: cakeImage)
        
        dateTimeLbl.font = UIFont.systemFont(ofSize: 12)
        dateTimeLbl.textColor = UIColor.gray
        
        dateLbl.font = UIFont.systemFont(ofSize: 12)
        dateLbl.textColor = UIColor.black
        
        statusLbl.font = UIFont.boldSystemFont(ofSize: 14)
        statusLbl.textColor = .black
        statusLbl.textAlignment = .center
        
        statusView.backgroundColor = UIColor(hexFromString: ColorConstant.STATUS_BG)
        statusView.layer.cornerRadius = 10
        setShadow(view: statusView)
        
        viewMenuLbl.text = "View menu"
        viewMenuLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        viewMenuLbl.font = UIFont.systemFont(ofSize: 14)
        
        viewMenuBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        viewMenuBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        firstView.backgroundColor = UIColor(hexFromString: ColorConstant.FIRST_OFF_BG)
        firstView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        
        secondView.backgroundColor = UIColor.white
        secondView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        
        dishListName.font = UIFont.boldSystemFont(ofSize: 14)
        addonDishName.font = UIFont.systemFont(ofSize: 12)
        addonDishPrice.font = UIFont.systemFont(ofSize: 12)
        
        reorderBtn.setTitle("Reorder", for: .normal)
        reorderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        reorderBtn.layer.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        reorderBtn.tintColor = UIColor.white
        reorderBtn.layer.cornerRadius = 10
        setLightShadow(view: reorderBtn)
        
        ratingTitleLbl.text = "Rating"
        ratingTitleLbl.textColor = UIColor.black
        ratingTitleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        ratingViewLabel1.text = "1"
        ratingViewLabel1.textColor = .black
        ratingViewImage1.image = UIImage(systemName: "star.fill")
        ratingViewImage1.tintColor = .lightGray
        
        ratingView1.layer.borderWidth = 1
        ratingView1.layer.borderColor = UIColor.gray.cgColor
        ratingView1.layer.cornerRadius = 10
        ratingView1.backgroundColor = .clear
        
        ratingViewLabel2.text = "2"
        ratingViewLabel2.textColor = .black
        ratingViewImage2.image = UIImage(systemName: "star.fill")
        ratingViewImage2.tintColor = .lightGray

        ratingView2.layer.borderWidth = 1
        ratingView2.layer.borderColor = UIColor.gray.cgColor
        ratingView2.layer.cornerRadius = 10
        ratingView2.backgroundColor = .clear

        ratingViewLabel3.text = "3"
        ratingViewLabel3.textColor = .black
        ratingViewImage3.image = UIImage(systemName: "star.fill")
        ratingViewImage3.tintColor = .lightGray

        ratingView3.layer.borderWidth = 1
        ratingView3.layer.borderColor = UIColor.gray.cgColor
        ratingView3.layer.cornerRadius = 10
        ratingView3.backgroundColor = .clear

        ratingViewLabel4.text = "4"
        ratingViewLabel4.textColor = .black
        ratingViewImage4.image = UIImage(systemName: "star.fill")
        ratingViewImage4.tintColor = .lightGray

        ratingView4.layer.borderWidth = 1
        ratingView4.layer.borderColor = UIColor.gray.cgColor
        ratingView4.layer.cornerRadius = 10
        ratingView4.backgroundColor = .clear

        ratingViewLabel5.text = "5"
        ratingViewLabel5.textColor = .black
        ratingViewImage5.image = UIImage(systemName: "star.fill")
        ratingViewImage5.tintColor = .lightGray

        ratingView5.layer.borderWidth = 1
        ratingView5.layer.borderColor = UIColor.gray.cgColor
        ratingView5.layer.cornerRadius = 10
        ratingView5.backgroundColor = .clear
        
        callView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        callView.layer.cornerRadius = 10
        setLightShadow(view: callView)
        
        callBtn.tintColor = UIColor.white
        
        callUsLbl.text = "Call us"
        callUsLbl.textColor = UIColor.white
        callUsLbl.font = UIFont.systemFont(ofSize: 14)
        
        dishPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        trailingBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
