//
//  EmptyPopupViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 11/08/23.
//

import UIKit

class EmptyPopupViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var popupBgView: UIView!
    @IBOutlet weak var popupImage: UIImageView!

    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var message: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        popupBgView.backgroundColor = .white
        popupBgView.layer.cornerRadius = 20
        setShadow(view: popupBgView)
        
        textLbl.text = "Sorry!"
        
        contentLbl.text = message
        contentLbl.font = UIFont.systemFont(ofSize: 14)
        
        popupImage.image = UIImage(named: "close")
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.tintColor = .white
        cancelBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        cancelBtn.layer.cornerRadius = 10
        setLightShadow(view: cancelBtn)
        
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
