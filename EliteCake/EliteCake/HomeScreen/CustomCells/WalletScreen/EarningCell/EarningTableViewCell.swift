//
//  EarningTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 17/03/23.
//

import UIKit

class EarningTableViewCell: UITableViewCell, addReferralCloseDelegate {
    
    func closeBtnTapped(_ alert: WalletAddReferralViewController, alertTag: Int) {
        context.dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var EarnimageView: UIImageView!
    
    @IBOutlet weak var earnHeadingLbl: UILabel!
    
    @IBOutlet weak var welcomeBonusLbl: UILabel!
    @IBOutlet weak var coinsLbl: UILabel!
    
    @IBOutlet weak var claimBtn: UIButton!
    
    
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.backgroundColor =  UIColor(named: "ViewDarkMode")
        bgView.layer.cornerRadius = 5
        setShadow(view: bgView)
            
        earnHeadingLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        welcomeBonusLbl.font = UIFont.systemFont(ofSize: 10)
        coinsLbl.font = UIFont.systemFont(ofSize: 10)
        
        claimBtn.backgroundColor = UIColor.white
        claimBtn.layer.cornerRadius = 10
        claimBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        claimBtn.tintColor = UIColor.purple
        setLightShadow(view: claimBtn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
//    @IBAction func claimBtnAction(_ sender: UIButton) {
//
//        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WalletAddReferralViewController") as! WalletAddReferralViewController
//
//        vc.delegate = self
//        vc.modalPresentationStyle = .overCurrentContext
//        context.present(vc, animated: false, completion: nil)
//    }
}


