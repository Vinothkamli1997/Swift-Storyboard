//
//  ChangeMobileNumberViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 31/05/23.
//

import UIKit
import CountryPickerView

class ChangeMobileNumberViewController: UIViewController, CountryPickerViewDelegate, UITextFieldDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        // The user selected a different country
        print("Selected country: \(country)")
    }
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var countryPickerView: CountryPickerView!
    
    @IBOutlet weak var phoneNumberField: UITextField!

    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var sendBtn: UIButton!

    var customerID: String = ""
    var screenType: String = "updateMobileNum"
    var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberField.delegate = self
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        titleLbl.text = "Change Phone Number"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        titleLbl.textColor = .black
        
        contentLbl.text = "Enter a new phone number,and we will send an OTP for verification."
        contentLbl.font = UIFont.systemFont(ofSize: 14)
        contentLbl.textColor = .black
        
        // Define the text attributes for the placeholder
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]

        // Create an attributed string with the placeholder text and attributes
        let attributedPlaceholder = NSAttributedString(string: "Enter Phone Number", attributes: placeholderAttributes)

        // Assign the attributed string as the placeholder of the phoneNumLbl
        phoneNumberField.attributedPlaceholder = attributedPlaceholder

        // Set other properties as you were doing
        phoneNumberField.borderStyle = .none
        phoneNumberField.backgroundColor = .white
        phoneNumberField.textColor = UIColor.black
        
        sendBtn.setTitle("Send OTP", for: .normal)
        sendBtn.tintColor = UIColor.white
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sendBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        sendBtn.cornerRadius = 20
        setShadow(view: sendBtn)
        
        phoneNumberField.text = phoneNumber
        phoneNumberField.returnKeyType = .done
        phoneNumberField.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
        
        
        countryPickerView.setCountryByName("India")
        countryPickerView.delegate = self

    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
        if (isValid()) {
            updateMobileNumApi()
        }
    }
    
    @objc func doneButtonPressed() {
         view.endEditing(true) // Hide the keyboard
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
    
    func updateMobileNumApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        print("mobileUpdate \(phoneNumberField.text!)")
        
        let hash = md5(string: ApiConstant.salt_key + phoneNumberField.text!)
        let url = URL(string: ApiConstant.MOBILE_NUM_UPDATE_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_details_id": customerID,
            "updated_mobile" : phoneNumberField.text!
        ] as [String : Any]
        
        print("mobileNum Upate params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MobileNumUpdateResponse.self, from: data)
                    print("mobileNum Upate Response \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                            vc.mobileNumber = self.phoneNumberField.text!
                            vc.screenType = self.screenType
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
//                            self.showToast(message: response.message)
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
}
