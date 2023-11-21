//
//  ForceUpdateViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 28/06/23.
//

import UIKit

class ForceUpdateViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var popUpBgview: UIView!

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var conformbtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        popUpBgview.backgroundColor = .white
        popUpBgview.cornerRadius = 5
        
        titleLbl.text = "Update!"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        contentLbl.text = "Please update your app to the latest version in order to continue using the same. Enjoy the new features of the app with the new upgrade."
        contentLbl.font = UIFont.systemFont(ofSize: 16)
        
        conformbtn.setTitle("UPDATE", for: .normal)
        conformbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        conformbtn.tintColor = UIColor.blue
        
    }
}
