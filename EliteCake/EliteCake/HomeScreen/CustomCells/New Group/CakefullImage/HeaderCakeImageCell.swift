//
//  HeaderCakeImageCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 30/01/23.
//

import UIKit

class HeaderCakeImageCell: UICollectionViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    var context: UIViewController!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backBtn.tintColor = UIColor.black
        self.backBtn.isHidden = true
        
        setShadow(view: bgImage)
    }
    
//    @IBAction func backBtnAction(_ sender: Any) {
//        context.navigationController?.popViewController(animated: true)
//    }
//    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
