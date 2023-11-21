//
//  SelectDateTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 10/07/23.
//

import UIKit

class SelectDateTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var selectDateBgView: UIView!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var selectDateView: UIView!
    
//    @IBOutlet weak var todayLbl: UIButton!
    @IBOutlet weak var selectDateLbl: UIButton!
    @IBOutlet weak var todayDateLbl: UIButton!


    
    var context: UIViewController!
    var cartDetails: [Cart] = []
    var selectedType: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        titleLbl.text = "Select Date"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
//        todayView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
//        todayLbl.tintColor = .white
        
        todayView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        todayView.layer.borderWidth = 1
        
        selectDateView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        selectDateView.layer.borderWidth = 1
        
        selectDateLbl.setTitle("Select Date", for: .normal)
        selectDateLbl.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        todayDateLbl.titleLabel?.font = UIFont.systemFont(ofSize: 14)

//        selectDateLbl.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
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
    
//    @IBAction func todayBtnAction(_ sender: UIButton) {
//        todayView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
//        todayLbl.tintColor = .white
//
//        selectDateView.backgroundColor = .clear
//        selectDateLbl.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
//    }
}
