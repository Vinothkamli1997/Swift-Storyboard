//
//  WelcomeCoinTablecell.swift
//  EliteCake
//
//  Created by apple on 11/01/23.
//

import UIKit

class WelcomeCoinTablecell: UITableViewCell {

    @IBOutlet var welcomeBgView: UIView!
    @IBOutlet var welcomeLbl: UILabel!
    @IBOutlet var welcomeImg: UIImageView!
    @IBOutlet var welcomeCoinsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        welcomeLbl.text = HomeConstant.welcome
        welcomeLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        welcomeCoinsLbl.text = HomeConstant.superCoins
        welcomeCoinsLbl.font = UIFont.boldSystemFont(ofSize: 14)
        welcomeCoinsLbl.textColor = UIColor.lightGray
        
        setLightShadow(view: welcomeBgView)
        
        welcomeImg.image = UIImage(named: "dollar")
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
