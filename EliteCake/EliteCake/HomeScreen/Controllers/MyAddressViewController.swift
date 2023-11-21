//
//  MyAddressViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 19/04/23.
//

import UIKit

class MyAddressViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var addAddressView: UIView!
    
    @IBOutlet weak var addAddressLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var addressEmptyView: UIView!
    @IBOutlet weak var emptyAddressImage: UIImageView!
    @IBOutlet weak var emptyAddressLbl: UILabel!
    
    
    @IBOutlet weak var myAddressTableView: UITableView! {
        didSet {
            //Register TableView Cells
            myAddressTableView.register(MyAddressTableViewCell.nib, forCellReuseIdentifier: MyAddressTableViewCell.identifier)
            
            myAddressTableView.separatorStyle = .none
            myAddressTableView.dataSource = self
            myAddressTableView.delegate = self
            myAddressTableView.backgroundColor = .clear
            myAddressTableView.showsVerticalScrollIndicator = false
            myAddressTableView.showsHorizontalScrollIndicator = false
            myAddressTableView.tableFooterView = UIView()
        }
    }
    
    var customerID: String = ""
    var address: [Address] = []
    var selectedAddress_ID: String = ""
    var locationType: String = ""
    var house_no: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addressShowingApi()
        
        titleLbl.text = "My Address"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        addAddressLbl.text = "Add Address"
        addAddressLbl.font = UIFont.systemFont(ofSize: 16)
        
        addBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        addBtn.tintColor = UIColor.lightGray
        addBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        addAddressBtn.setTitle("Add Address", for: .normal)
        addAddressBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        addAddressBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        addressEmptyView.backgroundColor = .white
        
        emptyAddressLbl.text = "Save address to make delivery more convinent"
        emptyAddressLbl.textColor = UIColor.black
        emptyAddressLbl.font = UIFont.systemFont(ofSize: 14)
        
        emptyAddressImage.image = UIImage(named: "Adddressbook")
        
        bottomView.backgroundColor = UIColor.black
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addAddressView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressShowingApi()
    }
    
    func addressShowingApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.ADDRESS_Sowing_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: "",
            MobileRegisterConstant.auth_token: hash
        ] as [String : Any]
        
        print("Address Showing paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddressShowingResponse.self, from: data)
                    DispatchQueue.main.async {
                        if response.success {
                            print("Address Showing res \(response)")
                            self.address = response.parameters.address
                            
                            if self.address.count == 0 {
                                self.myAddressTableView.isHidden = true
                                self.addressEmptyView.isHidden = false
                            } else {
                                self.myAddressTableView.isHidden = false
                                self.addressEmptyView.isHidden = true
                            }
                        } else {
                            print("Response false")
                        }
                    }

                    DispatchQueue.main.async {
                        self.myAddressTableView.reloadData()
                    }
                } catch {
                    print("AddressShowing Error \(error)")
                }
            }
        }
    }
    
    func removeAddressApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
                
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.REMOVE_ADDESS_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: "",
            MobileRegisterConstant.auth_token: hash,
            "customer_address_id" : selectedAddress_ID,
            "type" : locationType
        ] as [String : Any]
        
        print("remove Address paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(AddressRemoveResponse.self, from: data)
                    
                    print("remove Address res \(json)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.addressShowingApi()
                        }
                    }
                } catch {
                    print("remove Address error \(error)")
                }
            }
        }
    }
    
    func AddressDefaultEditApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
                
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.ADDRESS_DEFAULT_EDIT_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.auth_token: hash,
            "customer_address_id" : selectedAddress_ID,
        ] as [String : Any]
        
        print("AddressDefaultEdit paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(AddressDefaultEditResponse.self, from: data)
                    
                    print("AddressDefaultEdit res \(json)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                } catch {
                    print("AddressDefaultEdit error \(error)")
                }
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func emptyAddressBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTap() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyAddressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("addrss count \(address.count)")
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myAddressTableView.dequeueReusableCell(withIdentifier: "MyAddressTableViewCell", for: indexPath) as! MyAddressTableViewCell
        
        cell.selectionStyle = .none
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnAction(_:)), for: .touchUpInside)
        
//        let fullAddress = address[indexPath.row].area
//        let startIndex = fullAddress.firstIndex(of: ",") ?? fullAddress.startIndex
//        let trimmedAddress = String(fullAddress[..<startIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
//
//        self.house_no = address[indexPath.row].houseNo
//
//        cell.addressLbl.text = self.house_no + ", " + address[indexPath.row].area

        cell.addressLbl.text = address[indexPath.row].houseNo
        cell.addressTypeLbl.text = address[indexPath.row].type
        
        if address[indexPath.row].type == "Current Location" {
            cell.mapBtn.setImage(UIImage(named: "Map"), for: .normal)
            cell.mapBtn.tintColor = .lightGray
        } else if address[indexPath.row].type == "Work" {
            cell.mapBtn.setImage(UIImage(systemName: "case.fill"), for: .normal)
        } else if address[indexPath.row].type == "Home" {
            cell.mapBtn.setImage(UIImage(named: "home-button"), for: .normal)
        } else {
            cell.mapBtn.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAddress_ID = self.address[indexPath.row].customerAddressID
        print("selected Count \(indexPath.row), \(self.selectedAddress_ID)")
        AddressDefaultEditApi()
    }
    
    @objc func deleteBtnAction(_ sender: UIButton) {
        
        let row = sender.tag
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
            
            vc.screenType = "Edit"
            
            vc.addres_ID = self.address[row].customerAddressID
            
            let fullAddress = self.address[row].houseNo
            
            let addressArr = fullAddress.components(separatedBy: ",")
            
            vc.editAddress = addressArr[0]
            vc.addressValue = self.address
            
            if addressArr.count > 1 {
                vc.floorAddress = addressArr[1]
            } else if addressArr.count > 2 {
                vc.floorAddress = addressArr[1]
                vc.floorAddress = addressArr[2]
            } else {
                vc.floorAddress = "Default Floor Address"
            }

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        alert.addAction(editAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { _ in
            print("Delete")
            
            self.selectedAddress_ID = self.address[row].customerAddressID
            self.locationType = self.address[row].type
            
            self.removeAddressApi()
        }
        
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            print("Cancel")
        }
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
