//
//  ProfileViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 10/03/23.
//

import UIKit


class ProfileViewController: UIViewController, UITextFieldDelegate, profilePopDelegate {
     
     func okBtnTapped(_ alert: ProfilePopUpViewController, alertTag: Int) {
          
          self.dismiss(animated: true)
          
          let storyBoard = UIStoryboard(name: "HomeScreen", bundle: nil)
          let vc = storyBoard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
          self.navigationController?.pushViewController(vc, animated: true)
     }
     
     @IBOutlet weak var titleLbl: UILabel!
     @IBOutlet weak var backbtn: UIButton!
     
     @IBOutlet weak var imageView: UIImageView!
     @IBOutlet weak var camerBtnVIew: UIView!
     @IBOutlet weak var camerBtn: UIButton!
     
     @IBOutlet weak var accountBgView: UIView!
     @IBOutlet weak var accountNameLbl: UILabel!
     @IBOutlet weak var accountNameField: UITextField!
     
     @IBOutlet weak var addressBgView: UIView!
     @IBOutlet weak var addressLbl: UILabel!
     @IBOutlet weak var addressField: UITextField!
     
     @IBOutlet weak var emailBgView: UIView!
     @IBOutlet weak var emailLbl: UILabel!
     @IBOutlet weak var emailField: UILabel!
     @IBOutlet weak var emailBtn: UIButton!
     
     @IBOutlet weak var phoneNumBgView: UIView!
     @IBOutlet weak var phoneNumberLbl: UILabel!
     @IBOutlet weak var phoneNumberField: UILabel!
     @IBOutlet weak var phoneBtn: UIButton!
     
     @IBOutlet weak var dobBgView: UIView!
     @IBOutlet weak var dobLbl: UILabel!
     @IBOutlet weak var dobFieldLbl: UILabel!
     
     @IBOutlet weak var saveBtn: UIButton!
     @IBOutlet weak var profileScrollView: UIScrollView!
     
     var accountScreen: String = ""
     var cartScreen: String = ""
     var customerID: String = ""
     var screenType: String = ""
     var imageURL: String = ""
     var nameFieldText: String = ""
     var addressFieldText: String = ""
     var emailValue: String = ""
     
     var profileDetails: ProfileParameters?
     var profileEditDetails: ProfileEditParameters?
     var accountDetails: AccountParameters?
     
     var isImageUpdate: Bool = false
     let lastTabIndex = 4 // Assuming the last tab is at index 2
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
          designSetUp()
          
          accountNameField.returnKeyType = .done
          accountNameField.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
          
          addressField.returnKeyType = .done
          addressField.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
          
          let emailLablTap = UITapGestureRecognizer(target: self, action: #selector(emailLabelAction(_:)))
          emailField.addGestureRecognizer(emailLablTap)
          emailField.isUserInteractionEnabled = true
          
          let mobileLblTap = UITapGestureRecognizer(target: self, action: #selector(mobileLabelAction(_:)))
          phoneNumberField.addGestureRecognizer(mobileLblTap)
          phoneNumberField.isUserInteractionEnabled = true
          
          // Register for keyboard notifications
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
          
          let keyboadrtapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          view.addGestureRecognizer(keyboadrtapGesture)
          
          let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
          imageView.isUserInteractionEnabled = true
          imageView.addGestureRecognizer(imageTapGesture)
     }
     
     override func viewWillAppear(_ animated: Bool) {
          if !isImageUpdate {
               accountApi()
          }
     }
     
     override func viewDidAppear(_ animated: Bool) {
          if !isImageUpdate {
               profileApi()
          }
     }
     
     func designSetUp() {
          addressField.delegate = self
          accountNameField.delegate = self
          
          accountNameField.returnKeyType = .done
          addressField.returnKeyType = .done
          
          titleLbl.text = "Account Management"
          titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
          titleLbl.textColor = .black
          
          imageView.layer.borderColor = UIColor.gray.cgColor
          imageView.layer.borderWidth = 1
          imageView.layer.cornerRadius = 60
          
          camerBtnVIew.backgroundColor = UIColor.white
          camerBtnVIew.layer.cornerRadius = 25
          setShadow(view: camerBtnVIew)
          
          camerBtn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
          camerBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
          camerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
          camerBtn.layer.cornerRadius = 25
          
          backbtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
          backbtn.tintColor = UIColor.black
          backbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
          
          accountNameLbl.text = "Account Name"
          accountNameLbl.font = UIFont.systemFont(ofSize: 16)
          accountNameLbl.textColor = .black
          
          addressLbl.text = "Address"
          addressLbl.font = UIFont.systemFont(ofSize: 16)
          addressLbl.textColor = .black
          
          emailLbl.text = "Email"
          emailLbl.font = UIFont.systemFont(ofSize: 16)
          emailLbl.textColor = .black
          
          phoneNumberLbl.text = "Phone Number"
          phoneNumberLbl.font = UIFont.systemFont(ofSize: 16)
          phoneNumberLbl.textColor = .black
          
          dobLbl.text = "Date Of Birth"
          dobLbl.font = UIFont.systemFont(ofSize: 16)
          dobLbl.textColor = .black
          
          dobFieldLbl.text = "Enter ur dob"
          
          if dobFieldLbl.text == "Enter ur dob" {
               dobFieldLbl.text = "Enter ur dob"
               dobFieldLbl.textColor = UIColor.lightGray
               dobFieldLbl.font = UIFont.systemFont(ofSize: 14)
          } else {
               dobFieldLbl.textColor = UIColor.black
               dobFieldLbl.font = UIFont.systemFont(ofSize: 14)
          }
          
          accountBgView.layer.borderColor = UIColor.gray.cgColor
          accountBgView.layer.borderWidth = 1
          accountBgView.layer.cornerRadius = 10
          accountBgView.backgroundColor = .white
          
          // Define the text attributes for the placeholder
          let placeholderAttributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: UIColor.lightGray
          ]
          
          // Create an attributed string with the placeholder text and attributes
          let attributedPlaceholder = NSAttributedString(string: "Enter account name", attributes: placeholderAttributes)
          
          // Assign the attributed string as the placeholder of the phoneNumLbl
          accountNameField.attributedPlaceholder = attributedPlaceholder
          
          // Set other properties as you were doing
          accountNameField.borderStyle = .none
          accountNameField.backgroundColor = .white
          accountNameField.textColor = UIColor.black
          
          
          addressBgView.layer.borderColor = UIColor.gray.cgColor
          addressBgView.layer.borderWidth = 1
          addressBgView.layer.cornerRadius = 10
          
          // Define the text attributes for the placeholder
          let addressLbl: [NSAttributedString.Key: Any] = [
               .foregroundColor: UIColor.lightGray
          ]
          
          // Create an attributed string with the placeholder text and attributes
          let address = NSAttributedString(string: "Enter Address", attributes: addressLbl)
          
          // Assign the attributed string as the placeholder of the phoneNumLbl
          addressField.attributedPlaceholder = address
          
          // Set other properties as you were doing
          addressField.borderStyle = .none
          addressField.backgroundColor = .white
          addressField.textColor = UIColor.black
          
          emailBgView.layer.borderColor = UIColor.gray.cgColor
          emailBgView.layer.borderWidth = 1
          emailBgView.layer.cornerRadius = 10
          emailBgView.backgroundColor = .white
          
          emailField.text = "Enter Email"
          emailField.textColor = UIColor.lightGray
          emailField.font = UIFont.systemFont(ofSize: 14)
          
          emailBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
          emailBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
          
          phoneNumBgView.layer.borderColor = UIColor.gray.cgColor
          phoneNumBgView.layer.borderWidth = 1
          phoneNumBgView.layer.cornerRadius = 10
          phoneNumBgView.backgroundColor = .white
          
          phoneNumberField.text = "Enter Phone Number"
          phoneNumberField.textColor = UIColor.lightGray
          phoneNumberField.font = UIFont.systemFont(ofSize: 14)
          
          phoneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
          phoneBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
          
          dobBgView.layer.borderColor = UIColor.gray.cgColor
          dobBgView.layer.borderWidth = 1
          dobBgView.layer.cornerRadius = 10
          dobBgView.backgroundColor = .white
          
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateLabelTapped(_:)))
          dobFieldLbl.isUserInteractionEnabled = true
          dobFieldLbl.addGestureRecognizer(tapGesture)
          
          saveBtn.setTitle("Save", for: .normal)
          saveBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
          saveBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
          saveBtn.tintColor = UIColor.white
          setShadow(view: saveBtn)
          saveBtn.layer.cornerRadius = 10
          
          profileScrollView.showsVerticalScrollIndicator = false
     }
     
     @IBAction func backBtnAction(_ sender: UIButton) {
          self.navigationController?.popViewController(animated: true)
     }
     
     @IBAction func camerBtnAction(_ sender: UIButton) {
          
          let alert = UIAlertController(title: "Choose", message: "Select media type", preferredStyle: .actionSheet)
          let gallery = UIAlertAction(title: "Use Gallery", style: .default) { UIAlertAction in
               
               let image = UIImagePickerController()
               image.delegate = self
               image.sourceType = .photoLibrary
               image.allowsEditing = true
               self.present(image, animated: true)
          }
          
          let camera = UIAlertAction(title: "Use Camera", style: .default) { _ in
              let imagePicker = UIImagePickerController()
              imagePicker.delegate = self
              imagePicker.sourceType = .camera
              imagePicker.allowsEditing = true
              self.present(imagePicker, animated: true)
          }

          
          let cancel = UIAlertAction(title: "Cancel", style: .destructive)
          
          alert.addAction(gallery)
          alert.addAction(camera)
          alert.addAction(cancel)
          self.present(alert, animated: true, completion: nil)
     }
     
     @objc func handleTap(_ sender: UITapGestureRecognizer) {
         showMediaOptions()
     }

     func showMediaOptions() {
         let alert = UIAlertController(title: "Choose", message: "Select media type.", preferredStyle: .actionSheet)
         
         let gallery = UIAlertAction(title: "Use Gallery", style: .default) { UIAlertAction in
             let imagePicker = UIImagePickerController()
             imagePicker.delegate = self
             imagePicker.sourceType = .photoLibrary
             imagePicker.allowsEditing = true
             self.present(imagePicker, animated: true)
         }
         
         let camera = UIAlertAction(title: "Use Camera", style: .default) { UIAlertAction in
             let imagePicker = UIImagePickerController()
             imagePicker.delegate = self
             imagePicker.sourceType = .camera
             imagePicker.allowsEditing = true
             self.present(imagePicker, animated: true)
         }
         
         let cancel = UIAlertAction(title: "Cancel", style: .destructive)
         
         alert.addAction(gallery)
         alert.addAction(camera)
         alert.addAction(cancel)
         
         self.present(alert, animated: true, completion: nil)
     }
     
     @IBAction func saveBtnAction(_ sender: UIButton) {
          if areAllFieldsFilled() {
               profileEditApi()
          }
     }
     
     @IBAction func emailBtnAction(_ sender: UIButton) {
          if let accountName = self.accountNameField.text, !accountName.isEmpty {
               UserDefaults.standard.set(accountName, forKey: "Name")
          } else {
               UserDefaults.standard.removeObject(forKey: "Name")
          }
          
          if let addressField = self.addressField.text, !addressField.isEmpty  {
               UserDefaults.standard.set(addressField, forKey: "Address")
          } else {
               UserDefaults.standard.removeObject(forKey: "Address")
          }
          
          if isValidPhone() {
               if emailBtn.title(for: .normal) == "Add" {
                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChangeEmailViewController") as! ChangeEmailViewController
                    self.navigationController?.pushViewController(vc, animated: true)
               } else {
                    changeEmailApi()
               }
          }
     }
     
     @IBAction func pohoneBtnAction(_ sender: UIButton) {
                    
          if let accountName = self.accountNameField.text, !accountName.isEmpty {
               UserDefaults.standard.set(accountName, forKey: "Name")
          } else {
               UserDefaults.standard.removeObject(forKey: "Name")
          }
          
          if let addressField = self.addressField.text, !addressField.isEmpty  {
               UserDefaults.standard.set(addressField, forKey: "Address")
          } else {
               UserDefaults.standard.removeObject(forKey: "Address")
          }
          
          if isValid() {
               if phoneBtn.title(for: .normal) == "Add" {
                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChangeMobileNumberViewController") as! ChangeMobileNumberViewController
                    self.navigationController?.pushViewController(vc, animated: true)
               } else if phoneBtn.title(for: .normal) == "Change" {
                    self.addEmailApi()
               }
          }
          
     }
     
     @objc func emailLabelAction(_ sender: UITapGestureRecognizer) {
          if let accountName = self.accountNameField.text, !accountName.isEmpty {
               UserDefaults.standard.set(accountName, forKey: "Name")
          } else {
               UserDefaults.standard.removeObject(forKey: "Name")
          }
          
          if let addressField = self.addressField.text, !addressField.isEmpty  {
               UserDefaults.standard.set(addressField, forKey: "Address")
          } else {
               UserDefaults.standard.removeObject(forKey: "Address")
          }
          
          if isValidPhone() {
               if emailBtn.title(for: .normal) == "Add" {
                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChangeEmailViewController") as! ChangeEmailViewController
                    self.navigationController?.pushViewController(vc, animated: true)
               } else {
                    changeEmailApi()
               }
          }
     }
     
     @objc func mobileLabelAction(_ sender: UITapGestureRecognizer) {
          if let accountName = self.accountNameField.text, !accountName.isEmpty {
               UserDefaults.standard.set(accountName, forKey: "Name")
          } else {
               UserDefaults.standard.removeObject(forKey: "Name")
          }
          
          if let addressField = self.addressField.text, !addressField.isEmpty  {
               UserDefaults.standard.set(addressField, forKey: "Address")
          } else {
               UserDefaults.standard.removeObject(forKey: "Address")
          }
          
          if isValid() {
               if phoneBtn.title(for: .normal) == "Add" {
                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChangeMobileNumberViewController") as! ChangeMobileNumberViewController
                    self.navigationController?.pushViewController(vc, animated: true)
               } else if phoneBtn.title(for: .normal) == "Change" {
                    self.addEmailApi()
               }
          }
     }
     
     func areAllFieldsFilled() -> Bool {
          if accountNameField.text?.isEmpty ?? true {
               showToast(message: "Name is required.")
               return false
          } else if addressField.text?.isEmpty ?? true {
               showToast(message: "Address is required.")
               return false
          } else if emailField.text?.isEmpty ?? true {
               showToast(message: "Email is required.")
               return false
          } else if emailField.text == "Enter Email" {
               showToast(message: "Email is required.")
               return false
          } else if phoneNumberField.text?.isEmpty ?? true {
               showToast(message: "Phone number is required.")
               return false
          }
          return true
     }
     
     //TextField Max Number 10 Set
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          if textField == phoneNumberField {
               let maxCharacter = 10
               let currentString = textField.text ?? ""
               let newString = (currentString as NSString).replacingCharacters(in: range, with: string)
               return newString.count <= maxCharacter
          }
          
          // For other text fields, allow any changes without character limit
          return true
     }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          print("textFieldShouldReturn called")
          switch textField {
          case accountNameField:
               addressField.resignFirstResponder()
          case addressField:
               emailField.resignFirstResponder()
          case emailField:
               phoneNumberField.resignFirstResponder()
          default:
               break
          }
          return true
     }
     
     @objc func doneButtonPressed() {
          view.endEditing(true) // Hide the keyboard
     }
     
     
     func isValidPhone() -> Bool {
          if phoneNumberField.text!.isEmpty {
               //Alert Message
               showToast(message: "Please Enter Mobile Number")
               return false
          }
          if phoneNumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 10 {
               //Alert Message
               showToast(message: "Please Enter Valid Phone number")
               return false
          }
          return true
     }
     
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          if textField == emailField {
               
               if let accountName = self.accountNameField.text, !accountName.isEmpty {
                    UserDefaults.standard.set(accountName, forKey: "Name")
               } else {
                    UserDefaults.standard.removeObject(forKey: "Name")
               }
               
               if let addressField = self.addressField.text, !addressField.isEmpty  {
                    UserDefaults.standard.set(addressField, forKey: "Address")
               } else {
                    UserDefaults.standard.removeObject(forKey: "Address")
               }
               
               
               let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
               let destinationVC = storyboard.instantiateViewController(withIdentifier: "ChangeEmailViewController")
               navigationController?.pushViewController(destinationVC, animated: true)
               return false
          }
          return true
     }
     
     
     @objc func dismissKeyboard() {
          view.endEditing(true)
     }
     
     @objc func keyboardWillShow(notification: NSNotification) {
          guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
               return
          }
          
          let keyboardHeight = keyboardFrame.size.height
          
          // Adjust the content inset of the scroll view to avoid the keyboard
          let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
          profileScrollView.contentInset = contentInset
          profileScrollView.scrollIndicatorInsets = contentInset
     }
     
     @objc func keyboardWillHide(notification: NSNotification) {
          // Reset the content inset of the scroll view when the keyboard hides
          let contentInset = UIEdgeInsets.zero
          profileScrollView.contentInset = contentInset
          profileScrollView.scrollIndicatorInsets = contentInset
     }
     
     func isValid() -> Bool {
          
          // Regular expression pattern to validate email format
          let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
          
          guard let email = emailField.text, !email.isEmpty else {
               showToast(message: "Please Enter Email")
               return false
          }
          
          // Validate email format using regular expression
          let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
          let isEmailValid = emailPredicate.evaluate(with: email)
          
          if !isEmailValid {
               showToast(message: "Please Enter a Valid Email")
               return false
          }
          return true
     }
     
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
                         let response = try decoder.decode(ProfileResponse.self, from: data)
                         print("profile Response \(response)")
                         
                         self.profileDetails = response.parameters
                         
                         DispatchQueue.main.async {
                              
                              if self.profileDetails?.customerName == "" {
                                   if let addressField = UserDefaults.standard.string(forKey: "Name") {
                                        self.accountNameField.text = addressField
                                   }
                              } else if self.profileDetails?.customerName == nil {
                                   if let addressField = UserDefaults.standard.string(forKey: "Name") {
                                        self.accountNameField.text = addressField
                                   }
                              } else {
                                   self.accountNameField.text = self.profileDetails?.customerName
                              }
                              
                              if self.profileDetails?.customerAddress == "" {
                                   if let addressField = UserDefaults.standard.string(forKey: "Address") {
                                        self.addressField.text = addressField
                                   }
                              } else if self.profileDetails?.customerAddress == nil {
                                   if let addressField = UserDefaults.standard.string(forKey: "Address") {
                                        self.addressField.text = addressField
                                   }
                              } else {
                                   self.addressField.text = self.profileDetails?.customerAddress
                              }
                              
                              if self.profileDetails?.dateOfBirth == "" {
                                   if let dateField = UserDefaults.standard.string(forKey: "Date") {
                                        self.dobFieldLbl.text = dateField
                                        self.dobFieldLbl.textColor = .black
                                   } else {
                                        if let dateField = UserDefaults.standard.string(forKey: "Date") {
                                             self.dobFieldLbl.text = dateField
                                             self.dobFieldLbl.textColor = .black
                                        }
                                   }
                              } else if self.profileDetails?.dateOfBirth == nil {
                                   if let dateField = UserDefaults.standard.string(forKey: "Date") {
                                        self.dobFieldLbl.text = dateField
                                        self.dobFieldLbl.textColor = .black
                                   }
                              } else {
                                   self.dobFieldLbl.text = self.profileDetails?.dateOfBirth
                                   self.dobFieldLbl.textColor = .black
                              }
                              
                              if self.profileDetails?.customerMobile == "" || self.profileDetails?.customerMobile == nil {
                                   self.phoneBtn.setTitle("Add", for: .normal)
                              } else {
                                   self.phoneNumberField.text = self.profileDetails?.customerMobile
                                   self.phoneNumberField.textColor = UIColor.black
                                   self.phoneBtn.setTitle("Change", for: .normal)
                              }
                              
                              if let customerEmail = self.profileDetails?.customerEmail, !customerEmail.isEmpty {
                                   self.emailField.text = customerEmail
                                   self.emailField.textColor = UIColor.black
                                   self.emailBtn.setTitle("Change", for: .normal)
                              } else {
                                   self.emailBtn.setTitle("Add", for: .normal)
                              }
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
          
          self.showLoader()
          
          if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
               customerID = customer_id
          }
          
          if let accScreen = UserDefaults.standard.string(forKey: "AccountScreen") {
               self.accountScreen = accScreen
          }
          
          if let accScreen = UserDefaults.standard.string(forKey: "MobileChange") {
               self.accountScreen = accScreen
          }
          
          let email = self.emailField.text!
          
          if email != "Enter Email" {
               emailValue = email
          }
          
          let hash = md5(string: ApiConstant.salt_key + customerID)
          let url = URL(string: ApiConstant.PROFILE_EDIT_API)
          
          var parameters: [String: Any] = [
               MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
               MobileRegisterConstant.auth_token: hash,
               "customer_id": customerID,
               "customer_address": self.addressField.text!,
               "customer_mobile": self.phoneNumberField.text!,
               "date_of_birth": self.dobFieldLbl.text!,
               "customer_email": emailValue,
               "is_mobile_edit": "0",
               "customer_name": self.accountNameField.text!
          ]
          
          if !imageURL.isEmpty {
               parameters["image"] = "data:image/png;base64,\(imageURL)"
          }
          
          
          print("profileEdit params \(parameters)")
          
          makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
               if error != nil {
               } else if let data = data, let response = response {
                    if response.statusCode != 200 {
                         DispatchQueue.main.async {
                              showSimpleAlert(view: self, message: "", title: "Status not 200")
                              self.hideLoader()
                         }
                         return
                    }
                    
                    let decoder = JSONDecoder()
                    do {
                         let response = try decoder.decode(ProfileEditResponse.self, from: data)
                         
                         print("profileEdit params \(response)")

                         if response.success {
                              self.profileEditDetails = response.parameters
                         }
                         
                         DispatchQueue.main.async {
                              if self.screenType == "Claim" {
                                   self.navigationController?.popViewController(animated: true)
                              }
                              
                              if response.parameters.message == HomeConstant.PROFILE_POPUP_MESG {
                                   let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                   let profilePopupVC = storyboard.instantiateViewController(withIdentifier: "ProfilePopUpViewController") as! ProfilePopUpViewController
                                   
                                   profilePopupVC.context = self
                                   profilePopupVC.popUpmessage = response.parameters.message
                                   
                                   profilePopupVC.modalPresentationStyle = .overCurrentContext
                                   self.present(profilePopupVC, animated: false, completion: nil)
                                   
                                   let dismissalTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                                        profilePopupVC.dismiss(animated: true, completion: nil)
                                        
                                        if self.cartScreen == "Cart" {
                                             let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                             let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                                             vc.backButton = "backButton"
                                             vc.backBtnScreenType = false
                                             self.navigationController?.pushViewController(vc, animated: true)
                                        } else if self.screenType == "Account" {
                                             for controller in self.navigationController!.viewControllers as Array<Any> {
                                                  if (controller as AnyObject).isKind(of: BottomViewController.self) {
                                                       _ =  self.navigationController!.popToViewController((controller as? UIViewController)!, animated: true)
                                                       break
                                                  }
                                             }
                                        } else {
                                             for controller in self.navigationController!.viewControllers as Array<Any> {
                                                  if (controller as AnyObject).isKind(of: BottomViewController.self) {
                                                       _ =  self.navigationController!.popToViewController((controller as? UIViewController)!, animated: true)
                                                       break
                                                  }
                                             }
                                        }
                                   }
                              } else {
                                   if self.accountScreen == "Account" {
                                        UserDefaults.standard.removeObject(forKey: "AccountScreen")
                                        
                                        if let navigationController = self.navigationController {
                                             // Get the view controllers currently on the navigation stack
                                             let viewControllers = navigationController.viewControllers
                                             
                                             // Check if there are at least two view controllers in the stack
                                             if viewControllers.count >= 2 {
                                                  // Pop to the second-to-last view controller
                                                  let targetViewController = viewControllers[viewControllers.count - 2]
                                                  navigationController.popToViewController(targetViewController, animated: true)
                                             } else {
                                                  // Handle the case where there are fewer than two view controllers
                                                  // (you might want to handle this based on your app's logic)
                                                  print("Not enough view controllers to pop.")
                                             }
                                        }
                                        
                                        //                                        for controller in self.navigationController!.viewControllers as Array<Any> {
                                        //                                             if (controller as AnyObject).isKind(of: BottomViewController.self) {
                                        //                                                  _ =  self.navigationController!.popToViewController((controller as? UIViewController)!, animated: true)
                                        //                                                  break
                                        //                                             }
                                        //                                        }
                                   } else {
                                        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                        if let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
                                             vc.backButton = "backButton"
                                             vc.backBtnScreenType = false
                                             self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                   }
                              }
                         }
                         self.hideLoader()
                    } catch {
                         self.hideLoader()
                         print("profileEdit error res \(error)")
                    }
               } else {
                    showAlert(message: "Api Error")
                    self.hideLoader()
               }
          }
     }
     
     func addEmailApi() {
          
          self.showLoader()
          
          if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
               customerID = customer_id
          }
          
          let hash = md5(string: ApiConstant.salt_key + self.emailField.text!)
          let url = URL(string: ApiConstant.ADD_EMAIL_API)
          
          let parameters = [
               MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
               MobileRegisterConstant.auth_token: hash,
               "customer_details_id": customerID,
               "username" : emailField.text!
          ] as [String : Any]
          
          print("AddEmail params \(parameters)")
          
          makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
               if error != nil {
               } else if let data = data, let response = response {
                    if response.statusCode != 200 {
                         DispatchQueue.main.async {
                              showAlert(message: "Api Response Status \(response.statusCode)")
                              self.hideLoader()
                         }
                         
                         return
                    }
                    let decoder = JSONDecoder()
                    do {
                         let response = try decoder.decode(AddEmailResponse.self, from: data)
                         print("AddEmail Response \(response)")
                         
                         
                         DispatchQueue.main.async {
                              if response.success {
                                   
                                   if let accountName = self.accountNameField.text, !accountName.isEmpty {
                                        UserDefaults.standard.set(accountName, forKey: "Name")
                                   } else {
                                        UserDefaults.standard.removeObject(forKey: "Name")
                                   }
                                   
                                   if let addressField = self.addressField.text, !addressField.isEmpty  {
                                        UserDefaults.standard.set(addressField, forKey: "Address")
                                   } else {
                                        UserDefaults.standard.removeObject(forKey: "Address")
                                   }
                                   
                                   if let dateField = self.dobFieldLbl.text, !dateField.isEmpty  {
                                        UserDefaults.standard.set(dateField, forKey: "Date")
                                   } else {
                                        UserDefaults.standard.removeObject(forKey: "Date")
                                   }
                                   
                                   
                                   let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                   let vc = storyboard.instantiateViewController(withIdentifier: "EmailVeificationViewController") as! EmailVeificationViewController
                                   vc.email_id = self.emailField.text!
                                   vc.screenType = "updateMobileNum"
                                   self.navigationController?.pushViewController(vc, animated: true)
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
     
     
     func changeEmailApi() {
          
          self.showLoader()
          
          guard let mobileNumber = phoneNumberField.text else {
               // Handle the case when the mobile number is not available
               return
          }
          
          let hash = md5(string: ApiConstant.salt_key + mobileNumber)
          let url = URL(string: ApiConstant.CHANGE_EMAIL_API)
          
          let parameters = [
               MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
               MobileRegisterConstant.auth_token: hash,
               "customer_mobile": mobileNumber
          ] as [String : Any]
          
          print("Change Email params \(parameters)")
          
          makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
               if error != nil {
               } else if let data = data, let response = response {
                    if response.statusCode != 200 {
                         return
                    }
                    let decoder = JSONDecoder()
                    do {
                         let response = try decoder.decode(ChangeEmailResponse.self, from: data)
                         print("Change Email Response \(response)")
                         
                         DispatchQueue.main.async {
                              if response.success {
                                   
                                   if let accountName = self.accountNameField.text, !accountName.isEmpty {
                                        UserDefaults.standard.set(accountName, forKey: "Name")
                                   } else {
                                        UserDefaults.standard.removeObject(forKey: "Name")
                                   }
                                   
                                   if let addressField = self.addressField.text, !addressField.isEmpty  {
                                        UserDefaults.standard.set(addressField, forKey: "Address")
                                   } else {
                                        UserDefaults.standard.removeObject(forKey: "Address")
                                   }
                                   
                                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                   let vc = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                                   vc.screenType = "EmailChange"
                                   vc.mobileNumber = mobileNumber
                                   self.navigationController?.pushViewController(vc, animated: true)
                              }
                         }
                         
                         self.hideLoader()
                    } catch {
                         self.hideLoader()
                         print("Change Email error res \(error)")
                    }
               }
          }
     }
     
     func accountApi() {
          if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
               customerID = customer_id
          }
          
          let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
          let url = URL(string: ApiConstant.ACCOUNT_API)
          
          let parameters = [
               MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
               MobileRegisterConstant.auth_token: hash,
               "customer_id": customerID
          ] as [String : Any]
          
          print("Account params \(parameters)")
          
          makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
               if error != nil {
               } else if let data = data, let response = response {
                    if response.statusCode != 200 {
                         return
                    }
                    let decoder = JSONDecoder()
                    do {
                         let response = try decoder.decode(AccountResponse.self, from: data)
                         print("Account Response \(response)")
                         
                         self.accountDetails = response.parameters
                         
                         
                         if self.accountDetails?.customeImage != nil {
                              self.imageView.sd_setImage(with: URL(string: (self.accountDetails?.customeImage)!), placeholderImage: UIImage(named: "Sibling1"))
                         }
                    } catch {
                         print("Account error res \(error)")
                    }
               }
          }
     }
     
     @objc func dateLabelTapped(_ sender: UITapGestureRecognizer) {
         let datePicker = UIDatePicker()
         datePicker.datePickerMode = .date
         
         // Set maximum date to December 31, 2014
         let calendar = Calendar.current
         var components = DateComponents()
         components.year = 2014
         components.month = 12
         components.day = 31
         if let maxDate = calendar.date(from: components) {
             datePicker.maximumDate = maxDate
         }
         
         datePicker.setDate(Date(), animated: true)

         let contentViewController = UIViewController()
         contentViewController.view.addSubview(datePicker)
         datePicker.translatesAutoresizingMaskIntoConstraints = false
         datePicker.centerXAnchor.constraint(equalTo: contentViewController.view.centerXAnchor).isActive = true
         datePicker.centerYAnchor.constraint(equalTo: contentViewController.view.centerYAnchor).isActive = true

         let alertController = UIAlertController(title: "Select Date of Birth", message: nil, preferredStyle: .actionSheet)
         let attributedTitle = NSAttributedString(string: "Select Date of Birth", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
         alertController.setValue(attributedTitle, forKey: "attributedTitle")
         alertController.setValue(contentViewController, forKey: "contentViewController")

         let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
             let formatter = DateFormatter()
             formatter.dateStyle = .medium
             let selectedDate = datePicker.date

             // Extracting date components
             let calendar = Calendar.current
             let components = calendar.dateComponents([.day, .month, .year], from: selectedDate)

             if let day = components.day, let month = components.month, let year = components.year {

                 // Create a date string using the format "dd-MM-yyyy"
                 let dateText = "\(day)-\(month)-\(year)"

                 UserDefaults.standard.set(dateText, forKey: "Date")

                 self.dobFieldLbl.textAlignment = .left
                 self.dobFieldLbl.text = "\(day)-\(month)-\(year)"
                 self.dobFieldLbl.textColor = UIColor.black
             }
         }

         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

         alertController.addAction(doneAction)
         alertController.addAction(cancelAction)

         if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
             alertController.popoverPresentationController?.sourceView = window
             alertController.popoverPresentationController?.sourceRect = self.dobFieldLbl.bounds
             alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
         }

         UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
     }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
          
          picker.dismiss(animated: true, completion: nil)

          var selectedImage: UIImage?
          
          if let editedImage = info[.editedImage] as? UIImage {
               selectedImage = editedImage
          } else if let originalImage = info[.originalImage] as? UIImage {
               selectedImage = originalImage
          }
          
          self.imageView.image = selectedImage
          isImageUpdate = true
          
          let imageData = selectedImage?.jpegData(compressionQuality: 1)
          
          if let image = selectedImage {
               if let imageData = image.jpegData(compressionQuality: 0.8) {
                    let base64Image = imageData.base64EncodedString()
                    print("Base64 image string: \(base64Image)")
                    self.imageURL = base64Image
               } else {
                    print("Error converting image data to JPEG")
               }
          } else {
               print("Selected image is nil")
          }
          
          picker.dismiss(animated: true, completion: nil)
     }
     
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true, completion: nil)
     }
}

extension UITextView: UITextViewDelegate {
     public func textViewDidChange(_ textView: UITextView) {
          if text.last == "\n" {
               text.removeLast()
               textView.resignFirstResponder()
          }
     }
}
