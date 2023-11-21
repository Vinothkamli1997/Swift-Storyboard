//
//  NewDownlineTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 01/09/23.
//

import UIKit

class NewDownlineTableViewCell: UITableViewCell {
    
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
    
    @IBOutlet weak var selectLbl: UILabel!
    
    @IBOutlet weak var checkBoxBtn: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        setShadow(view: bgView)
        
        nameLbl.text = "Shallu Kanojia"
        nameLbl.font = UIFont.boldSystemFont(ofSize: 18)
        nameLbl.textColor = .black
        nameLbl.textAlignment = .center
        
        dojValueLbl.text = "DOJ: 23-04-2023"
        dojValueLbl.textColor = UIColor.gray
        dojValueLbl.font = UIFont.systemFont(ofSize: 12)
        
        setShadow(view: trailingImageBgView)
        
        leadingImage.clipsToBounds = true
        leadingImage.layer.cornerRadius = 50
        setShadow(view: leadingImage)

        
        centerView.backgroundColor = .black
        
        coinLbl.textColor = UIColor.gray
        
        selectLbl.text = "Select"
        selectLbl.textColor = .black
        selectLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        checkBoxBtn.tintColor = UIColor.gray
        
        coinLbl.text = "COINS EARNED THROUGH MEMBER"
        
        coinValueLbl.text = "100"
        coinValueLbl.textColor = .black
        coinValueLbl.font = UIFont.boldSystemFont(ofSize: 18)
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

//    @IBAction func checkBoxBtnAction(_ sender: UIButton) {
//        // Toggle the isSelected property
//
//    }
}
