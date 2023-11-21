//
//  ListSectionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 14/03/23.
//

import UIKit

class ListSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var leadingBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var trailingBtn: UIButton!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = UIColor(named: "ViewDarkMode")
        bgView.layer.cornerRadius = 10
                
        setLightShadow(view: bgView)
        
        ratingView.layer.cornerRadius = 10
//        ratingView.backgroundColor = UIColor.lightGray
        setLightShadow(view: ratingView)
        
        ratingBtn.tintColor = UIColor.orange
        
        trailingBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        trailingBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        leadingBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        ratingLbl.font = UIFont.systemFont(ofSize: 14)
            
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
