//
//  TrackOrderHeaderCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 28/08/23.
//

import UIKit

class TrackOrderHeaderCell: UITableViewCell {
        
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var deliveryStatusLbl: UILabel!
    
    @IBOutlet weak var trackOrderBtn: UIButton!
    
    @IBOutlet weak var yourOrderLbl: UILabel!

    @IBOutlet weak var bottomView: UIView!

    var context: UIViewController?
    var order_id: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLbl.text = "Order Summary"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        yourOrderLbl.text = "Your Order"
        yourOrderLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        trackOrderBtn.layer.borderWidth = 1
        trackOrderBtn.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        trackOrderBtn.setTitle("TRACK ORDER", for: .normal)
        trackOrderBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        trackOrderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        trackOrderBtn.layer.cornerRadius = 10
        
        deliveryStatusLbl.font = UIFont.boldSystemFont(ofSize: 12)
        deliveryStatusLbl.textColor = .black
        
        bottomView.backgroundColor = UIColor.gray
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
    
    @IBAction func backBtnAction(_ sender: Any) {
        context?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func orderTrackBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrderSummaryViewController") as! OrderSummaryViewController
        vc.order_id = self.order_id
        context?.navigationController?.pushViewController(vc, animated: true)
    }
}
