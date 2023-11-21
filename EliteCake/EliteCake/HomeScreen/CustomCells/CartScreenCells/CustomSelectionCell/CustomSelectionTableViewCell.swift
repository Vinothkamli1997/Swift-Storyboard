//
//  CustomSelectionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class CustomSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstBgView: UIView!
    @IBOutlet weak var nameBgView: UIView!
    @IBOutlet weak var timeBgView: UIView!
    
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var editImage2: UIImageView!
    @IBOutlet weak var editImage3: UIImageView!
    
    @IBOutlet weak var instructionField: UITextField!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var bdatTextField: UITextField!
    
    var setTime: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        firstBgView.backgroundColor = UIColor(named: "PureWhite")
        firstBgView.layer.cornerRadius = 10
        setLightShadow(view: firstBgView)
        
        nameBgView.backgroundColor = UIColor(named: "PureWhite")
        nameBgView.layer.cornerRadius = 10
        setLightShadow(view: nameBgView)
        
        timeBgView.backgroundColor = UIColor(named: "PureWhite")
        timeBgView.layer.cornerRadius = 10
        setLightShadow(view: timeBgView)
        
        editImage.image = UIImage(named: "notes")
        editImage2.image = UIImage(named: "bdayimage")
        editImage3.image = UIImage(named: "text")
        
        if let instruction = UserDefaults.standard.string(forKey: "Instruction"){
            self.instructionField.text = instruction
        }
        
        instructionField.placeholder = "Mention Your Speacial Instruction Here"
        instructionField.font = UIFont.systemFont(ofSize: 14)
        instructionField.borderStyle = .none
        instructionField.textColor = UIColor(named: "Dark")
        
        instructionField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let instructionText = "Add Birthday text Here"
        let instruction: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
        ]
        instructionField.attributedPlaceholder = NSAttributedString(string: instructionText, attributes: instruction)
        
        secondLbl.text = "Add Cake Cutting Time Here"
        
        if let bDay = UserDefaults.standard.string(forKey: "Bday"){
            self.bdatTextField.text = bDay
            self.bdatTextField.textColor = .black
        }
        
        bdatTextField.placeholder = "Add Birthday text Here"
        bdatTextField.font = UIFont.systemFont(ofSize: 14)
        bdatTextField.borderStyle = .none
        bdatTextField.textColor = UIColor(named: "Dark")
        
        bdatTextField.addTarget(self, action: #selector(bdaytextFieldDidChange(_:)), for: .editingChanged)
                
        if let cutTime = UserDefaults.standard.string(forKey: "cakeCutTime"){
            self.secondLbl.text = cutTime
        }
        
        let placeholderText = "Add Birthday text Here"
        let namePlace: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
        ]
        bdatTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: namePlace)

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeLabelTapped))
        secondLbl.isUserInteractionEnabled = true
        secondLbl.addGestureRecognizer(tapGesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let newText = textField.text {
            
            if newText.count > 24 {
                
                let truncatedText = String(newText.prefix(24))
                textField.text = truncatedText
                
                showAlert(message: "Allow 24 Character only")
                
            } else {
                print("Execute Elseeeeeeeeeeeeee")
            }
            
            if let instructionField = self.instructionField.text, !instructionField.isEmpty {
                UserDefaults.standard.set(instructionField, forKey: "Instruction")
            }
        }
    }

    @objc func bdaytextFieldDidChange(_ textField: UITextField) {
        if let newText = textField.text {
            
            if newText.count > 24 {
                
                let truncatedText = String(newText.prefix(24))
                textField.text = truncatedText
                
                showAlert(message: "Allow 24 Character only")
            }
            
            if let instructionField = self.instructionField.text, !instructionField.isEmpty {
                UserDefaults.standard.set(instructionField, forKey: "Bday")
            } else {
                UserDefaults.standard.removeObject(forKey: "Bday")
            }
        }
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
            self.secondLbl.textAlignment = .center // align center
            self.secondLbl.text = formatter.string(from: datePicker.date)
            self.secondLbl.textColor = .black
            
            if let cuttingTime = self.secondLbl.text, !cuttingTime.isEmpty {
                 UserDefaults.standard.set(cuttingTime, forKey: "cakeCutTime")
            } else {
                 UserDefaults.standard.removeObject(forKey: "cakeCutTime")
            }
            
            NotificationCenter.default.post(name: .timeDidChange, object: self.secondLbl.text)
        }


        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)

        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            alertController.popoverPresentationController?.sourceView = window
            alertController.popoverPresentationController?.sourceRect = self.contentView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

}

extension Notification.Name {
    static let timeDidChange = Notification.Name("TimeDidChangeNotification")
}

