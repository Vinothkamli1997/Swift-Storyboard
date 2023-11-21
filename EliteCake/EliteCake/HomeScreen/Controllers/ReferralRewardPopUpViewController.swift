//
//  ReferralRewardPopUpViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/06/23.
//

import UIKit
import Lottie

protocol ReferralRewardPopUpDelegate: AnyObject {
    func closeBtnTapped(_ alert: ReferralRewardPopUpViewController, alertTag: Int)
}

class ReferralRewardPopUpViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet var popUpView: UIView!
    
    @IBOutlet weak var animationView: AnimationView!

    @IBOutlet weak var popupLbl: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
        
    @IBOutlet weak var yesBtn: UIButton!
    
    weak var delegate: ReferralRewardPopUpDelegate?
    
    var alertTag = 0
    var showmessage: String = ""
    var customerID: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        popUpView.layer.backgroundColor = UIColor.white.cgColor
        setShadow(view: popUpView)
        popUpView.layer.cornerRadius = 10
        
        
        self.animationView.animation = Animation.named("party-hat")
        self.animationView.loopMode = .playOnce
        
        animationView.play(fromProgress: 0,
                               toProgress: 1,
                           loopMode: LottieLoopMode.loop,
                               completion: { (finished) in
                                if finished {
                                    print("Animation Completed")
                                } else {
                                  print("Animation cancelled")
                                }
            })
                
        popupLbl.text = "Dish not found"
        popupLbl.font = UIFont.boldSystemFont(ofSize: 16)
        popupLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeBtn.tintColor = UIColor.black
        
        yesBtn.setTitle("ok", for: .normal)
        yesBtn.tintColor = .black
        yesBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.tintColor = .black
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        popupLbl.text = showmessage
        popupLbl.textColor = UIColor.black

    }
    
    @IBAction func colseBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.closeBtnTapped(self, alertTag: alertTag)
    }
    
    @IBAction func yesBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.closeBtnTapped(self, alertTag: alertTag)
        earnCoinApi()
    }
    
    @IBAction func noBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.closeBtnTapped(self, alertTag: alertTag)
    }
    
    func earnCoinApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.WALLET_EARN_COIN_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("Wallet earnCoin params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(WalletEarnCoinsResponse.self, from: data)
    
                    self.hideLoader()
                } catch {
                    print("Wallet earnCoin error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
}
