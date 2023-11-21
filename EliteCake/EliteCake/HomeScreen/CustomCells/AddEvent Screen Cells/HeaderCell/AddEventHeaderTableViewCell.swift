//
//  AddEventHeaderTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 08/06/23.
//

import UIKit

class AddEventHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var addCoinLbl: UILabel!
    
    var context: UIViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        titleLbl.text = "Add Events"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)

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
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        context.navigationController?.popViewController(animated: true)
    }
    
}
