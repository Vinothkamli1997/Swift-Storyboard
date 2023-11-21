//
//  AboutViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 17/03/23.
//

import UIKit
import MapKit
import WebKit
import StoreKit


class AboutViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var cityNameLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var cityAddressNameLbl: UILabel!
    
    @IBOutlet weak var addressBgView: UIView!
    
    @IBOutlet weak var directionView: UIView!
    
    @IBOutlet weak var approxTimeView: UIView!
    
    @IBOutlet weak var appshareView: UIView!
    
    @IBOutlet weak var callLbl: UILabel!

//    @IBOutlet weak var getDirectionLbl: UILabel!

    @IBOutlet weak var appVersionBtn: UIButton!
    @IBOutlet weak var appVersionLbl: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareLbl: UILabel!
    
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var rateUsLbl: UILabel!
    
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var instagramBtn: UIButton!
    
    @IBOutlet weak var facbookLbl: UILabel!
    @IBOutlet weak var instagramLbl: UILabel!
    
    @IBOutlet weak var storeDeliverLbl: UILabel!
    @IBOutlet weak var approxTimeLbl: UILabel!
    
    var customerID: String = ""
    var oID: String = ""
    var outletId: String = ""
    var instaURL: String = ""
    var fbURL: String = ""
    var lat: String = ""
    var long: String = ""
    var address: String = ""
    var mobileNum: String = ""
    var referralCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = "About Us"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        logoImageView.image = UIImage(named: "AppLogo")
        logoImageView.layer.cornerRadius = 50
        
        cityNameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        addressLbl.text = "Address"
        addressLbl.font = UIFont.systemFont(ofSize: 16)
                        
        locationImage.image = UIImage(named: "LocationImage")
        
        storeDeliverLbl.text = "Store Delivery Info"
        storeDeliverLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        addressBgView.backgroundColor = UIColor(hexFromString: ColorConstant.ADDITEMPINK)
        addressBgView.layer.cornerRadius = 10
        
        approxTimeView.backgroundColor = UIColor(named: "ViewDarkMode")
        
        directionView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        directionView.layer.cornerRadius = 10
        
        facbookLbl.text = "Like Us on FaceBook"
        facbookLbl.font = UIFont.boldSystemFont(ofSize: 14)
        facebookBtn.setImage(UIImage(named: "Fb"), for: .normal)
        
        instagramLbl.text = "Follow Us on Instagram"
        instagramLbl.font = UIFont.boldSystemFont(ofSize: 14)
        instagramBtn.setImage(UIImage(named: "Insta"), for: .normal)
        
        if let image = UIImage(named: "shareIconimg")?.withRenderingMode(.alwaysTemplate) {
            shareBtn.setImage(image, for: .normal)
            shareBtn.tintColor = UIColor.systemGray
        }
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("App Version: \(appVersion)")
            self.appVersionLbl.text = "AppVersion " + appVersion
        }
        
        shareLbl.text = "Share this App"
        shareLbl.font = UIFont.systemFont(ofSize: 14)
        
        rateUsLbl.font = UIFont.systemFont(ofSize: 14)
        
        appVersionLbl.font = UIFont.systemFont(ofSize: 14)
        
        let calltapGestute = UITapGestureRecognizer(target: self, action: #selector(callLabelTapped))
        callLbl.isUserInteractionEnabled = true
        callLbl.addGestureRecognizer(calltapGestute)
        
        let shareLbltapGesture = UITapGestureRecognizer(target: self, action: #selector(shareLblTapped))
        shareLbl.isUserInteractionEnabled = true
        shareLbl.addGestureRecognizer(shareLbltapGesture)
        
        let rateLblTapGesture = UITapGestureRecognizer(target: self, action: #selector(rateLblAction))
        rateUsLbl.isUserInteractionEnabled = true
        rateUsLbl.addGestureRecognizer(rateLblTapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HomeApi()
        referralApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func callBtnTapped(_ sender: UIButton) {
        let mobileNumber = self.mobileNum
        
        print("mobilenum about \(mobileNumber)")

        // Remove any non-digit characters from the mobile number
        let cleanedMobileNumber = mobileNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        // Check if the cleaned mobile number is empty or not
        if !cleanedMobileNumber.isEmpty {
            if let dialURL = URL(string: "tel:\(cleanedMobileNumber)") {
                if UIApplication.shared.canOpenURL(dialURL) {
                    UIApplication.shared.open(dialURL, options: [:], completionHandler: nil)
                } else {
                    showAlert(message: "Unable to open the dial pad")
                }
            } else {
                showAlert(message: "Unable to create a valid dial URL")
            }
        } else {
            showAlert(message: "Invalid mobile number")
        }
    }
    
    @IBAction func fbBtnTapped(_ sender: UIButton) {
        openSocialMediaURL(urlString: self.fbURL)
    }

    @IBAction func instaBtnTapped(_ sender: UIButton) {
        openSocialMediaURL(urlString: self.instaURL)
    }
    
    
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        
        let referralCode = self.referralCode
        let appStoreURLString = "https://play.google.com/store/apps/details?id=com.tt.yumbox.elitecake"

        guard let encodedAppStoreURLString = appStoreURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        let textToShare = "Here's the referral code: \(referralCode)\n\(encodedAppStoreURLString)"

        let itemsToShare: [Any] = [textToShare]
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
        }

        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func rateBtnTapped(_ sender: UIButton) {
        if let appStoreURL = URL(string: "https://play.google.com/store/apps/details?id=com.tt.yumbox.elitecake") {
            if UIApplication.shared.canOpenURL(appStoreURL) {
                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func callLabelTapped() {
        let mobileNumber = self.mobileNum
        
        print("mobilenum about \(mobileNumber)")

        let cleanedMobileNumber = mobileNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        if !cleanedMobileNumber.isEmpty {
            if let dialURL = URL(string: "tel:\(cleanedMobileNumber)") {
                if UIApplication.shared.canOpenURL(dialURL) {
                    UIApplication.shared.open(dialURL, options: [:], completionHandler: nil)
                } else {
                    showAlert(message: "Unable to open the dial pad")
                }
            } else {
                showAlert(message: "Unable to create a valid dial URL")
            }
        } else {
            showAlert(message: "Invalid mobile number")
        }
    }
    
    @objc func shareLblTapped() {
        let referralCode = self.referralCode
        let appStoreURLString = "https://play.google.com/store/apps/details?id=com.tt.yumbox.elitecake"

        guard let encodedAppStoreURLString = appStoreURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        let textToShare = "Here's the referral code: \(referralCode)\n\(encodedAppStoreURLString)"

        let itemsToShare: [Any] = [textToShare]
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
        }

        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @objc func rateLblAction() {
        if let appStoreURL = URL(string: "https://play.google.com/store/apps/details?id=com.tt.yumbox.elitecake") {
            if UIApplication.shared.canOpenURL(appStoreURL) {
                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    //HomeAPI Call
    func HomeApi() {
        self.showLoader()
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let outlet_id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = outlet_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.homeScreen)
        
        let parameters = [
            "customer_details_id": customerID,
            "outlet_id": outletId,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("home paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                    self.showToast(message: "Status Code Error")
                        print("Status Code Error")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    print("home response \(response)")
                    
                    if response.success {
                        
                        self.lat = response.parameters.latitude
                        self.long = response.parameters.longitude
                        self.instaURL = response.parameters.instaLink
                        self.fbURL = response.parameters.fbLink
                        self.mobileNum = response.parameters.mobile
                        
                        DispatchQueue.main.async {
                            self.cityAddressNameLbl.text = response.parameters.address
                            self.cityNameLbl.text = response.parameters.outletName
                        }
                        
                        print("fblink \(response.parameters.fbLink)")
                    }

                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("home error res \(error)")
                }
            }
        }
    }
    
    func referralApi() {
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
                    }
                    
                } catch {
                    print("Referral error res \(error)")
                }
            }
        }
    }
}
