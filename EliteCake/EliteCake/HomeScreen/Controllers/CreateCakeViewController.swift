//
//  CreateCakeViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 09/03/23.
//

import UIKit
import iOSDropDown

class CreateCakeViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var cameraBtnView: UIView!
    @IBOutlet weak var imageBgView: UIView!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var dropDown: DropDown!

    @IBOutlet weak var deliveryDateView: UIView!
    @IBOutlet weak var deliveryDateLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var timeView: UIView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var addImage: UIImageView!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timevalueLbl: UILabel!
    
    var customerID: String = ""
    var oID: String = ""
    var outlet_id: String = ""
    var dropDownSelectIndex: Int = 0
    var sizeID: String = ""
    var imageURL: String = ""

    var getSizeAray: [GetSizeDratilsParameter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetSizeDetailsApi()
    }
    
    func setUp() {
        titleLbl.text = "Customised Cake Quotation"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        sizeLbl.text = "Size"
        sizeLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        deliveryDateLbl.text = "Delivery Date"
        deliveryDateLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        deliveryDateView.layer.borderColor = UIColor.gray.cgColor
        deliveryDateView.backgroundColor = UIColor.white
        deliveryDateView.layer.borderWidth = 1
        deliveryDateView.layer.cornerRadius = 10
        
        timeLbl.text = "Time"
        timeLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        timeView.layer.borderColor = UIColor.gray.cgColor
        timeView.backgroundColor = UIColor.white
        timeView.layer.borderWidth = 1
        timeView.layer.cornerRadius = 10
        
        cameraBtnView.backgroundColor = UIColor.white
        cameraBtnView.layer.cornerRadius = 10
        setShadow(view: cameraBtnView)
        
        cameraBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        submitBtn.setTitle("Get Quote", for: .normal)
        submitBtn.tintColor = UIColor.white
        setShadow(view: submitBtn)
        
        addImage.layer.borderColor = UIColor.gray.cgColor
        addImage.layer.borderWidth = 1
        addImage.layer.cornerRadius = 10
        
        dateLbl.text = "Date"
        dateLbl.textAlignment = .center
        
        if dateLbl.text == "Date" {
            dateLbl.text = "Date"
            dateLbl.textColor = UIColor.lightGray
            dateLbl.font = UIFont.systemFont(ofSize: 14)
        } else {
            dateLbl.textColor = UIColor.black
            dateLbl.font = UIFont.systemFont(ofSize: 14)
        }
        
        timevalueLbl.text = "Time"
        timevalueLbl.textAlignment = .center
        
        if timevalueLbl.text == "Time" {
            timevalueLbl.text = "Time"
            timevalueLbl.textColor = UIColor.lightGray
            timevalueLbl.font = UIFont.systemFont(ofSize: 14)
        } else {
            timevalueLbl.textColor = UIColor.black
            timevalueLbl.font = UIFont.systemFont(ofSize: 14)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateLabelTapped(_:)))
        dateLbl.isUserInteractionEnabled = true
        dateLbl.addGestureRecognizer(tapGesture)
        
        let timeTapGesture = UITapGestureRecognizer(target: self, action: #selector(timeLabelTapped))
        timevalueLbl.isUserInteractionEnabled = true
        timevalueLbl.addGestureRecognizer(timeTapGesture)
        
        // Set the optional ID values
        dropDown.optionIds = [1, 23, 54, 22]
        
        // Set the row height to 50
        dropDown.rowHeight = 50
        
        // Disable search
        dropDown.isSearchEnable = false
        
        // Set the selected row color to white
        dropDown.selectedRowColor = UIColor.white
        
        // Set the arrow size to 15
        dropDown.arrowSize = 15
        
        // Set the content mode to center
        dropDown.contentMode = .center
        
        // Assuming 'dropDown' is your DropDown instance
        dropDown.layer.borderWidth = 1
        dropDown.layer.borderColor = UIColor.gray.cgColor
        
        dropDown.selectedRowColor = UIColor.white
        
        // Set the font to system font with size 12
        dropDown.font = UIFont.boldSystemFont(ofSize: 12)
        dropDown.layer.borderColor = UIColor.black.cgColor
        dropDown.layer.cornerRadius = 10
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        imageBgView.addGestureRecognizer(imageTapGesture)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "CreateCake")

        // Synchronize UserDefaults to persist the changes immediately
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func camerBtnAction(_ sender: UIButton) {
        
        //Allow Gallery Access
        let alert = UIAlertController(title: "Choose", message: "Select media type.", preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "Use Gallery", style: .default) { UIAlertAction in
            
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)
        }
        
        let camera = UIAlertAction(title: "Use Camera", style: .default) { UIAlertAction in
            
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .camera
            image.allowsEditing = true
            self.present(image, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(gallery)
        alert.addAction(camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        if isValid() {
            GetSizeDetailsSaveApi()
        }
    }
    
    func isValid() -> Bool {
        if imageURL.isEmpty {
           showAlert(message: "Select an image")
           return false
       } else if dateLbl.text == "Date" {
            showAlert(message: "Select Date")
            return false
        } else if timevalueLbl.text == "Time" {
            showAlert(message: "Select Time")
            return false
        }
        return true
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
    
    func GetSizeDetailsApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
            }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
            }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
            }
        
        let hash = md5(string: ApiConstant.salt_key + outlet_id)
        let url = URL(string: ApiConstant.getSizeDetails)
        
        let parameters = [
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID
        ] as [String : Any]
        
        print("getSize Details params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(GetSizeDratilsResponse.self, from: data)
                    
                    print("getSize Details params \(response)")
                    
                    if response.success {
                        self.getSizeAray = response.parameters
                    }
                    
                    var sizeNameArray: [String] = []
                    var sizeName: [String] = []
                    var sizeUnitIds: [Int] = []

                    for size in self.getSizeAray {
                        sizeNameArray.append(size.sizeName + size.unit.unitName)
                        sizeName.append(size.unit.unitName)
                        
                        if let sizeIDInt = Int(size.sizeID) {
                            sizeUnitIds.append(sizeIDInt)
                        } else {
                            print("Invalid size ID: \(size.sizeID)")
                        }
                    }
                    
                    
                    DispatchQueue.main.async {
                        
                        self.dropDown.optionArray = sizeNameArray
                        self.dropDown.optionIds = sizeUnitIds
                        
                        self.dropDown.didSelect { [weak self] (selectedText, index, id) in
                            self?.sizeID = String(id)
                        }
                        
                        // Set the initially selected item to the first item in the dropdown
                        if let firstItem = sizeNameArray.first {
                            self.dropDown.text = firstItem
                            
                            self.sizeID = self.getSizeAray[0].sizeID
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("cakedetail error res localize \(error)")
                }
            }
        }
    }
    
    //Cake Detail API
    func GetSizeDetailsSaveApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id) {
            customerID = customer_id
            }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
            }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id) {
            outlet_id = id
            }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.getSizeSaveDetails)
        
        var parameters = [
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "time": self.timevalueLbl.text!,
            "size_id": sizeID,
            "date": dateLbl.text!
        ] as [String : Any]
        
        if !imageURL.isEmpty {
             parameters["image_path"] = "data:image/png;base64,\(imageURL)"
        }
        
        
        print("getSize Details params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(SizeDratilsSaveResponse.self, from: data)
                    
                    print("getSize Details res \(response)")
                    
                    if response.success {
                        
                        UserDefaults.standard.setValue("Show", forKey: "CreateCake")
                        
                        DispatchQueue.main.async {
                            self.dateLbl.text = "Date"
                            self.dateLbl.textColor = .lightGray
                            
                            self.timevalueLbl.text = "Time"
                            self.timevalueLbl.textColor = .lightGray
                            
                            self.navigationController?.popViewController(animated: true)
                        }
                    }

                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("cakedetail error res localize \(error)")
                }
            }
        }
    }
    
    @objc func dateLabelTapped(_ sender: UITapGestureRecognizer) {
         let datePicker = UIDatePicker()
         datePicker.datePickerMode = .date
         datePicker.minimumDate = Date() // Restrict past dates
         datePicker.setDate(Date(), animated: true)
         
         let contentViewController = UIViewController()
         contentViewController.view.addSubview(datePicker)
         datePicker.translatesAutoresizingMaskIntoConstraints = false
         datePicker.centerXAnchor.constraint(equalTo: contentViewController.view.centerXAnchor).isActive = true
         datePicker.centerYAnchor.constraint(equalTo: contentViewController.view.centerYAnchor).isActive = true
         
         let alertController = UIAlertController(title: "Select Date", message: nil, preferredStyle: .actionSheet)
         let attributedTitle = NSAttributedString(string: "Select Date", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
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
                
                let dateText = "\(year)-\(month)-\(day)"
                print(dateText)
                
                self.dateLbl.textAlignment = .left
                
                self.dateLbl.text = "\(year)-\(month)-\(day)"
                
                self.dateLbl.textColor = UIColor.black
                self.dateLbl.textAlignment = .center
            }
        }
         
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         
         alertController.addAction(doneAction)
         alertController.addAction(cancelAction)
         
         if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
              alertController.popoverPresentationController?.sourceView = window
              alertController.popoverPresentationController?.sourceRect = self.dateLbl.bounds
              alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
         }
         
         UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc func timeLabelTapped() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time

        // Set default date to current time
        datePicker.setDate(Date(), animated: true)

        let contentViewController = UIViewController()
        contentViewController.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerXAnchor.constraint(equalTo: contentViewController.view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: contentViewController.view.centerYAnchor).isActive = true

        let alertController = UIAlertController(title: "Select Time", message: nil, preferredStyle: .actionSheet)

        // Increase font size of title
        let attributedTitle = NSAttributedString(string: "Select Time", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        alertController.setValue(attributedTitle, forKey: "attributedTitle")

        alertController.setValue(contentViewController, forKey: "contentViewController")

        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            self.timevalueLbl.textAlignment = .center // align center
            self.timevalueLbl.text = formatter.string(from: datePicker.date)
            self.timevalueLbl.textColor = .black
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)

        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            alertController.popoverPresentationController?.sourceView = self.timevalueLbl // Use the label as the source view
            alertController.popoverPresentationController?.sourceRect = self.timevalueLbl.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension CreateCakeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
          
          picker.dismiss(animated: true, completion: nil)

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
