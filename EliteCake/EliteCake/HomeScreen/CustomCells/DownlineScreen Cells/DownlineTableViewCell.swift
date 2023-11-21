//
//  DownlineTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 29/07/23.
//

import UIKit

class DownlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var trailingView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var leadingImage: UIImageView!
    @IBOutlet weak var trailingImage: UIImageView!
    @IBOutlet weak var trailingImageBgView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dojValueLbl: UILabel!
    @IBOutlet weak var coinLbl: UILabel!
    @IBOutlet weak var coinValueLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setShadow(view: bgView)
        
        nameLbl.font = UIFont.boldSystemFont(ofSize: 18)
        nameLbl.textAlignment = .center
        
        dojValueLbl.textColor = UIColor.gray
        
        setShadow(view: trailingImageBgView)
        
        setShadow(view: leadingImage)
        
        coinLbl.textColor = UIColor.gray
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
