//
//  OTPViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 05/01/23.
//

import UIKit
import OTPFieldView

class OTPViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var otpFieldView: OTPFieldView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sentMsgLbl: UILabel!
    @IBOutlet weak var mobileNumLbl: UILabel!
    @IBOutlet weak var resentLbl: UILabel!
    @IBOutlet weak var resentBtn: UIButton!
    
    var enterdOTP: String = ""
    var screenType: String = ""
    var customerID: String = ""
    var gcmToken: String = ""
    var checkNewUser: Int?
    var mobileNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        if (isValid()) {
            if screenType == "addProfile" {
                updateMobileNumberApi()
            } else if screenType == "updateMobileNum" {
                updateMobileNumberApi()
            } else if screenType == "EmailChange" {
                updateMobileNumberApi()
            } else {
                otpApi()
            }
        }
    }
    
    @IBAction func resentBtnAction(_ sender: UIButton) {
        loginApi()
    }
    
    func implementOtpView() {
        self.otpFieldView.fieldsCount = 4
        self.otpFieldView.fieldBorderWidth = 1
        self.otpFieldView.filledBorderColor = UIColor.darkGray
        self.otpFieldView.defaultBorderColor = UIColor.darkGray
        self.otpFieldView.cursorColor = UIColor.gray
        self.otpFieldView.displayType = .square
        self.otpFieldView.fieldSize = 50
        self.otpFieldView.separatorSpace = 15
        self.otpFieldView.shouldAllowIntermediateEditing = false
        self.otpFieldView.initializeUI()
        self.otpFieldView.delegate = self
        setShadow(view: confirmBtn)
    }
    
    
    func isValid() -> Bool {
        if enterdOTP.count != 4 {
            showSimpleAlert(view: self, message: "", title: "Enter 4-Digit")
            return false
        }
        return true
    }
    
    //ApiCall
    func otpApi() {
        //Home Screen VIew Controller
        var homeStoryboard: UIStoryboard {
            return UIStoryboard(name:"HomeScreen", bundle: Bundle.main)
        }
        
        let url = URL(string: ApiConstant.otp)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let hash = md5(string: ApiConstant.salt_key + mobileNumber!)
        
        //Input Json
        let parameters: [String: Any] = [
            MobileRegisterConstant.customer_mobile : mobileNumber!,
            MobileRegisterConstant.otp : enterdOTP,
            MobileRegisterConstant.merchant_id : MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token : hash
        ]
        
        print("OTP param \(parameters)")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // check for errors
            if let error = error {
                print(error)
                return
            }
            
            // check for successful status code
            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                // parse the response
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(OtpResponse.self, from: data)
                        
                        // use the response here
                        print("OTP response \(response)")
                        if response.success {
                            DispatchQueue.main.async { [self] in
                                UserDefaults.standard.set(userDefaultConstant.TRUE, forKey: userDefaultConstant.loggedIn)
                                let vc = homeStoryboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        } else {
                            DispatchQueue.main.async {
                                showSimpleAlert(view: self, message: "", title: response.message)
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
    
    //MobileLogInAPiCall
    func loginApi() {
        showLoader()
        
        if let gcmtoken = UserDefaults.standard.string(forKey: "FCMToken") {
            gcmToken = gcmtoken
        }
        
        let url = URL(string: ApiConstant.register)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.login_with_mobile)
        
        //Input Json
        let parameters: [String: Any] = [
            MobileRegisterConstant.device_os_type_id : MobileRegisterConstant.device_type_value,
            MobileRegisterConstant.gcm_id : gcmToken,
            MobileRegisterConstant.customer_mobile : mobileNumber!,
            MobileRegisterConstant.login_with : MobileRegisterConstant.login_with_mobile,
            MobileRegisterConstant.unique_device_id : MobileRegisterConstant.unique_device_id_value ?? "",
            MobileRegisterConstant.merchant_id : MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token : hash
        ]
        
        print("Otp param \(parameters)")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // check for errors
            if let error = error {
                print(error)
                return
            }
            
            // check for successful status code
            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                // parse the response
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(LoginResponse.self, from: data)
                        
                        // use the response here
                        print("otp response \(response)")
                        if response.success {
                            
                            if let parameters = response.parameters {
                                if let customerDetailsID = parameters.customer_details_id {
                                    let cusDetailID = String(customerDetailsID)
                                    self.userStore(customer_Details_ID: cusDetailID)
                                }
                            }
                        } else{
                            showSimpleAlert(view: self, message: "", title: response.message)
                        }
                        self.hideLoader()
                    } catch {
                        print(error)
                        self.hideLoader()
                    }
                }
            } else {
                print("time out")
                self.hideLoader()
            }
        }
        task.resume()
    }
    
    
    func updateMobileNumberApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        print("mobileNum verify \(mobileNumber!)")
        
        let hash = md5(string: ApiConstant.salt_key + mobileNumber!)
        let url = URL(string: ApiConstant.UPDATE_MOBILE_VERIFY_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_details_id": customerID,
            "updated_mobile" : mobileNumber!,
            "otp" : enterdOTP
        ] as [String : Any]
        
        print("mobileNum verify  params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(MobileNumberUpdateResponse.self, from: data)
                    print("mobileNum verify Response \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            if self.screenType == "addProfile" {
                                self.profileEditApi()
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                                vc.backButton = "backButton"
                                vc.backBtnScreenType = false
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else if self.screenType == "EmailChange" {
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "ChangeEmailViewController") as! ChangeEmailViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else {
                                self.profileEditApi()
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        } else {
                            showAlert(message: response.message)
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("mobileNum Upate error res \(error)")
                }
            }
        }
    }
    
    func profileEditApi() {
        
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
            "customer_mobile" : mobileNumber!,
            "date_of_birth" : "",
            "customer_email" : "",
            "is_mobile_edit" : "1",
            "customer_name" : ""
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(ProfileEditResponse.self, from: data)
                    print("profileEdit Response \(response)")
                    
                    
                    DispatchQueue.main.async {
                        
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("profileEdit error res \(error)")
                }
            }
        }
    }
    
    func userStore(customer_Details_ID: String) {
        UserDefaults.standard.set(customer_Details_ID, forKey: LoginConstant.customer_id)
    }
}

extension OTPViewController {
    
    private func initialLoads() {

        implementOtpView()
        
        navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        //        self.title = OtpConstant.otp_Title
        self.titleLbl.text = OtpConstant.otp_Title
        //        self.titleLbl.textColor = UIColor(hexFromString: ColorConstant.black)
        self.confirmBtn.setTitle(LoginConstant.confirmBtn, for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        sentMsgLbl.text = "We have sent a verification code to"
        sentMsgLbl.font = UIFont.systemFont(ofSize: 14)
        
        mobileNumLbl.text = "+91-" + mobileNumber!
        mobileNumLbl.font = UIFont.boldSystemFont(ofSize: 14)
        mobileNumLbl.textColor = UIColor.lightGray
        
        resentLbl.text = "Didn't you received any code?"
        resentLbl.textColor = UIColor(named: "TextDarkMode")
        resentLbl.font = UIFont.systemFont(ofSize: 14)
        
        resentBtn.setTitle("Resent", for: .normal)
        resentBtn.tintColor = UIColor.white
        resentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        resentBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PREMIUMCOLOR)
        resentBtn.cornerRadius = 10
    }
}

extension OTPViewController: OTPFieldViewDelegate {
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
