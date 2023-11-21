//
//  EmailVeificationViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 21/03/23.
//

import UIKit
import OTPFieldView


class EmailVeificationViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var otpBgView: UIView!
    @IBOutlet weak var resentLbl: UILabel!
    @IBOutlet weak var resentBtn: UIButton!

    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var emailOtpFieldView: OTPFieldView!

    var enterdOTP: String = ""
    var customerID: String = ""
    var email_id: String = ""
    var phoneNumber: String = ""
    var customerName: String = ""
    var customerEmail: String = ""
    var customerAddress: String = ""
    var screenType: String = ""
    var cartScreenType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileApi()
        
        titleLbl.text = "Email Verification"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.textColor = UIColor.black
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        implementOtpView()
        
        contentLbl.text = "Enter Your OTP code Here"
        contentLbl.textColor = UIColor.gray
        contentLbl.font = UIFont.systemFont(ofSize: 16)
        
        otpBgView.layer.cornerRadius = 20
        otpBgView.backgroundColor = UIColor(named: "DarkMode")
        setShadow(view: otpBgView)
        
        resentLbl.text = "Didn't you received any code?"
        resentLbl.textColor = UIColor.gray
        resentLbl.font = UIFont.systemFont(ofSize: 14)
        
        resentBtn.setTitle("Resent", for: .normal)
        resentBtn.tintColor = UIColor.white
        resentBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PREMIUMCOLOR)
        resentBtn.cornerRadius = 10
        
        confirmBtn.setTitle("CONFIRM", for: .normal)
        confirmBtn.tintColor = UIColor.white
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirmBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        confirmBtn.layer.cornerRadius = 10
        setShadow(view: confirmBtn)
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        if isValid() {
            emailVerifyApi()
        }
    }
    
    @IBAction func resendBtnAction(_ sender: UIButton) {
        resendApi()
    }
    
    func isValid() -> Bool {
        if enterdOTP.count != 4 {
            showSimpleAlert(view: self, message: "", title: "Enter 4-Digit")
            return false
        }
        return true
    }
    
    func implementOtpView() {
        self.emailOtpFieldView.fieldsCount = 4
        self.emailOtpFieldView.fieldBorderWidth = 1
        self.emailOtpFieldView.filledBorderColor = UIColor.darkGray
        self.emailOtpFieldView.defaultBorderColor = UIColor.darkGray
        self.emailOtpFieldView.cursorColor = UIColor.gray
        self.emailOtpFieldView.displayType = .underlinedBottom
        self.emailOtpFieldView.fieldSize = 50
        self.emailOtpFieldView.separatorSpace = 15
        self.emailOtpFieldView.shouldAllowIntermediateEditing = false
        self.emailOtpFieldView.initializeUI()
        self.emailOtpFieldView.delegate = self
        setShadow(view: confirmBtn)
    }
    
    func emailVerifyApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + email_id)
        let url = URL(string: ApiConstant.EMAIL_VERIFY_API)
        
        let parameters: [String: Any] = [
            "customer_details_id": customerID,
            "otp": enterdOTP,
            "merchant_id": MobileRegisterConstant.merchant_id_value,
            "auth_token": hash,
            "username": email_id
        ] as [String : Any]
        
        print("VerifyEmail params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EmailVerifyResponse.self, from: data)
                    print("VerifyEmail Response \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.profileEditApi()
                        } else {
                            DispatchQueue.main.async {
                                showAlert(message: "\(response.message)")
                            }
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("VerifyEmail error res \(error)")
                }
            }
        }
    }
    
    func profileApi() {
        
        print("verifprof cart \(cartScreenType)")

        self.showLoader()
        
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
                    
                    if let mobileNumber = response.parameters.customerMobile {
                        self.phoneNumber = mobileNumber
                    } else {
                        self.phoneNumber = ""
                    }

                    self.customerEmail = self.email_id

                    if let customerName = response.parameters.customerName {
                        self.customerName = customerName
                    } else {
                        self.customerName = ""
                    }

                    if let customerAddress = response.parameters.customerAddress {
                        self.customerAddress = customerAddress
                    } else {
                        self.customerAddress = ""
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("profile error res \(error)")
                }
            }
        }
    }
    
    func profileEditApi() {
        
        
        if let cartScreen = UserDefaults.standard.string(forKey: "CartScreen") {
            print("Cart Screen: \(cartScreen)")
            self.screenType = cartScreen
        }

        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.PROFILE_EDIT_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "customer_address" : "",
            "customer_mobile" : self.phoneNumber,
            "date_of_birth" : "",
            "customer_email" : email_id,
            "is_mobile_edit" : "0",
            "customer_name" : self.customerName
        ] as [String : Any]
        
        print("profileEdit params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ProfileEditResponse.self, from: data)
                    print("profileEdit Response \(response)")
                    
                    if response.success {
                        DispatchQueue.main.async {
                            
                            if self.screenType == "Cart" {
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                vc.cartScreen = self.screenType
                                print("cart screen \(self.cartScreenType)")
                                print("cart screen vc \(vc.cartScreen)")
                                UserDefaults.standard.removeObject(forKey: "CartScreen")
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else if self.screenType != "updateMobileNum" {
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                print("cart csre")
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else if self.screenType != "EmailChange" {
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "ChangeMobileNumberViewController") as! ChangeMobileNumberViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else {
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                vc.cartScreen = self.cartScreenType
                                print("change verify cart \(self.cartScreenType)")
                                self.navigationController?.pushViewController(vc, animated: true)
                            } 
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("profileEdit error res \(error)")
                }
            }
        }
    }
    
    func resendApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + email_id)
        let url = URL(string: ApiConstant.ADD_EMAIL_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_details_id": customerID,
            "username" : email_id
        ] as [String : Any]
        
        print("AddEmail params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddEmailResponse.self, from: data)
                    print("AddEmail Response \(response)")
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("AddEmail error res \(error)")
                }
            }
        }
    }
}

extension EmailVeificationViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        enterdOTP = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return false
    }
}
