//
//  BannerTableViewCell.swift
//  EliteCake
//
//  Created by apple on 12/01/23.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        bannerCollectionView.register(BannerCollectionViewCell.nib, forCellWithReuseIdentifier: "BannerCollectionViewCell")
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

