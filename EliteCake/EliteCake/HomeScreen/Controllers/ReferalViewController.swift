//
//  RefferalViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class ReferalViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var referralCodeLbl: UILabel!
    @IBOutlet weak var referralLbl: UILabel!
    @IBOutlet weak var referralContentLbl: UILabel!
    
    @IBOutlet weak var refferalImage: UIImageView!
    
    @IBOutlet weak var referralcodeView: UIView!
    @IBOutlet weak var codeTextField: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    
    var customerID: String = ""
    var referralCode: String = ""
    var referralDetails: ReferralParameters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        referralApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareBtnAction(_ sender: UIButton) {
        
        let referralCode = self.referralCode
        let appStoreURLString = "https://play.google.com/store/apps/details?id=com.tt.yumbox.elitecake"

        guard let encodedAppStoreURLString = appStoreURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        let textToShare = "Hi, \n I am using an amazing App to order cakes. Get your first cake at Just Rs.99 by applying Welcome coupon code. Download App for iOS \(encodedAppStoreURLString) Use my Referal Code \(referralCode) in Wallet > Special Welcome Bonus to claim 200 Super Coins. Get 10% extra discount by using these super coin on every order."

        let itemsToShare: [Any] = [textToShare]
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
        }

        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }

    
    func referralApi() {
        self.showLoader()
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.REFERRAL_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID
        ] as [String : Any]
        
        print("Referral params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(ReferralScreenResponse.self, from: data)
                    print("Referral Response \(response)")
                                        
                    DispatchQueue.main.async {
                        self.referralCode = response.parameters.referalCode
                        self.referralCodeLbl.text = response.parameters.referalCode
                        self.codeTextField.text = response.parameters.referalCode
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Referral error res \(error)")
                }
            }
        }
    }
    
    func profileApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.PROFILE_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID
        ] as [String : Any]
        
        print("profile params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ProfileResponse.self, from: data)
                    print("profile Response \(response)")
                                        
                    DispatchQueue.main.async {
                        self.referralCodeLbl.text = response.parameters.referalCode
                        self.codeTextField.text = response.parameters.referalCode
                    }
                } catch {
                    print("profile error res \(error)")
                }
            }
        }
    }
    
    func setUp() {
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        titleLbl.text = "Refer And Earn"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        referralLbl.text = "Your Referral ID :"
        referralLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        referralCodeLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        referralContentLbl.text = "Refer your friends to get 100 coins. Your friend will get 200 coins by adding your Referral ID under Special Welcome Bonus. You will also get 10 coins for every successful order placed by user under your ID"
        
        referralContentLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        referralcodeView.backgroundColor = .white
        referralcodeView.layer.cornerRadius = 10
        
        codeTextField.font = UIFont.boldSystemFont(ofSize: 14)
        codeTextField.textColor = .black
        setShadow(view: referralcodeView)
        
        shareBtn.setTitle("Share Your ID", for: .normal)
        shareBtn.backgroundColor = UIColor.systemPink
        shareBtn.layer.cornerRadius = 10
        shareBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        shareBtn.tintColor = .white
        
        setShadow(view: shareBtn)
        
        refferalImage.image = UIImage(named: "code")
        
        headerImage.image = UIImage(named: "Refer")
    }
}
