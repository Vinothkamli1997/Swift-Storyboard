//
//  NewDownlineViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 01/09/23.
//

import UIKit

class NewDownlineViewController: UIViewController {
    
    @IBOutlet weak var newDownLineTableView: UITableView! {
        didSet {
            newDownLineTableView.register(NewDownlineTableViewCell.nib, forCellReuseIdentifier: NewDownlineTableViewCell.identifier)
            
            newDownLineTableView.separatorStyle = .none
            newDownLineTableView.dataSource = self
            newDownLineTableView.delegate = self
            newDownLineTableView.backgroundColor = .clear
            newDownLineTableView.showsVerticalScrollIndicator = false
            newDownLineTableView.showsHorizontalScrollIndicator = false
            newDownLineTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var selectMinLbl: UILabel!
    @IBOutlet weak var selectValueLbl: UILabel!
    
    @IBOutlet weak var claimBtn: UIButton!
    @IBOutlet weak var claimLbl: UILabel!

    var rangeID: String = ""
    var customerID: String = ""
    var selectValue: String = ""
    var downLineID: [String] = []
    var downLine: String = ""
    
    var downlineValues: [DowlineParameter] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        newDownLineTableView.backgroundColor = .white

        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        titleLbl.text = "My Downline"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        contentLbl.text = "Claim of Cash Reward can be made only once per user ID"
        contentLbl.textColor = .black
        contentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        selectMinLbl.text = "Select Min - "
        selectMinLbl.textColor = .black
        contentLbl.font = UIFont.systemFont(ofSize: 14)
        
        selectValueLbl.text = selectValue
        selectValueLbl.textColor = .black
        selectValueLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        claimBtn.setImage(UIImage(named: "green-btn")?.withRenderingMode(.alwaysOriginal), for: .normal)

        claimLbl.text = "Calim"
        claimLbl.textColor = .white
        claimLbl.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        downLineApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func claimBtnAction(_ sender: UIButton) {
        if downLineID.count == Int(rangeID) {
            downLine = downLineID.joined(separator: ",")
            
            EarnCashCheckClaimApi()
        } else {
            showAlert(message: "Select \(rangeID) Items")
        }
    }
    
    func downLineApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.downlineApi)
        
        let parameters = [
            MobileRegisterConstant.auth_token:hash,
            "customer_id":customerID,
        ] as [String : Any]
        
        print("DownLine params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.showToast(message: "Api Status \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(DownLineResponse.self, from: data)
                    print("DownLine Response \(response)")
                    DispatchQueue.main.async {
                        if response.success {
                            self.downlineValues = response.parameters!
                        } else {
                            showAlert(message: response.message)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.newDownLineTableView.reloadData()
                    }
    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("DownLine error res \(error)")
                }
            }
        }
    }
    
    
    func EarnCashCheckClaimApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.newDownLineApi)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "amount": selectValue,
            "range_id": rangeID,
            "downline_cus_id": downLine
        ] as [String : Any]
        
        print("Earnclaim params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EarnCheckClaimResponse.self, from: data)
                    print("EarnClaim Response \(response)")
                    
                    if response.success {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    DispatchQueue.main.async {
                        self.newDownLineTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("EarnClaim error res \(error)")
                }
            }
        }
    }
}

extension NewDownlineViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downlineValues.count
//        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newDownLineTableView.dequeueReusableCell(withIdentifier: "NewDownlineTableViewCell", for: indexPath) as! NewDownlineTableViewCell
        
        cell.nameLbl.text = self.downlineValues[indexPath.row].customerName
        cell.coinValueLbl.text = self.downlineValues[indexPath.row].coin
        cell.dojValueLbl.text = self.downlineValues[indexPath.row].dateOfBirth

        if let urlString = downlineValues[indexPath.row].customeImage!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image")
            cell.leadingImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        }

        cell.checkBoxBtn.tag = indexPath.row
        cell.checkBoxBtn.addTarget(self, action: #selector(checkBoxBtnAction(_:)), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    @objc func checkBoxBtnAction(_ sender: UIButton) {
        let row = sender.tag
        
        DispatchQueue.main.async {
            sender.isSelected = !sender.isSelected
            
            if sender.isSelected {
                sender.tintColor = UIColor.red
                
                let customerDetailsID = self.downlineValues[row].customerDetailsID!
                
                self.downLineID.append(customerDetailsID)
                
            } else {
                sender.tintColor = UIColor.gray
                
                let customerDetailsID = self.downlineValues[row].customerDetailsID!
                if let index = self.downLineID.firstIndex(of: customerDetailsID) {
                    self.downLineID.remove(at: index)
                }
            }
        }
    }
}

