//
//  OrderStatusCollectionViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/05/23.
//

import UIKit

class OrderStatusCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var statusBgView: UIView!
    
    @IBOutlet weak var orderStatusLbl: UILabel!
    
    @IBOutlet weak var statusIconBtn: UIButton!
    
    @IBOutlet weak var horizontalView: UIView!
    
    @IBOutlet weak var horizontalLeftView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        orderStatusLbl.font = UIFont.boldSystemFont(ofSize: 8)
        statusBgView.backgroundColor = UIColor.lightGray
        statusBgView.layer.cornerRadius = 20
        setShadow(view: statusBgView)
        
        statusIconBtn.tintColor = UIColor.black
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
