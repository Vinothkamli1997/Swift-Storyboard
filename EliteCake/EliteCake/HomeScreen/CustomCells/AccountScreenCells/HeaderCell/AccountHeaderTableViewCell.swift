//
//  AccountHeaderTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 14/03/23.
//

import UIKit

class AccountHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var accountHeaderImage: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var phoneNumLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    var accountDetails: AccountParameters?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        accountHeaderImage.layer.cornerRadius = 50
        
        userNameLbl.font = UIFont.boldSystemFont(ofSize: 12)
        userNameLbl.textColor = UIColor(named: "TextDarkMode")
        
        phoneNumLbl.font = UIFont.boldSystemFont(ofSize: 12)
        phoneNumLbl.textColor = UIColor(named: "TextDarkMode")
        
        emailLbl.font = UIFont.boldSystemFont(ofSize: 12)
        emailLbl.textColor = UIColor(named: "TextDarkMode")
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
