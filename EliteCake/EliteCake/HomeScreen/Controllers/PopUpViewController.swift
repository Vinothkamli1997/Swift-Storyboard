//
//  PopUpViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 07/03/23.
//

import UIKit

protocol PopUpDelegate: AnyObject {
    func closeBtnTapped(_ alert: PopUpViewController, alertTag: Int)
    func recommendBtnTapped(_ alert: PopUpViewController, sortName: String)
}

class PopUpViewController: UIViewController {
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var recommentedLbl: UILabel!
    @IBOutlet weak var newLbl: UILabel!
    @IBOutlet weak var lowtoHighLbl: UILabel!
    @IBOutlet weak var hightoLowLbl: UILabel!
    
    @IBOutlet weak var recommendBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    @IBOutlet weak var lowPriceBtn: UIButton!
    @IBOutlet weak var highPriceBtn: UIButton!
    
    
    weak var delegate: PopUpDelegate?
    var alertTag = 0
    var sortName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.closeBtnTapped(self, alertTag: alertTag)
    }
    
    @IBAction func recommendBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        recommendBtn.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        recommendBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        sortName = "recommended"
        delegate?.recommendBtnTapped(self, sortName: sortName)
    }
    
    @IBAction func newBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        newBtn.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        newBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        sortName = "new"
        delegate?.recommendBtnTapped(self, sortName: sortName)
        
    }
    
    @IBAction func lowtoHignBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        lowPriceBtn.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        lowPriceBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        sortName = "low"
        delegate?.recommendBtnTapped(self, sortName: sortName)
    }
    
    @IBAction func highToLowBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        highPriceBtn.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        highPriceBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        sortName = "high"
        delegate?.recommendBtnTapped(self, sortName: sortName)
    }
    
    func setUp() {
        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        titleView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        titleLbl.textColor = UIColor.white
        
        closeBtn.tintColor = UIColor.white
        
        recommentedLbl.text = "Recommended"
        recommentedLbl.textColor = .black
        
        newLbl.text = "New"
        newLbl.textColor = .black

        lowtoHighLbl.text = "Price: Low to High"
        lowtoHighLbl.textColor = .black

        hightoLowLbl.text = "Price: High to Low"
        hightoLowLbl.textColor = .black

        recommendBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        recommendBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        newBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        newBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        lowPriceBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        lowPriceBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        highPriceBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        highPriceBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        alertView.backgroundColor = UIColor.white
        setShadow(view: alertView)
        alertView.layer.cornerRadius = 20
        
        titleView.roundCorners(corners: [.topRight,.topLeft], radius: 20)
        
        recommendBtn.tintColor = UIColor.gray
        newBtn.tintColor = UIColor.gray
        lowPriceBtn.tintColor = UIColor.gray
        highPriceBtn.tintColor = UIColor.gray
    }
    
}
