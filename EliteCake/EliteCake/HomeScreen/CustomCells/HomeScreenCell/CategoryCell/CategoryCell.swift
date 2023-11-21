//
//  CategoryCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 25/01/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cakeImg: UIImageView!
    @IBOutlet weak var cakeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cakeName.font = UIFont.boldSystemFont(ofSize: 16)
        cakeName.textColor = UIColor(named: "TextDarkMode")
    }
    
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
