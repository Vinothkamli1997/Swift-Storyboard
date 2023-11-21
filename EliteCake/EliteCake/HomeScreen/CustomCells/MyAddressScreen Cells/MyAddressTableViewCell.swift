//
//  MyAddressTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 19/04/23.
//

import UIKit

class MyAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var addressTypeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var mapBtnView: UIView!
    @IBOutlet weak var mapBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 15
        setShadow(view: bgView)
        
        mapBtnView.backgroundColor = UIColor.white
        mapBtnView.layer.cornerRadius = 15
        setLightShadow(view: mapBtnView)
        
        mapBtn.tintColor = UIColor.gray
        
        deleteBtn.setImage(UIImage(named: "option"), for: .normal)
        deleteBtn.tintColor = UIColor.lightGray
        
        addressTypeLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        addressLbl.font = UIFont.systemFont(ofSize: 14)
        addressLbl.textColor = UIColor.gray
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
