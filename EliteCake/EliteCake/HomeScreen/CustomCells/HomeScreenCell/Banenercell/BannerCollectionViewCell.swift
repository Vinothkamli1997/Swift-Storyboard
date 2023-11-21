//
//  BannerCollectionViewCell.swift
//  EliteCake
//
//  Created by apple on 12/01/23.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet var sliderImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: nil)
       }
       
       static var identifier: String {
           return String(describing: self)
       }
}
