//
//  LoginViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 05/01/23.
//

import UIKit
import CountryPickerView
import CommonCrypto
import GoogleSignIn
import FirebaseMessaging

class LoginViewController: UIViewController, CountryPickerViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        // The user selected a different country
        print("Selected country: \(country)")
    }
    
    @IBOutlet weak var loginBgImg: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var countryBgView: UIView!

    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var contineBtn: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var countryView: CountryPickerView!
    
    //Home Screen VIew Controller
    var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"HomeScreen",bundle: Bundle.main)
    }
    
    var user_id: String = ""
    var email: String = ""
    var fullname: String = ""
    var givenName: String = ""
    var gcmToken: String = ""
    var newUser: Int?
    
    var isFirstTime: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialLoads()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDidSignInGoogle(_:)),
                                               name: .signInGoogleCompleted,
                                               object: nil)
        
        
        // Observe the "FCMToken" notification
        NotificationCenter.default.addObserver(self, selector: #selector(updateFCMToken(_:)), name: Notification.Name("FCMToken"), object: nil)
        
        // Check for FCM token in UserDefaults
        if let fcmToken = UserDefaults.standard.string(forKey: "FCMToken") {
            updateTokenLabel(fcmToken)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func updateFCMToken(_ notification: Notification) {
        if let userInfo = notification.userInfo, let fcmToken = userInfo["token"] as? String {
            updateTokenLabel(fcmToken)
        }
    }

    func updateTokenLabel(_ token: String) {
        DispatchQueue.main.async {
            print("FCM Token: \(token)")
            self.gcmToken = token
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("FCMToken"), object: nil)
    }
    
    // MARK:- Notification
        @objc private func userDidSignInGoogle(_ notification: Notification) {
            
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name("GoogleSignInNotification"), object: nil)
            
            GIDSignIn.sharedInstance()?.presentingViewController = self
                        
            if self.isFirstTime == false {
                googleLoginApi()
            }
        }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        if (isValid()) {
            loginApi()
        }
    }
    
    @IBAction func googleBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func newLoginApi() {
        self.showLoader()
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.login_with_mobile)
        let url = URL(string: ApiConstant.register)
        
        let parameters: [String: Any] = [
            MobileRegisterConstant.device_os_type_id : MobileRegisterConstant.device_type_value,
            MobileRegisterConstant.gcm_id : gcmToken,
            MobileRegisterConstant.customer_mobile : phoneNumberField.text ?? "",
            MobileRegisterConstant.login_with : MobileRegisterConstant.login_with_mobile,
            MobileRegisterConstant.unique_device_id : MobileRegisterConstant.unique_device_id_value ?? "",
            MobileRegisterConstant.merchant_id : MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token : hash
        ] as [String : Any]
        
        print("Login pramas \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(LoginResponse.self, from: data)
                    print("Login Response \(response)")
                    
                    if response.success {
                        if let parameters = response.parameters {
                            if let customerDetailsID = parameters.customer_details_id {
                                let cusDetailID = String(customerDetailsID)
                                
                                self.userStore(customer_Details_ID: cusDetailID)
                            }
                            
                            self.newUser = response.parameters!.is_new_user
                        }

                        DispatchQueue.main.async { [self] in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController

                            if let phoneNumber = self.phoneNumberField.text {
                                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                            }

                            vc.mobileNumber = self.phoneNumberField.text
                            vc.checkNewUser = self.newUser!
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    } else {
                        showSimpleAlert(view: self, message: "Error Res", title: response.message)
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Login error res \(error)")
                }
            }
        }
    }
    
    //MobileLogInAPiCall
    func loginApi() {
        self.showLoader()
        
        if let gcmtoken = UserDefaults.standard.string(forKey: "FCMToken") {
            gcmToken = gcmtoken
        } else if let fcmToken = FirebaseMessaging.Messaging.messaging().fcmToken {
            gcmToken = fcmToken
        } else {

        }
        
        UserDefaults.standard.set(phoneNumberField.text!, forKey: "mobileNumber")
        
        let url = URL(string: ApiConstant.register)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.login_with_mobile)
        
        //Input Json
        let parameters: [String: Any] = [
            MobileRegisterConstant.device_os_type_id : MobileRegisterConstant.device_type_value,
            MobileRegisterConstant.gcm_id : gcmToken,
            MobileRegisterConstant.customer_mobile : phoneNumberField.text ?? "",
            MobileRegisterConstant.login_with : MobileRegisterConstant.login_with_mobile,
            MobileRegisterConstant.unique_device_id : MobileRegisterConstant.unique_device_id_value ?? "",
            MobileRegisterConstant.merchant_id : MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token : hash
        ]
        
        print("login param \(parameters)")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // check for errors
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    showSimpleAlert(view: self, message: "", title: "Network Issue")
                    self.hideLoader()
                }
                return
            }
            
            // check for successful status code
            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                
                print("login response \(response)")
                print("login response status \(response.statusCode)")
                
                // parse the response
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(LoginResponse.self, from: data)
                        
                        // use the response here
                        print("Login response \(response)")
                        if response.success {
                            if let parameters = response.parameters {
                                if let customerDetailsID = parameters.customer_details_id {
                                    let cusDetailID = String(customerDetailsID)
                                    self.userStore(customer_Details_ID: cusDetailID)
                                }
                            }

                            DispatchQueue.main.async { [self] in
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                                
                                if let phoneNumber = self.phoneNumberField.text {
                                    UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                                }
                                vc.mobileNumber = self.phoneNumberField.text
                                
                                UserDefaults.standard.set(response.parameters?.is_new_user, forKey: "userID")
                                                                
                                self.navigationController?.pushViewController(vc, animated: true)
                            }

                        } else {
                            showSimpleAlert(view: self, message: "", title: response.message)
                            self.showToast(message: "Api not success")
                            showSimpleAlert(view: self, message: "", title: "Api not success")
                        }
                        self.hideLoader()
                    } catch {
                        print(error)
                        self.showToast(message: "error")
                        showSimpleAlert(view: self, message: "", title: "respopnse error")
                        self.hideLoader()
                    }
                }
            } else {
                print("time out")
                self.showToast(message: "Api Error")
                showSimpleAlert(view: self, message: "", title: "Api error")
                self.hideLoader()

            }
        }
        task.resume()
    }
    
    //Cake Detail API
    func googleLoginApi() {
        
        if let user_ID = UserDefaults.standard.string(forKey: "USER_ID"){
            print("checkinggggggg userID  \(user_ID)")
            user_id = user_ID
        }
        
        if let emailName = UserDefaults.standard.string(forKey: "EMAIL"){
            print("checkinggggggg email \(emailName)")
            email = emailName
        }
        
        if let fullName = UserDefaults.standard.string(forKey: "FULLNAME"){
            print("checkinggggggg Given Name \(fullName)")
            
            fullname = fullName
        }
        
        if let givenname = UserDefaults.standard.string(forKey: "GIVENNAME"){
            print("checkinggggggg Full Name \(givenname)")
            givenName = givenname
        }
        
        if let gcmtoken = UserDefaults.standard.string(forKey: "FCMToken") {
            gcmToken = gcmtoken
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.login_with_gamil)
        let url = URL(string: ApiConstant.register)!

        //Input Json
        let parameters: [String: Any] = [
            "device_os_type_id": "4",
            "gcm_id": gcmToken,
            "social_id": email,
            "password":"1234",
            "response": fullname + user_id + email + givenName,
            "login_with":"gmail",
            "unique_device_id": MobileRegisterConstant.unique_device_id_value ?? "",
            "customer_name": fullname,
            "merchant_id": MobileRegisterConstant.merchant_id_value,
            "auth_token":hash,
            "username": email
        ] as [String : Any]
        
        print("google params  \(parameters)")
        
        self.showLoader()
        makeAPICall(url: url, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(GmailResponse.self, from: data)
                    
                    print("googel res \(response)")
                    
                    if response.success {
                        
                        self.isFirstTime = true
                        
                        self.userStore(customer_Details_ID: response.parameters.customerDetailsID)
                        
                        DispatchQueue.main.async { [self] in
                            UserDefaults.standard.set(userDefaultConstant.TRUE, forKey: userDefaultConstant.loggedIn)
                            
                            UserDefaults.standard.synchronize()
                            
                            let vc = homeStoryboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                        self.hideLoader()
                    }
                } catch {
                    self.hideLoader()
                    print("google error res localize \(error)")
                }
            }
        }
    }
    
    func userStore(customer_Details_ID: String) {
        UserDefaults.standard.set(customer_Details_ID, forKey: LoginConstant.customer_id)
    }
}


extension LoginViewController {
    
    private func initialLoads()  {
        navigationItem.hidesBackButton = true
        
        if let gcmtoken = UserDefaults.standard.string(forKey: "FCMToken") {
            gcmToken = gcmtoken
        }
        
        //Continue Button
        contineBtn.setTitle(LoginConstant.confirmBtn, for: .normal)
        contineBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        contineBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        contineBtn.setTitleColor(.white, for: .normal)
        contineBtn.cornerRadius = 25
        setShadow(view: contineBtn)
        
        //GooogleButton
        googleBtn.setTitle(LoginConstant.glbl, for: .normal)
        googleBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        googleBtn.setTitleColor(.white, for: .normal)
        googleBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        googleBtn.cornerRadius = 10
        setShadow(view: googleBtn)
        
        phoneNumberView.backgroundColor = UIColor(named: "ViewDarkMode")
        phoneNumberView.layer.cornerRadius = 10
        setShadow(view: phoneNumberView)
        
        //Phone Number Field
        phoneNumberField.placeholder = "Enter Phone Number"
        phoneNumberField.delegate = self
        phoneNumberField.borderStyle = .none
        phoneNumberField.backgroundColor = .clear
        
        
        //Labels
        loginTitle.text = LoginConstant.loginTitle
        //        skipLabel.text = LoginConstant.skipLbl
        orLabel.text = LoginConstant.orLbl
        orLabel.font = UIFont.systemFont(ofSize: 12)
        orLabel.textColor = UIColor.gray
        
        //CountryView
        countryBgView.backgroundColor = UIColor(named: "ViewDarkMode")
        countryBgView.cornerRadius = 10
        setShadow(view: countryBgView)
        
        // Set the default country to India
        countryView.backgroundColor = UIColor(named: "ViewDarkMode")
        countryView.setCountryByName("India")
        countryView.delegate = self
        
    }
    
    //TextField Max Number 10 Set
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxCharacter = 10
        let currentString :NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxCharacter
    }
    
    func isValid() -> Bool {
        if phoneNumberField.text!.isEmpty {
            // Alert Message
            showSimpleAlert(view: self, message: "", title: "Please Enter Mobile Number")
            return false
        }
        
        let phoneNumber = phoneNumberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        
        if !phoneNumberPredicate.evaluate(with: phoneNumber) {
            // Alert Message
            showSimpleAlert(view: self, message: "", title: "Please Enter a Valid Phone number")
            return false
        }
        
        return true
    }
}


extension LoginViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Loading", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
