//
//  AddPersonalDetailsViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 26/05/23.
//

import UIKit
import CountryPickerView

class AddPersonalDetailsViewController: UIViewController, UITextFieldDelegate {
    
    //    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var nameLbl: UITextField!
    
    @IBOutlet weak var stepLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var nameBottomView: UIView!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var phoneNumLbl: UITextField!
    
    @IBOutlet weak var close1Btn: UIButton!
    
    @IBOutlet weak var phoneNumBottomView: UIView!
    
    @IBOutlet weak var countryView: UIView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    var customerID: String = ""
    var screenType: String = "addProfile"
    var addProfileCheck: ProfileParameters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumLbl.delegate = self
        
        profileApi()
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        stepLbl.text = "Step 1 of 2:"
        stepLbl.textColor = UIColor.black
        
        titleLbl.text = "Add Personal Details"
        titleLbl.textColor = UIColor.black
        
        contentLbl.text = "Adding these details is a one time process.Next time, checkout will be Frezee"
        contentLbl.font = UIFont.systemFont(ofSize: 12)
        contentLbl.textColor = UIColor.black
        
        // Define the text attributes for the placeholder
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]

        // Create an attributed string with the placeholder text and attributes
        let attributedPlaceholder = NSAttributedString(string: "Enter Your Name", attributes: placeholderAttributes)

        // Assign the attributed string as the placeholder of the phoneNumLbl
        nameLbl.attributedPlaceholder = attributedPlaceholder

        // Set other properties as you were doing
        nameLbl.borderStyle = .none
        nameLbl.backgroundColor = .white
        nameLbl.textColor = UIColor.black
        nameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Define the text attributes for the placeholder
        let placeholderAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]

        // Create an attributed string with the placeholder text and attributes
        let placeholder = NSAttributedString(string: "Enter Phone Number", attributes: placeholderAttribute)

        // Assign the attributed string as the placeholder of the phoneNumLbl
        phoneNumLbl.attributedPlaceholder = placeholder

        // Set other properties as you were doing
        phoneNumLbl.borderStyle = .none
        phoneNumLbl.backgroundColor = .white
        phoneNumLbl.textColor = UIColor.black
        
        phoneNumLbl.returnKeyType = .done
        phoneNumLbl.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
        
        closeBtn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        closeBtn.tintColor = .black
        
        close1Btn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        close1Btn.tintColor = .black
        
        countryView.backgroundColor = .white
        
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.backgroundColor = .lightGray
        confirmBtn.tintColor = .black
        setShadow(view: confirmBtn)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        if (isValid()) {
            updateMobileNumApi()
        }
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.nameLbl.text = ""
    }
    
    
    @IBAction func close1BtnAction(_ sender: UIButton) {
        self.phoneNumLbl.text = ""
    }
    
    @objc func doneButtonPressed() {
         view.endEditing(true) // Hide the keyboard
    }
    
    //Profile Api
    func profileApi() {
        
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(ProfileResponse.self, from: data)
                    print("profile Response \(response)")
                    
                    self.addProfileCheck = response.parameters
                    
                    DispatchQueue.main.async {
                        self.nameLbl.text = self.addProfileCheck?.customerName
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("profile error res \(error)")
                }
            }
        }
    }
    
    func updateMobileNumApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        print("mobileUpdate \(phoneNumLbl.text!)")
        
        let hash = md5(string: ApiConstant.salt_key + phoneNumLbl.text!)
        let url = URL(string: ApiConstant.MOBILE_NUM_UPDATE_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_details_id": customerID,
            "updated_mobile" : phoneNumLbl.text!
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(MobileNumUpdateResponse.self, from: data)
                    print("mobileNum Upate Response \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            if self.phoneNumLbl.text != nil {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                                vc.mobileNumber = self.phoneNumLbl.text
                                vc.screenType = self.screenType
                                self.navigationController?.pushViewController(vc, animated: true)
//                                self.showToast(message: response.message)
                            } else {
                                self.showToast(message: "Enter Mobile Number")
                            }
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
    
    func isValid() -> Bool {
        if phoneNumLbl.text!.isEmpty {
            //Alert Message
            showToast(message: "Please Enter Mobile Number")
            return false
        }
        if phoneNumLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 10 {
            showToast(message: "Please Enter Valid Phone number")
            return false
        }
        return true
    }
}
