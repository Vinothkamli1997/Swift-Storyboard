//
//  TakeAwayDeliveryViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/04/23.
//

import UIKit


protocol TakeAwayDeliveryDelegate: AnyObject {
    func didTapOkButton(type: String)
}

class TakeAwayDeliveryViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var popUpBgView: UIView!

    @IBOutlet weak var orderTypeLbl: UILabel!
    
    @IBOutlet weak var contentLbl1: UILabel!
    @IBOutlet weak var contentLbl2: UILabel!
    @IBOutlet weak var typeLbl: UILabel!

    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    weak var delegate: TakeAwayDeliveryDelegate?

    var type: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        popUpBgView.layer.cornerRadius = 10
        popUpBgView.backgroundColor = UIColor.white
        setShadow(view: popUpBgView)
        
        orderTypeLbl.text = "Order Type"
        orderTypeLbl.font = UIFont.boldSystemFont(ofSize: 14)
        orderTypeLbl.textColor = .black
        
        contentLbl1.text = "Are you sure want to switch to"
        contentLbl1.font = UIFont.systemFont(ofSize: 12)
        contentLbl1.textColor = .black
        
        contentLbl2.text = "Delivery Order Type?"
        contentLbl2.font = UIFont.systemFont(ofSize: 12)
        contentLbl2.textColor = .black
        
        typeLbl.text = self.type
        typeLbl.font = UIFont.boldSystemFont(ofSize: 12)
        typeLbl.textColor = .black
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        cancelBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        cancelBtn.layer.cornerRadius = 10
        
        okBtn.setTitle("Proceed", for: .normal)
        okBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        okBtn.layer.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        okBtn.tintColor = UIColor.white
        okBtn.layer.cornerRadius = 10
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okBtnAction(_ sender: UIButton) {
        delegate?.didTapOkButton(type: type)
        dismiss(animated: true, completion: nil)
    }
}
