//
//  ThirdSectionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 08/06/23.
//

import UIKit

class ThirdSectionTableViewCell: UITableViewCell, UITextFieldDelegate {
    
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

    var relationId: String = ""
    var eventDetailsList: EventGetDetailsParameters?


    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLbl.text = "Name :"
        nameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        nameLbl.textColor = UIColor.black
        
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        nameView.layer.cornerRadius = 10
        
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = .clear
        nameTextField.borderStyle = .none
        
        dateLbl.text = "Date :"
        dateLbl.font = UIFont.boldSystemFont(ofSize: 14)
        dateLbl.textColor = UIColor.black
        
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        dateView.layer.cornerRadius = 10
        
        dateTextField.placeholder = "Enter Dob"
        dateTextField.backgroundColor = .clear
        dateTextField.borderStyle = .none
        
        mobileNumLbl.text = "Mobile Number :"
        mobileNumLbl.font = UIFont.boldSystemFont(ofSize: 14)
        mobileNumLbl.textColor = UIColor.black
        
        mobileNumView.layer.borderWidth = 1
        mobileNumView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        mobileNumView.layer.cornerRadius = 10
        
        mobileNumTextField.placeholder = "Mobile Number"
        mobileNumTextField.backgroundColor = .clear
        mobileNumTextField.borderStyle = .none
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @objc func dateTextFieldTapped() {
        dateLabelTapped()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n" {
            textView.text.removeLast()
            textView.resignFirstResponder()
        }
    }
    
    @objc func dateLabelTapped() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = Date() // Set default date to current date
                
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
            formatter.dateFormat = "yyyy-MM-dd" // Set date format to "yyyy-MM-dd"
            
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
        
        // Set the target and action for the dateTextField
        dateTextField.addTarget(self, action: #selector(dateTextFieldTapped), for: .touchDown)
        
        if let viewController = findViewController() {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }

        private func findViewController() -> UIViewController? {
            var viewController: UIViewController? = nil
            var responder: UIResponder? = self
            
            while responder != nil {
                responder = responder?.next
                if let controller = responder as? UIViewController {
                    viewController = controller
                    break
                }
            }
            
            return viewController
        }
}

extension Notification.Name {
    static let dateDidChange = Notification.Name("DateDidChangeNotification")
}
