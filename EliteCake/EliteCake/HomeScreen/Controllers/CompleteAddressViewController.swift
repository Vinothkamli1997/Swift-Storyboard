//
//  CompleteAddressViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/04/23.
//

import UIKit

class CompleteAddressViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var completeAddressbgView: UIView!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationBtn: UIButton!
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var homeBtn: UIButton!
    
    @IBOutlet weak var workView: UIView!
    @IBOutlet weak var workBtn: UIButton!
    
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var otherBtn: UIButton!
    
    @IBOutlet weak var enterLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var floorNoView: UIView!
    @IBOutlet weak var floorfield: UITextField!
    
    @IBOutlet weak var landMarkView: UIView!
    @IBOutlet weak var landMarkfiled: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    var isRequired: Bool = false
    var selectedAddress: String = ""
    var phoneNumber: String = ""
    var customerID: String = ""
    var houseAddress: String = ""
    var selectedType: String = "Current Location"
    var editAddress: String = ""
    var floorAddress: String = ""
    var screenType: String = ""
    var addres_ID: String = ""
    var floorAddressValue: String = ""
    
    var context: UINavigationController!
    
    var latitude: Double?
    var longitude: Double?
    var address: [Address] = []
    
    var originalContentViewY: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        completeAddressbgView.backgroundColor = UIColor.white
        completeAddressbgView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        
        locationBtn.setImage(UIImage(systemName: "location.circle"), for: .normal)
        locationBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        workBtn.tintColor = UIColor.gray
        homeBtn.tintColor = UIColor.gray
        otherBtn.tintColor = UIColor.gray
        
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.gray.cgColor
        locationView.layer.cornerRadius = 10
        
        homeView.layer.borderWidth = 1
        homeView.layer.borderColor = UIColor.gray.cgColor
        homeView.layer.cornerRadius = 10
        
        homeBtn.setImage(UIImage(systemName: "house"), for: .normal)
        
        workView.layer.borderWidth = 1
        workView.layer.borderColor = UIColor.gray.cgColor
        workView.layer.cornerRadius = 10
        
        workBtn.setImage(UIImage(systemName: "case.fill"), for: .normal)
        
        otherView.layer.borderWidth = 1
        otherView.layer.borderColor = UIColor.gray.cgColor
        otherView.layer.cornerRadius = 10
        
        otherBtn.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        
        enterLbl.text = "Enter Complete Address"
        enterLbl.textColor = UIColor.black
        enterLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        bottomView.layer.backgroundColor = UIColor.gray.cgColor
        
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor.gray.cgColor
        addressView.layer.cornerRadius = 10
        
        addressField.placeholder = "Complete Address"
        addressField.backgroundColor = .clear
        addressField.borderStyle = .none
        
        floorNoView.layer.borderWidth = 1
        floorNoView.layer.borderColor = UIColor.gray.cgColor
        floorNoView.layer.cornerRadius = 10
        
        floorfield.placeholder = "Floor no"
        floorfield.backgroundColor = .clear
        floorfield.borderStyle = .none
        
        landMarkView.layer.borderWidth = 1
        landMarkView.layer.borderColor = UIColor.gray.cgColor
        landMarkView.layer.cornerRadius = 10
        
        landMarkfiled.placeholder = "Nearby landMark (optional)"
        landMarkfiled.backgroundColor = .clear
        landMarkfiled.borderStyle = .none
        
        saveBtn.setTitle("Save Address", for: .normal)
        saveBtn.tintColor = UIColor.white
        saveBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        saveBtn.layer.cornerRadius = 20
        setShadow(view: saveBtn)
        
        UITextField.connectFields(fields: [landMarkfiled, floorfield, addressField])
        
        self.addressField.text = editAddress
        self.floorfield.text = floorAddress
        
        floorfield.text = floorAddressValue
        
        floorfield.delegate = self
        floorfield.returnKeyType = .done
        floorfield.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
        
        landMarkfiled.returnKeyType = .done
        landMarkfiled.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
        
        addressField.delegate = self
        addressField.returnKeyType = .done
        addressField.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Store the original Y position of the contentView
        originalContentViewY = completeAddressbgView.frame.origin.y
    }
    
    func addAddressApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let phone = UserDefaults.standard.string(forKey: "phoneNumber"){
            phoneNumber = phone
            print("phoneNumber \(phoneNumber)")
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.ADD_ADDRESS_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: "",
            MobileRegisterConstant.auth_token: hash,
            "area": selectedAddress,
            "latitude": String(latitude!),
            "longitude": String(longitude!),
            "house_no": self.addressField.text! + "," + self.floorfield.text!,
            "mobile": phoneNumber,
            "type": selectedType,
            "customer_name": "",
            "name": ""
        ] as [String : Any]
        
        print("Add Address paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddAddressResponse.self, from: data)
                    
                    print("add Address res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.dismiss(animated: true)
                            self.context.popViewController(animated: true)
                        }
                    }
                } catch {
                    print("add Address error \(error)")
                }
            }
        }
    }
    
    func editAddressApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let phone = UserDefaults.standard.string(forKey: "phoneNumber"){
            phoneNumber = phone
            print("phoneNumber \(phoneNumber)")
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.EDIT_ADDRESS_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: "",
            MobileRegisterConstant.auth_token: hash,
            "customer_address_id" : addres_ID,
            "type" : selectedType,
            "name": "",
            "longitude": String(longitude!),
            "latitude": String(latitude!),
            "area": selectedAddress,
            "house_no": self.addressField.text! + "," + self.floorfield.text!,
            "customer_name": "",
            "mobile": phoneNumber
        ] as [String : Any]
        
        print("edit Address paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddressRemoveResponse.self, from: data)
                    
                    print("edit Address res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.dismiss(animated: true)
                            self.context.popViewController(animated: true)
                        }
                    }
                } catch {
                    print("edit Address error \(error)")
                }
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func locationBtnAction(_ sender: UIButton) {
        selectedType = "Current Location"
        
        locationBtn.setImage(UIImage(systemName: "location.circle"), for: .normal)
        locationBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        locationBtn.isSelected = true
        
        workBtn.tintColor = UIColor.gray
        homeBtn.tintColor = UIColor.gray
        otherBtn.tintColor = UIColor.gray
    }
    
    @IBAction func homeBtnAction(_ sender: UIButton) {
        selectedType = "Home"
        
        homeBtn.setImage(UIImage(systemName: "house.fill"), for: .normal)
        homeBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        homeBtn.isSelected = true
        
        workBtn.tintColor = UIColor.gray
        locationBtn.tintColor = UIColor.gray
        otherBtn.tintColor = UIColor.gray
    }
    
    @IBAction func workBtnAction(_ sender: UIButton) {
        selectedType = "Work"
        
        workBtn.setImage(UIImage(systemName: "case.fill"), for: .normal)
        workBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        workBtn.isSelected = true
        
        homeBtn.tintColor = UIColor.gray
        locationBtn.tintColor = UIColor.gray
        otherBtn.tintColor = UIColor.gray
    }
    
    @IBAction func otherBtnAction(_ sender: UIButton) {
        selectedType = "Other"
        
        otherBtn.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        otherBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        otherBtn.isSelected = true
        
        homeBtn.tintColor = UIColor.gray
        locationBtn.tintColor = UIColor.gray
        workBtn.tintColor = UIColor.gray
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        if self.addressField.text!.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Please Enter Your Address", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            if screenType == "Edit" {
                editAddressApi()
            } else {
                addAddressApi()
            }
        }
    }
    
    @objc func doneButtonPressed() {
        view.endEditing(true) // Hide the keyboard
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Calculate the necessary offset to move the contentView up when the keyboard appears
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let safeAreaBottomInset = view.safeAreaInsets.bottom
            let offsetY = keyboardHeight - safeAreaBottomInset
            UIView.animate(withDuration: 0.3) {
                self.completeAddressbgView.frame.origin.y = self.originalContentViewY - offsetY
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Move the contentView back to its original position when the keyboard is hidden
        UIView.animate(withDuration: 0.3) {
            self.completeAddressbgView.frame.origin.y = self.originalContentViewY
        }
    }

    // UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Handle the return key
        doneButtonPressed()
        return true
    }

    // Don't forget to remove observers in deinit or viewWillDisappear to avoid memory leaks
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
