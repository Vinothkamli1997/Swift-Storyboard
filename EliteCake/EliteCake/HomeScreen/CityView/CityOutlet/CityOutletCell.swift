//
//  CityOutletCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 23/01/23.
//

import UIKit

class CityOutletCell: UITableViewCell {

    @IBOutlet weak var eliteCakeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var deliverLbl: UILabel!
    @IBOutlet weak var deliverLogo: UIImageView!
    @IBOutlet weak var takeawayLbl: UILabel!
    @IBOutlet weak var takeawayLogo: UIImageView!
    @IBOutlet weak var approxLbl: UILabel!
    @IBOutlet weak var approxImg: UIImageView!
    @IBOutlet weak var EliteLogo: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.cornerRadius = 20
        setShadow(view: bgView)
        setShadow(view: bottomView)
        bottomView.roundCorners(corners: [.bottomRight,.bottomLeft], radius: 20)
        eliteCakeLbl.font = UIFont.boldSystemFont(ofSize: 20.0)
        addressLbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        addressLbl.textColor = UIColor.gray
        deliverLbl.font = UIFont.boldSystemFont(ofSize: 14.0)
        deliverLbl.textColor = UIColor.gray
        takeawayLbl.font = UIFont.boldSystemFont(ofSize: 14.0)
        takeawayLbl.textColor = UIColor.gray
        approxLbl.font = UIFont.boldSystemFont(ofSize: 16.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Nib Register
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
