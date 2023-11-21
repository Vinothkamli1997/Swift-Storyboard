//
//  AddressBookViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/03/23.
//

import UIKit

class AddressBookViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var addressImageLogo: UIImageView!
    @IBOutlet weak var addressContentLbl: UILabel!
    @IBOutlet weak var addAddressBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = "My Address"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        addressImageLogo.image = UIImage(named: "Adddressbook")
        
        addressContentLbl.text = "Save Address to make delivery more conveninent"
        addressContentLbl.font = UIFont.systemFont(ofSize: 14)
        
        addAddressBtn.setTitle("Add Address", for: .normal)
        addAddressBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addAddressBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }
    
    @IBAction func addAddressBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MapViewViewController") as! MapViewViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
