//
//  OrderConformationViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/05/23.
//

import UIKit

class OrderConformationViewController: UIViewController {

    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    
//    @IBOutlet weak var trackOrderBtn: UIButton!
    @IBOutlet weak var backToBrowseBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.trackOrderBtn.isHidden = true
        
        firstLbl.text = "Congratulation!"
        firstLbl.font = UIFont.boldSystemFont(ofSize: 18)
        firstLbl.textAlignment = .center
        firstLbl.textAlignment = .center
        
        secondLbl.text = "You have successfully placed your order"
        secondLbl.textColor = UIColor.lightGray
        secondLbl.font = UIFont.boldSystemFont(ofSize: 16)
        secondLbl.textAlignment = .center
    
        headerImage.image = UIImage(named: "CartEmptyImage")
        
        backToBrowseBtn.setTitle("Back To Browsing", for: .normal)
        backToBrowseBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        backToBrowseBtn.layer.borderWidth = 1
        backToBrowseBtn.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        backToBrowseBtn.layer.cornerRadius = 10
    }
    
    @IBAction func backToBrowseBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
