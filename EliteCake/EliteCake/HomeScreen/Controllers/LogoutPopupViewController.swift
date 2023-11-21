//
//  LogoutPopupViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 06/06/23.
//

import UIKit
import GoogleSignIn


class LogoutPopupViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var popupBgView: UIView!

    var loginScreen: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    var context: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        popupBgView.backgroundColor = UIColor.white
        popupBgView.cornerRadius = 5
        
        contentLbl.text = "Are you sure want to log out?"
        contentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        contentLbl.textColor = .black
        
        logoutBtn.setTitle("LOG OUT", for: .normal)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        logoutBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        cancelBtn.setTitle("CANCEL", for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        cancelBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }
    
    @IBAction func okBtnAction(_ sender: UISwitch) {
        UserDefaults.standard.removeObject(forKey: LoginConstant.customer_id)
        UserDefaults.standard.set(userDefaultConstant.FALSE, forKey: userDefaultConstant.loggedIn)

        UserDefaults.standard.synchronize()

        let vc = loginScreen.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cancelBtnAction(_ sender: UISwitch) {
        self.dismiss(animated: true, completion: nil)
    }
}
