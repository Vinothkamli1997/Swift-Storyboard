//
//  NotificationTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 20/03/23.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

//    @IBOutlet weak var notificationTitleLbl: UILabel!
//    @IBOutlet weak var delieveryStatusLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var bottmView: UIView!

    @IBOutlet weak var topView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
            
//        notificationTitleLbl.text = "Notofication"
//        notificationTitleLbl.font = UIFont.boldSystemFont(ofSize: 16)
////
        
//        delieveryStatusLbl.font = UIFont.systemFont(ofSize: 12)
        contentLbl.font = UIFont.systemFont(ofSize: 12)
        dateTimeLbl.font = UIFont.systemFont(ofSize: 12)
        
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
