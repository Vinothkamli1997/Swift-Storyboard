//
//  FilterPopupViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 30/03/23.
//

import UIKit


protocol FilterPopUpDelegate: AnyObject {
    func closeBtnTapped(_ alert: FilterPopupViewController, alertTag: Int)
}

protocol ClearButtonDelegate: AnyObject {
    func clearButtonTapped()
}

class FilterPopupViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet var popUpViewView: UIView!
    
    
    @IBOutlet weak var popUPimage: UIImageView!
    @IBOutlet weak var popupLbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var contentLbl2: UILabel!
    @IBOutlet weak var clearBtn: UIButton!

    
    weak var delegate: FilterPopUpDelegate?
    weak var clearButtonDelegate: ClearButtonDelegate?
    var alertTag = 0
    var context: UIViewController!
    
    var screenType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        popUpViewView.layer.backgroundColor = UIColor.white.cgColor
        setShadow(view: popUpViewView)
        popUpViewView.layer.cornerRadius = 10
        
        popUPimage.image = UIImage(named: "PopEmoji")
        
        popupLbl.text = "Dish not found"
        popupLbl.font = UIFont.boldSystemFont(ofSize: 16)
        popupLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                
        closeBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        
        contentLbl2.text = "Try after removing the filters"
        contentLbl2.font = UIFont.systemFont(ofSize: 14)
        contentLbl2.textColor = UIColor.gray
        
//        clearBtn.backgroundColor = UIColor.blue
        clearBtn.setTitle("Clear Filter", for: .normal)
        clearBtn.tintColor = UIColor.white
        clearBtn.cornerRadius = 10
    }
    
    @IBAction func colseBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.closeBtnTapped(self, alertTag: alertTag)
    }
    
    @IBAction func clearBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setPopLblValue() {
        if screenType == "Cusine" {
            popupLbl.text = "Sorry, we are a vegetarian restaurant"
        } else {
            popupLbl.text = "Dish not found"
        }
    }
}
