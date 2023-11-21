//
//  AddEventViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 12/06/23.
//

import UIKit

class AddEventViewController: UIViewController, FirstSectionCollectionCollectionViewCellDelegate, AnniversaryCollectionCollectionViewCellDelegate, FirstSectionTableViewCellDelegate, BrowseSectionTableViewCellDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    func didSelectRelation(relationID: String) {
        print(">>>>>>>> \(selectedReationID)")
    }
    
    func eventImageTapAction(_ alert: AnniversaryCollectionViewCell, alertTag: Int) {
        selecteType = "Anniversary"
        
        selectedReationID = alertTag
        selectedReation_ID = eventanniversaryList[selectedReationID].relationID
        selectedbonus_id = eventanniversaryList[selectedReationID].bonusID
        
        if self.eventanniversaryList[alertTag].bonusID != 0 {
            getRelationApi()
        } else {
            self.eventDetails?.mobileNo = ""
            self.eventDetails?.date = ""
            self.eventDetails?.name = ""
        }
                
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddEventProfilePopupViewController") as! AddEventProfilePopupViewController
        vc.selectBonusID = selectedbonus_id
        vc.selectedReationID = selectedReation_ID
        vc.selectedReation_ID = selectedReationID
        vc.selectType = selecteType
        vc.context = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    func eventImageTapped(_ alert: FirstSectionCollectionCollectionViewCell, alertTag: Int) {
        selecteType = "BirthDay"
        
        selectedReationID = alertTag
        selectedReation_ID = eventBirthdayList[selectedReationID].relationID
        selectedbonus_id = eventBirthdayList[selectedReationID].bonusID
        
        if eventBirthdayList[alertTag].bonusID != 0 {
            getRelationApi()
        } else {
            self.eventDetails?.mobileNo = ""
            self.eventDetails?.date = ""
            self.eventDetails?.name = ""
        }
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddEventProfilePopupViewController") as! AddEventProfilePopupViewController
        vc.selectBonusID = selectedbonus_id
        vc.selectedReationID = selectedReation_ID
        vc.selectedReation_ID = selectedReationID
        vc.selectType = selecteType
        vc.context = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    func showImagePicker() {
        
        saveDetailsToUserDefaults()
        
        nameText = Detailscell.nameTextField.text!
        dateText = Detailscell.dateTextField.text!
        mobileText = Detailscell.mobileNumTextField.text!
        
        isImageSelection = true
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }

        // Get the image URL if available (this is optional)
        if let imageURL = info[.imageURL] as? URL {
            let imagePath = imageURL.path
            // Use the imagePath as needed
            self.selectedImagePath = imagePath
        }
        
        if let image = selectedImage {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                var base64Image = imageData.base64EncodedString(options: .lineLength64Characters)
                base64Image = base64Image.replacingOccurrences(of: " ", with: "")
                base64Image = base64Image.replacingOccurrences(of: "\n", with: "")
                self.imageURL = base64Image
            } else {
                print("Error converting image data to JPEG")
            }
        } else {
            print("Selected image is nil")
        }

        addEventTableView.reloadData()
        
        getDetailsFromUserDefaults()

        picker.dismiss(animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    @IBOutlet weak var addEventTableView: UITableView! {
        didSet {
            addEventTableView.register(FirstSectionTableViewCell.nib, forCellReuseIdentifier: FirstSectionTableViewCell.identifier)
            addEventTableView.register(AnniversaryTableViewCell.nib, forCellReuseIdentifier: AnniversaryTableViewCell.identifier)
            addEventTableView.register(BrowseSectionTableViewCell.nib, forCellReuseIdentifier: BrowseSectionTableViewCell.identifier)
            addEventTableView.register(ThirdSectionTableViewCell.nib, forCellReuseIdentifier: ThirdSectionTableViewCell.identifier)
            addEventTableView.separatorStyle = .none
            addEventTableView.dataSource = self
            addEventTableView.delegate = self
            addEventTableView.backgroundColor = .clear
            addEventTableView.showsVerticalScrollIndicator = false
            addEventTableView.showsHorizontalScrollIndicator = false
            addEventTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    var customerID: String = ""
    var oID: String = ""
    var outletId: String = ""
    var relationID: String = ""
    var selectedImagePath: String = ""
    var selecteType: String = ""
    var selectedReation_ID: String = ""
    
    var dateText: String = ""
    var nameText: String = ""
    var mobileText: String = ""
    var selectedImageBase64String: String = ""
    var selectedImage: UIImage?
    var imageURL: String = ""
    var isImageSelection: Bool = false
    
    var selectedReationID: Int = 0
    var selectedbonus_id: Int = 0
    var selectedBonusID: Int = 0
    var isSelect: Int = 0
    var birthdayEventCount: Int = 0
    var anniversaryEventCount: Int = 0
    var alertTag: Int = 0
    var selectedIndexPath: IndexPath?
    var isEnable = true
    
    var eventBirthdayList: [Anniversary] = []
    var eventanniversaryList: [Anniversary] = []
    var Detailscell: ThirdSectionTableViewCell!
    var eventDetails: Relation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = "Add Event"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reload(_:)),
                                               name: .addevntReload,
                                               object: nil)
        
        let keyboadrtapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(keyboadrtapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addEventApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.size.height
        
        // Adjust the content inset of the scroll view to avoid the keyboard
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        addEventTableView.contentInset = contentInset
        addEventTableView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Reset the content inset of the scroll view when the keyboard hides
        let contentInset = UIEdgeInsets.zero
        addEventTableView.contentInset = contentInset
        addEventTableView.scrollIndicatorInsets = contentInset
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func reload(_ notification: Notification) {
        if let object = notification.object as? String, object == "reload" {
            print("Notification received. Reloading...")
            self.addEventApi()
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
                    
                    self.birthdayEventCount = self.eventBirthdayList.count
                    self.anniversaryEventCount = self.eventanniversaryList.count
                    
                    DispatchQueue.main.async {
                        self.addEventTableView.reloadData()
                    }
                    
                    self.hideLoader()
                } catch {
                    print("AddeEvnt error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    func addBonusEventApi(parameters: [String: Any]) {
//        self.showLoader()
        
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
        parameters["relation_id"] = String(selectedReation_ID)
        parameters["image_path"] = "data:image/png;base64,\(imageURL)"
        
        print("AddBonusEvnt params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
                // Handle error
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    // Handle non-200 status code
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddEventBonusResponse.self, from: data)
                    
                    print("AddBonusEvnt res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            
                            self.addEventApi()
                            
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let profilePopupVC = storyboard.instantiateViewController(withIdentifier: "ProfilePopUpViewController") as! ProfilePopUpViewController
                            
                            profilePopupVC.context = self
                            profilePopupVC.popUpmessage = response.message
                            
                            
                            profilePopupVC.modalPresentationStyle = .overCurrentContext
                            self.present(profilePopupVC, animated: false, completion: nil)
                            
                            let dismissalTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                profilePopupVC.dismiss(animated: true, completion: nil)
                            }
                        } else {
                            
                            print(".....................")
                            
                            self.dismiss(animated: true)
                          
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.addEventTableView.reloadData()
                    }
                    
//                    self.hideLoader()
                } catch {
                    print("AddBonusEvnt error res \(error)")
//                    self.hideLoader()
                }
            }
        }
    }
    
    func updateEventApi(parameters: [String: Any]) {
        self.showLoader()
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.UPDATE_EVENT_API)
        
        var parameters = parameters
        parameters["bonus_id"] = selectedbonus_id
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
                    
                    self.getRelationApi()
                    
                    DispatchQueue.main.async {
                        self.addEventTableView.reloadData()
                    }
                    
                    self.hideLoader()
                } catch {
                    print("updateEvent error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    func getRelationApi() {
        //        self.showLoader()
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.GET_EVENT_DETAILS_API)
        
        let parameters = [
            "bonus_id" : selectedbonus_id,
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
                    
                    self.eventDetails = response.parameters.relation
                    
                    DispatchQueue.main.async {
                        self.addEventTableView.reloadData()
                    }
                    
                    //                    self.hideLoader()
                } catch {
                    print("getEvnt error res \(error)")
                    //                    self.hideLoader()
                }
            }
        }
    }
    
    func saveDetailsToUserDefaults() {
        let dateField = Detailscell.dateTextField.text!
        let mobileNumber = Detailscell.mobileNumTextField.text!
        let nameField = Detailscell.nameTextField.text!
        
        print(">?date>>> \(dateField)")
        print(">?mobileNumber>>> \(mobileNumber)")
        print(">?nameField>>> \(nameField)")


        let defaults = UserDefaults.standard
        defaults.set(dateField, forKey: "date")
        defaults.set(mobileNumber, forKey: "mobileNumber")
        defaults.set(nameField, forKey: "name")

        // Synchronize the data to disk (optional but can be useful to ensure data is saved immediately)
        defaults.synchronize()
    }
    
    func getDetailsFromUserDefaults() {
        let defaults = UserDefaults.standard

        if let dateField = defaults.string(forKey: "date") {
            Detailscell.dateTextField.text = dateField
            print(">? dateField \(dateField)")
        }

        if let mobileNumber = defaults.string(forKey: "mobileNumber") {
            Detailscell.mobileNumTextField.text = mobileNumber
            print(">? mobilrnumber \(mobileNumber)")
        }

        if let nameField = defaults.string(forKey: "name") {
            Detailscell.nameTextField.text = nameField
            print(">? name \(nameField)")
        }
    }
}

extension AddEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "FirstSectionTableViewCell", for: indexPath) as! FirstSectionTableViewCell
            
            cell.firstSectionCollectionView.showsHorizontalScrollIndicator = false
            cell.firstSectionCollectionView.layoutIfNeeded()
            
            cell.context = self
            cell.delegate = self
            cell.selectedRelationdelegate = self
            cell.selectionStyle = .none
            cell.birthdayList = self.eventBirthdayList
            cell.eventType = "Birthday"
            cell.headingLbl.text = "Birthday"
            
            cell.firstSectionCollectionView.reloadData()
            
            return cell
        } else {
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "AnniversaryTableViewCell", for: indexPath) as! AnniversaryTableViewCell
            
            cell.anniversaryCollectionView.showsHorizontalScrollIndicator = false
            cell.anniversaryCollectionView.layoutIfNeeded()
            
            cell.context = self
            cell.delegate = self
            cell.selectionStyle = .none
            
            cell.anniversaryList = self.eventanniversaryList
            cell.headingLbl.text = "Anniversary"
            
            cell.anniversaryCollectionView.reloadData()
            
            return cell
        }        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    
    @objc func saveBtnAction(_ sender: UIButton) {
        
        let date = Detailscell.dateTextField.text ?? ""
        let imagePath = selectedImagePath
        let name = Detailscell.nameTextField.text ?? ""
        let mobileNo = Detailscell.mobileNumTextField.text ?? ""
        
        let parameters = [
            "date": date,
            "image_path": imagePath,
            "name": name,
            "mobile_no": mobileNo
        ]
        
        if selecteType == "BirthDay" {
            if eventBirthdayList[selectedReationID].isCreated == 0 {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    addBonusEventApi(parameters: parameters)
                    self.addEventApi()
                }
            } else {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    updateEventApi(parameters: parameters)
                }
            }
        } else {
            if eventanniversaryList[selectedReationID].isCreated == 0 {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    addBonusEventApi(parameters: parameters)
                    self.addEventApi()
                }
            } else {
                if is_Valid(name: name, date: date, mobile_no: mobileNo) {
                    updateEventApi(parameters: parameters)
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
        if textField === Detailscell.mobileNumTextField {
            let maxCharacter = 10
            let currentString = textField.text ?? ""
            let newString = (currentString as NSString).replacingCharacters(in: range, with: string)
            return newString.count <= maxCharacter
        }

        // For other text fields, do not apply the character limit
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if birthdayEventCount == 3 {
                return 170
            } else if birthdayEventCount == 6 {
                return 340
            } else {
                return 400
            }
        } else {
            if anniversaryEventCount == 3 {
                return 170
            } else if birthdayEventCount == 6 {
                return 340
            } else {
                return 400
            }
        }
    }
}

