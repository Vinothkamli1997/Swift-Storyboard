//
//  AnniversaryCollectionViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 13/06/23.
//

import UIKit

protocol AnniversaryCollectionCollectionViewCellDelegate: AnyObject {
    func eventImageTapAction(_ alert: AnniversaryCollectionViewCell, alertTag: Int)
}

class AnniversaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomLbl: UILabel!
    
    @IBOutlet weak var checkBtn: UIButton!

    
    weak var delegate: AnniversaryCollectionCollectionViewCellDelegate?
    var alertTag: Int = 0
    
    var context: UIViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.tintColor = UIColor.lightGray
        bottomLbl.font = UIFont.systemFont(ofSize: 12)
        
        checkBtn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        checkBtn.tintColor = UIColor.gray
        checkBtn.isUserInteractionEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @objc private func imageViewTapped() {
//        checkBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        delegate?.eventImageTapAction(self, alertTag: alertTag)
    }
}
