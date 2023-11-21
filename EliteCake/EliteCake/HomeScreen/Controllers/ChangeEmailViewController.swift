//
//  ChangeEmailViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 13/03/23.
//

import UIKit

class ChangeEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var customerID: String = ""
    var screenType: String = ""
    var cartScreen: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        if isValid() {
            addEmailApi()
        }
    }
    
    func isValid() -> Bool {
        
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        guard let email = emailTextField.text, !email.isEmpty else {
            showToast(message: "Please Enter Email")
            return false
        }

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isEmailValid = emailPredicate.evaluate(with: email)

        if !isEmailValid {
            showToast(message: "Please Enter a Valid Email")
            return false
        }
        return true
    }
    
    func addEmailApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + self.emailTextField.text!)
        let url = URL(string: ApiConstant.ADD_EMAIL_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_details_id": customerID,
            "username" : emailTextField.text!
        ] as [String : Any]
        
        print("AddEmail params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        showAlert(message: "Api Res Status \(response.statusCode)")
                    }
                    self.hideLoader()
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddEmailResponse.self, from: data)
                    print("AddEmail Response \(response)")
                    
                    
                    DispatchQueue.main.async {
                        if response.success {
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "EmailVeificationViewController") as! EmailVeificationViewController
                            vc.email_id = self.emailTextField.text!
                            vc.cartScreenType = self.cartScreen
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            showAlert(message: response.message)
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("AddEmail error res \(error)")
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUp() {
        titleLbl.text = "Change email address"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.textColor = UIColor.black
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        contentLbl.text = "Enter a new email address, and we will send an OTP for verification"
        contentLbl.textColor = UIColor.gray
        contentLbl.font = UIFont.systemFont(ofSize: 14)
        
        emailLbl.text = "Email"
        emailLbl.textColor = UIColor.gray
        emailLbl.font = UIFont.systemFont(ofSize: 16)
        
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.backgroundColor = UIColor.white
        emailTextField.textColor = .black
        emailTextField.clipsToBounds = true
        
        submitBtn.setTitle("Verify OTP", for: .normal)
        submitBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        submitBtn.tintColor = UIColor.white
        submitBtn.layer.cornerRadius = 10
        setShadow(view: submitBtn)
        
        emailTextField.delegate = self
    }
}
