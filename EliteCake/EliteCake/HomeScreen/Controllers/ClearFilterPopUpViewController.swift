//
//  ClearFilterPopUpViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 12/10/23.
//

import UIKit

protocol clearFilterDelegate: AnyObject {
    func clearAllFilter()
}

class ClearFilterPopUpViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var popupBgView: UIView!
    
    var context: UIViewController!
    weak var clearDelegate: clearFilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        popupBgView.backgroundColor = UIColor.white
        popupBgView.cornerRadius = 5
        
        contentLbl.text = "Are you sure want to clear all filters?"
        contentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        contentLbl.textColor = .black
        
        logoutBtn.setTitle("CLEAR", for: .normal)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        logoutBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        cancelBtn.setTitle("CANCEL", for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        cancelBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }
    
    @IBAction func okBtnAction(_ sender: UISwitch) {
        clearDelegate?.clearAllFilter()
    }
    
    @IBAction func cancelBtnAction(_ sender: UISwitch) {
        self.dismiss(animated: true, completion: nil)
    }
}
