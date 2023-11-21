//
//  VideoSectionCollectionViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 10/07/23.
//

import UIKit

class VideoSectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var cakeNameLbl: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet var playBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
//        thumbnailImage.layer.cornerRadius = 20
//        thumbnailImage.layer.masksToBounds = true
//        setShadow(view: thumbnailImage)
        
        setLightShadow(view: thumbnailImage)
        thumbnailImage.layer.cornerRadius = 20
        thumbnailImage.layer.masksToBounds = true
                
        playBtn.tintColor = UIColor.white
        
        cakeNameLbl.font = UIFont.boldSystemFont(ofSize: 20)
        cakeNameLbl.textColor = UIColor.white
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
