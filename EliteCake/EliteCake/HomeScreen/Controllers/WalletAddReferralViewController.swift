//
//  WalletAddReferralViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/06/23.
//

import UIKit

protocol addReferralCloseDelegate: AnyObject {
    func closeBtnTapped(_ alert: WalletAddReferralViewController, alertTag: Int)
}

class WalletAddReferralViewController: UIViewController, addReferralCloseDelegate, ReferralRewardPopUpDelegate, UITextFieldDelegate {
    
    func closeBtnTapped(_ alert: ReferralRewardPopUpViewController, alertTag: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func closeBtnTapped(_ alert: WalletAddReferralViewController, alertTag: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mainBgView: UIView!
    
    @IBOutlet weak var referralBgView: UIView!
        
    @IBOutlet weak var closeBtn: UIButton!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var addReferralView: UIView!
    
    @IBOutlet weak var addReferralField: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var centerView: UIView!

    @IBOutlet weak var cancelBtn: UIButton!
    
    weak var delegate: addReferralCloseDelegate?
    var alertTag = 0
    var customerID: String = ""
    var oID: String = ""
    var outletId: String = ""
    var refreshWallet: String = ""
    
    var originalContentViewY: CGFloat = 0.0
    let minimumReferralBgViewHeight: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()

        mainBgView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        addReferralField.delegate = self
        
        addReferralField.returnKeyType = .done
        addReferralField.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
                
        titleLbl.text = "Add Referral Id"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        imageView.image = UIImage(named: "referal_earn")
        
        closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeBtn.tintColor = UIColor.black
        
        referralBgView.backgroundColor = UIColor.white
        referralBgView.cornerRadius = 20
        setShadow(view: referralBgView)
        
        addReferralView.layer.borderColor = UIColor.blue.cgColor
        addReferralView.layer.borderWidth = 2
        addReferralView.layer.cornerRadius = 5
        setShadow(view: addReferralView)
        
        addReferralField.borderStyle = .none
        addReferralField.backgroundColor = .clear
        
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        submitBtn.tintColor = UIColor.black
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.tintColor = UIColor.black
        
        centerView.backgroundColor = UIColor.lightGray
    }

    @IBAction func submitBtnAction(_ sender: UIButton) {
        applyReferralApi()
    }

    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.closeBtnTapped(self, alertTag: alertTag)
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.closeBtnTapped(self, alertTag: alertTag)
    }
    
    func applyReferralApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.APPLY_REFERRAL_CODE)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "referal_code" : addReferralField.text!
        ] as [String : Any]
        
        print("appplyReferral params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ApplyReferralResponse.self, from: data)
                    print("appplyReferral Response \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.dismiss(animated: true, completion: nil)
                            self.delegate?.closeBtnTapped(self, alertTag: self.alertTag)
                            
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ReferralRewardPopUpViewController") as! ReferralRewardPopUpViewController
                            vc.delegate = self
                            vc.showmessage = response.message
                            vc.modalPresentationStyle = .overCurrentContext
                            
                            if let presentingViewController = self.presentingViewController {
                                presentingViewController.dismiss(animated: true) {
                                    presentingViewController.present(vc, animated: false, completion: nil)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        NotificationCenter.default.post(name: .walletScreenUpdate, object: nil, userInfo: ["wallet": self.refreshWallet])
                                        vc.dismiss(animated: true, completion: nil)
                                    }
                                }
                            }
                        } else {
//                            self.showToast(message: response.message)
                            
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "EmptyPopupViewController") as! EmptyPopupViewController
                            
                            vc.message = response.message
                            
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                            
                            let dismissalTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                vc.dismiss(animated: true, completion: nil)
                            }

                        }
                    }


                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("appplyReferral error res \(error)")
                }
            }
        }
    }
    
    @objc func doneButtonPressed() {
         view.endEditing(true) // Hide the keyboard
    }
}
