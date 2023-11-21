//
//  TrackOrderHeaderTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/05/23.
//

import UIKit

class TrackOrderHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var supportBtn: UIButton!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var eliteLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var yourOrderLbl: UILabel!
    
    @IBOutlet weak var orderStatusLbl: UILabel!
    
    @IBOutlet weak var trackOrderBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    var context: UIViewController?
    var order_id: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        supportBtn.isHidden = true
        
        addressLbl.isHidden = true
        cityLbl.isHidden = true
        trackOrderBtn.isHidden = true
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")

        supportBtn.setTitle("Support", for: .normal)
        supportBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        supportBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        titleLbl.text = "Order Summary"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        eliteLbl.text = "Elite Cakes"
        eliteLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        addressLbl.font = UIFont.boldSystemFont(ofSize: 12)
        addressLbl.textColor = UIColor.gray
        
        cityLbl.font = UIFont.boldSystemFont(ofSize: 12)
        cityLbl.textColor = UIColor.gray
        
        orderStatusLbl.text = "Waiting"
        orderStatusLbl.font = UIFont.boldSystemFont(ofSize: 12)

        yourOrderLbl.text = "Your Order"
        yourOrderLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        trackOrderBtn.layer.borderWidth = 1
        trackOrderBtn.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        trackOrderBtn.setTitle("TRACK ORDER", for: .normal)
        trackOrderBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        trackOrderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        trackOrderBtn.layer.cornerRadius = 10
        
        bottomView.backgroundColor = UIColor.gray
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
    
    
//    @IBAction func backBtnAction(_ sender: Any) {
//        delegate?.didGoBack(value: true)
//        
//        // Pop the current view controller
//        context?.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func supportBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func orderTrackBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrderSummaryViewController") as! OrderSummaryViewController
        vc.order_id = self.order_id
        context?.navigationController?.pushViewController(vc, animated: true)        
    }
}
