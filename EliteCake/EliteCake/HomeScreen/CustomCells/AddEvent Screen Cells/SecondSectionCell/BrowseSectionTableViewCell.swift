//
//  BrowseSectionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 08/06/23.
//

import UIKit

protocol BrowseSectionTableViewCellDelegate: AnyObject {
    func showImagePicker()
}

class BrowseSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headingLbl: UILabel!

    @IBOutlet weak var addPhotoView: UIView!

    @IBOutlet weak var addImage: UIImageView!
    
    @IBOutlet weak var cameraBtn: UIButton!

    @IBOutlet weak var cameraBtnView: UIView!

    weak var delegate: BrowseSectionTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        headingLbl.text = "Browse Photo :"
        headingLbl.font = UIFont.boldSystemFont(ofSize: 18)
        headingLbl.textColor = UIColor.black
        
        cameraBtnView.backgroundColor = UIColor.white
        cameraBtnView.layer.cornerRadius = 20
        setShadow(view: cameraBtnView)
        
        cameraBtn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        cameraBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        addImage.layer.borderColor = UIColor.gray.cgColor
        addImage.layer.borderWidth = 1
        addImage.layer.cornerRadius = 55
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
    
    @IBAction func cameraBtnAction(_ sender: UIButton) {
        delegate?.showImagePicker()
    }
}
