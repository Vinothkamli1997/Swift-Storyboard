//
//  TopHomeHeaderTablecell.swift
//  EliteCake
//
//  Created by apple on 11/01/23.
//

import UIKit

class TopHomeHeaderTablecell: UITableViewCell {
    
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        super.init(style: .default, reuseIdentifier: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // custom initialization
    }

    @IBOutlet var forEliteLbl: UILabel!
    @IBOutlet var locationImg: UIImageView!
    @IBOutlet var eliteCakeLbl: UILabel!
    @IBOutlet var profileImg: UIImageView!
    
    @IBOutlet weak var cityOutletStack: UIStackView!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var downArrow: UIImageView!

    var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"MapView", bundle: Bundle.main)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        forEliteLbl.font = UIFont.boldSystemFont(ofSize: 20)
        forEliteLbl.textColor = UIColor(named: "TextDarkMode")
        
        eliteCakeLbl.textColor = UIColor.gray
        eliteCakeLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        locationLbl.font = UIFont.boldSystemFont(ofSize: 12)
        locationLbl.textColor = UIColor.lightGray
        locationLbl.isUserInteractionEnabled = true
        
        setLightShadow(view: profileImg)
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
