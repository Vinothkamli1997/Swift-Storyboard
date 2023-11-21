//
//  GetDirectionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 20/04/23.
//

import UIKit

class GetDirectionTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationBtn: UIButton!
    
    var lat: String = ""
    var lang: String = ""
    var outletDetail: OutletDetails?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = UIColor(hexFromString: ColorConstant.ADDITEMPINK)
        bgView.layer.cornerRadius = 5

        contentLbl.text = "You will need to pickup this order from"
        contentLbl.font = UIFont.systemFont(ofSize: 14)
        contentLbl.textColor = UIColor.lightGray
        
        addressLbl.font = UIFont.systemFont(ofSize: 14)
        addressLbl.textColor = UIColor.lightGray
        
        locationImage.image = UIImage(named: "location")
        
        locationBtn.setTitle("Get Direction", for: .normal)
        locationBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        locationBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
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
    
    @IBAction func locationBtnTapped(_ sender: UIButton) {
        if let outletDetail = self.outletDetail {
            if let latitude = Double(outletDetail.latitude!), let longitude = Double(outletDetail.longitude!) {
                print("lat \(latitude), lang \(longitude)")
                let coordinates = "\(latitude),\(longitude)"
                let encodedCoordinates = coordinates.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

                if let url = URL(string: "http://maps.apple.com/?daddr=\(encodedCoordinates)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                print("Outlet latitude or longitude is nil.")
            }
        } else {
            print("Outlet detail is nil.")
        }
    }
}
