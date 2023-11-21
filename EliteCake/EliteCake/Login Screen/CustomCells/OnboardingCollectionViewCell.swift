//
//  OnboardingCollectionViewCell.swift
//  EliteCakes
//
//  Created by TechnoTackleMac on 03/01/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let idendifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
//    @IBOutlet weak var slideTitleLabel: UILabel!
//    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        
//        slideTitleLabel.text = slide.title
//        slideTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        slideTitleLabel.textColor = UIColor(named: "TextDarkMode")
//        
//        slideDescriptionLabel.text = slide.description
//        slideDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
//        slideDescriptionLabel.textColor = UIColor(named: "TextDarkMode")
    }
}
