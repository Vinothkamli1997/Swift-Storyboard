//
//  AddEventProfilePopupViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 27/07/23.
//

import UIKit

class AddEventProfilePopupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var popupBgView: UIView!
    
    @IBOutlet weak var headingLbl: UILabel!

    @IBOutlet weak var closeBtn: UIButton!

    @IBOutlet weak var addImage: UIImageView!
    
    @IBOutlet weak var cameraBtn: UIButton!

    @IBOutlet weak var cameraBtnView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var nameView: UIView!

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var dateView: UIView!

    @IBOutlet weak var dateTextField: UITextField!

    @IBOutlet weak var mobileNumLbl: UILabel!
    
    @IBOutlet weak var mobileNumView: UIView!

    @IBOutlet weak var mobileNumTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var eventDetails: Relation?
    var selectBonusID: Int = 0
    var customerID: String = ""
    var outletId: String = ""
    var oID: String = ""
    var selectedReationID: String = ""
    var selectedReation_ID: Int = 0
    var imageURL: String = ""
    var selectedImagePath: String = ""
    var selectType: String = ""
    var ifUpdate: Bool = false
    var context: UIViewController?

    var eventBirthdayList: [Anniversary] = []
    var eventanniversaryList: [Anniversary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        getRelationApi()
        print("selected tag ????? \(selectedReationID)")
        
        mobileNumTextField.delegate = self
        nameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let keyboadrtapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(keyboadrtapGesture)
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addImage.isUserInteractionEnabled = true
        addImage.addGestureRecognizer(imageTapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addEventApi()
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
        let date = self.dateTextField.text ?? ""
        let imagePath = selectedImagePath
        let name = self.nameTextField.text ?? ""
        let mobileNo = self.mobileNumTextField.text ?? ""
        
        let parameters = [
            "date": date,
            "image_path": imagePath,
            "name": name,
            "mobile_no": mobileNo
        ]
        
        if selectType == "BirthDay" {
            if eventBirthdayList[selectedReation_ID].isCreated == 0 {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    addBonusEventApi(parameters: parameters)
                }
            } else {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    ifUpdate = true
                    updateEventApi(parameters: parameters)
                }
            }
        } else {
            if eventanniversaryList[selectedReation_ID].isCreated == 0 {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    addBonusEventApi(parameters: parameters)
                }
            } else {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    ifUpdate = true
                    updateEventApi(parameters: parameters)
                }
            }
        }
    }
    
    @IBAction func camerBtnAction(_ sender: UIButton) {
        showMediaOptions()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Addddddd image tappeddddddd")
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getRelationApi() {
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.GET_EVENT_DETAILS_API)
        
        let parameters = [
            "bonus_id" : selectBonusID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash
        ] as [String : Any]
        
        print("getEvnt params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EventGetDetailsResponse.self, from: data)
                    
                    print("getEvnt welcome res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.eventDetails = response.parameters.relation
                            
                            self.nameTextField.text = self.eventDetails?.name
                            
                            self.dateTextField.text = self.eventDetails?.date

                            self.mobileNumTextField.text = self.eventDetails?.mobileNo
                                                        
                            if self.eventDetails?.imagePath != nil {
                                self.addImage.sd_setImage(with: URL(string: (self.eventDetails?.imagePath)!), placeholderImage: UIImage(named: "no_image"))
                            }
                        }
                    }
                    
                } catch {
                    print("getEvnt error res \(error)")
                }
            }
        }
    }
    
    func updateEventApi(parameters: [String: Any]) {
        self.showLoader()
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.UPDATE_EVENT_API)
        
        var parameters = parameters
        parameters["bonus_id"] = selectBonusID
        parameters[MobileRegisterConstant.merchant_id] = MobileRegisterConstant.merchant_id_value
        parameters[MobileRegisterConstant.auth_token] = hash
        parameters["image_path"] = "data:image/png;base64,\(imageURL)"
        
        print("updateEvent params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(UpdateEventDetailsResponse.self, from: data)
                    
                    print("updateEvent res \(response)")
                    DispatchQueue.main.async {
                        if !self.ifUpdate {
                            self.getRelationApi()
                        } else {
                            self.dismiss(animated: true)
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    print("updateEvent error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    func addBonusEventApi(parameters: [String: Any]) {
        
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
        let url = URL(string: ApiConstant.ADD_BONUS_API)
        
        var parameters = parameters
        parameters["customer_id"] = customerID
        parameters["outlet_id"] = outletId
        parameters["id"] = oID
        parameters[MobileRegisterConstant.merchant_id] = MobileRegisterConstant.merchant_id_value
        parameters[MobileRegisterConstant.auth_token] = hash
        parameters["relation_id"] = String(selectedReationID)
        parameters["image_path"] = "data:image/png;base64,\(imageURL)"
        
        print("AddBonusEvnt params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
                // Handle error
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    // Handle non-200 status code
                    self.hideLoader()
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddEventBonusResponse.self, from: data)
                    
                    print("AddBonusEvnt res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.dismiss(animated: true)

                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let profilePopupVC = storyboard.instantiateViewController(withIdentifier: "ProfilePopUpViewController") as! ProfilePopUpViewController

                            profilePopupVC.context = self
                            profilePopupVC.popUpmessage = response.message

                            profilePopupVC.modalPresentationStyle = .overCurrentContext
                            self.context?.present(profilePopupVC, animated: false, completion: nil)
                            
                            NotificationCenter.default.post(name: .addevntReload, object: "reload")
                            
                            let dismissalTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                profilePopupVC.dismiss(animated: true, completion: nil)
                            }
                            
                        } else {
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
                    print("AddBonusEvnt error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    func addEventApi() {
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
        let url = URL(string: ApiConstant.ADD_EVENT_API)
        
        let parameters = [
            "customer_id": customerID,
            "outlet_id": outletId,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("AddeEvnt params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddEventResponse.self, from: data)
                    
                    print("AddeEvnt welcome res \(response)")
                    
                    self.eventBirthdayList = response.parameters.birthday
                    self.eventanniversaryList = response.parameters.anniversary
                    
                    self.hideLoader()
                } catch {
                    print("AddeEvnt error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    func is_Valid(name: String, date: String, mobile_no: String) -> Bool {
        if name.isEmpty {
            showToast(message: "Enter name")
            return false
        }
        
        if date.isEmpty {
            showToast(message: "Select DOB")
            return false
        }
    
        if mobile_no.isEmpty {
            // Alert Message
            showSimpleAlert(view: self, message: "", title: "Please Enter Mobile Number")
            return false
        }
        
        let phoneNumber = mobile_no.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        
        if !phoneNumberPredicate.evaluate(with: phoneNumber) {
            // Alert Message
            showSimpleAlert(view: self, message: "", title: "Please Enter a Valid Phone number")
            return false
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === self.mobileNumTextField {
            let maxCharacter = 10
            let currentString = textField.text ?? ""
            let newString = (currentString as NSString).replacingCharacters(in: range, with: string)
            return newString.count <= maxCharacter
        }

        // For other text fields, do not apply the character limit
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        // Get the height of the keyboard
        let keyboardHeight = keyboardFrame.size.height
        
        // Move the view up by the keyboard height
        bgView.frame.origin.y = -keyboardHeight + 180
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Reset the view's position when the keyboard hides
        bgView.frame.origin.y = 0
    }
}

extension AddEventProfilePopupViewController {
    private func initialLoad() {
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        popupBgView.backgroundColor = UIColor.white
        popupBgView.layer.cornerRadius = 20
        setShadow(view: popupBgView)
        
        closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeBtn.tintColor = UIColor.gray
        
        headingLbl.text = "Browse Photo :"
        headingLbl.font = UIFont.boldSystemFont(ofSize: 18)
        headingLbl.textColor = UIColor.black
        
        cameraBtnView.backgroundColor = UIColor.white
        cameraBtnView.layer.cornerRadius = 20
        setShadow(view: cameraBtnView)
        
        cameraBtn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        cameraBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        addImage.layer.borderColor = UIColor.gray.cgColor
        addImage.layer.borderWidth = 1
        addImage.layer.cornerRadius = 60
        
        nameLbl.text = "Name :"
        nameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        nameLbl.textColor = UIColor.black
        
        nameView.backgroundColor = .clear
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        nameView.layer.cornerRadius = 10
        
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = .clear
        nameTextField.borderStyle = .none
        nameTextField.textColor = UIColor(named: "Dark")
        
        // Change the placeholder color
        let placeholderText = "Name"
        let namePlace: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray, // Change the color to your desired color
            // You can also customize other attributes like font, size, etc. if needed
        ]
        nameTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: namePlace)
        
        dateLbl.text = "Date :"
        dateLbl.font = UIFont.boldSystemFont(ofSize: 14)
        dateLbl.textColor = UIColor.black

        dateView.backgroundColor = .clear
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        dateView.layer.cornerRadius = 10

        dateTextField.placeholder = "Enter Dob"
        dateTextField.backgroundColor = .clear
        dateTextField.borderStyle = .none
        dateTextField.textColor = UIColor(named: "Dark")
        
        // Change the placeholder color
        let dateText = "Enter Dob"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray, // Change the color to your desired color
            // You can also customize other attributes like font, size, etc. if needed
        ]
        dateTextField.attributedPlaceholder = NSAttributedString(string: dateText, attributes: attributes)

        mobileNumLbl.text = "Mobile Number :"
        mobileNumLbl.font = UIFont.boldSystemFont(ofSize: 14)
        mobileNumLbl.textColor = UIColor.black

        mobileNumView.backgroundColor = .clear
        mobileNumView.layer.borderWidth = 1
        mobileNumView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        mobileNumView.layer.cornerRadius = 10

        mobileNumTextField.placeholder = "Mobile Number"
        mobileNumTextField.backgroundColor = .clear
        mobileNumTextField.borderStyle = .none
        mobileNumTextField.textColor = UIColor(named: "Dark")
        
        // Change the placeholder color
        let mobileText = "Mobile Number"
        let mobilePlace: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray, // Change the color to your desired color
            // You can also customize other attributes like font, size, etc. if needed
        ]
        mobileNumTextField.attributedPlaceholder = NSAttributedString(string: mobileText, attributes: mobilePlace)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(hexFromString: ColorConstant.GREEN)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 5
        setShadow(view: self.saveButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateLabelTapped))
        dateTextField.isUserInteractionEnabled = true
        dateTextField.addGestureRecognizer(tapGesture)
    }
        
    @objc func dateLabelTapped() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date() // Set maximum date to the current date
        datePicker.date = Date() // Set default date to the current date

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let attributedTitle = NSAttributedString(string: "Select Date", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ])

        alertController.setValue(attributedTitle, forKey: "attributedTitle")

        let contentViewController = UIViewController()
        contentViewController.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerXAnchor.constraint(equalTo: contentViewController.view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: contentViewController.view.centerYAnchor).isActive = true

        alertController.setValue(contentViewController, forKey: "contentViewController")

        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            let selectedDate = datePicker.date
            let formattedDate = formatter.string(from: selectedDate)

            self.dateTextField.textAlignment = .left
            self.dateTextField.textColor = .black
            self.dateTextField.text = formattedDate

            NotificationCenter.default.post(name: .dateDidChange, object: self.dateTextField.text)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)

        UIApplication.topMostViewController()?.present(alertController, animated: true, completion: nil)
    }


}

extension UIApplication {
    class func topMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        var topController = keyWindow?.rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
}

extension Notification.Name {
    static let addevntReload = Notification.Name("AddEventScreenRefresh")
}


extension AddEventProfilePopupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }

        self.addImage.image = selectedImage
        
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

