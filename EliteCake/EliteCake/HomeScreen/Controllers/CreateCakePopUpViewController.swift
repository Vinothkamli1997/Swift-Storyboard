//
//  CreateCakePopUpViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 09/11/23.
//

import UIKit

class CreateCakePopUpViewController: UIViewController {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var contentLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        contentView.backgroundColor = UIColor.white
        contentView.cornerRadius = 10
        
        contentLbl.text = "Your Request has been submitted. Soon you will receive a call for conformation"
        
        closeBtn.tintColor = UIColor(named: "GrayColor")
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "CreateCake")

        // Synchronize UserDefaults to persist the changes immediately
        UserDefaults.standard.synchronize()
        
        self.dismiss(animated: true)
    }
}
