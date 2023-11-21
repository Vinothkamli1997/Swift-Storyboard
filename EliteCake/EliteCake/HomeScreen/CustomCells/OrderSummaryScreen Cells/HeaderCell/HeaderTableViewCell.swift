//
//  HeaderTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 04/05/23.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var arrivalView: UIView!
    
    @IBOutlet weak var onTimeLbl: UILabel!
    
    @IBOutlet weak var timingLbl: UILabel!
    
    var context: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        titleLbl.text = "Picked"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.textColor = UIColor.white
        
        arrivalView.backgroundColor = UIColor.systemPink
        arrivalView.cornerRadius = 10
        
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
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
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        context?.navigationController?.popViewController(animated: true)
    }
}
