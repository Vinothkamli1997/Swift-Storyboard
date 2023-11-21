//
//  CartDiscartViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 08/09/23.
//

import UIKit

class CartDiscartPopUpViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var popupBgView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        popupBgView.backgroundColor = UIColor.white
        popupBgView.cornerRadius = 5
        
        contentLbl.text = "Are you sure you want to discard the cart ?"
        contentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        contentLbl.textColor = .black
        
        logoutBtn.setTitle("DISCARD", for: .normal)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        logoutBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        cancelBtn.setTitle("CANCEL", for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        cancelBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)

    }
    
    @IBAction func okBtnAction(_ sender: UISwitch) {
        NotificationCenter.default.post(name: Notification.Name("OkButtonPressed"), object: nil)
    }
    
    @IBAction func cancelBtnAction(_ sender: UISwitch) {
        self.dismiss(animated: true, completion: nil)
    }
}
