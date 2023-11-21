//
//  HelpCenterViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 17/03/23.
//

import UIKit

class HelpCenterViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var customerCareImage: UIImageView!
    
    @IBOutlet weak var supportLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    var phoneNumber: String = ""
    var customerID: String = ""
    var oID: String = ""
    var outletId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        HomeApi()

    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func HomeApi() {
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
                    self.showToast(message: "Status Code Error")
                    DispatchQueue.main.async {
                        showAlert(message: "Api Res \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        if response.success {
                            
                            self.phoneNumber = response.parameters.mobile
                            
                            let attributedText = NSMutableAttributedString(string: "We are Always there to help you out. Call us at \(self.phoneNumber) for any queries, issues, feedback, and suggestions.")
                            
                            let phoneRange = (attributedText.string as NSString).range(of: self.phoneNumber)
                            
                            let phoneNumberColor = UIColor.red
                            attributedText.addAttribute(.foregroundColor, value: phoneNumberColor, range: phoneRange)
                            
                            attributedText.addAttribute(.link, value: "tel:\(self.phoneNumber)", range: phoneRange)
                            
                            self.contentLbl.attributedText = attributedText
                            self.contentLbl.isUserInteractionEnabled = true
                        }
                    }
                } catch {
                    print("home error res \(error)")
                }
            }
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        let mobileNumber = self.phoneNumber
        
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
    
    func setUp() {
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        titleLbl.text = "Help Center"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        supportLbl.text = "Customer Support"
        supportLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        supportLbl.font = UIFont.boldSystemFont(ofSize: 20)

        contentLbl.numberOfLines = 4
        contentLbl.font = UIFont.systemFont(ofSize: 20)
        
        customerCareImage.image = UIImage(named: "HelpCenter")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        contentLbl.addGestureRecognizer(tapGesture)
    }
}
