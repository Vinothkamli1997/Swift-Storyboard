//
//  OnboardingNewCollectionViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 11/09/23.
//

import UIKit

class OnboardingNewCollectionViewCell: UICollectionViewCell {
    
    static let idendifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        func setup(_ slide: OnboardingSlide) {
            slideImageView.image = slide.image
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
