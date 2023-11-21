//
//  DownLineViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 29/07/23.
//

import UIKit

class DownLineViewController: UIViewController {
    
    @IBOutlet weak var downLineTableView: UITableView! {
        didSet {
            downLineTableView.register(DownlineTableViewCell.nib, forCellReuseIdentifier: DownlineTableViewCell.identifier)
            
            downLineTableView.separatorStyle = .none
            downLineTableView.dataSource = self
            downLineTableView.delegate = self
            downLineTableView.backgroundColor = .clear
            downLineTableView.showsVerticalScrollIndicator = false
            downLineTableView.showsHorizontalScrollIndicator = false
            downLineTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    var customerID: String = ""
    var downlineValues: [DowlineParameter] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        titleLbl.text = "My Downline"
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Create a UIImageView with the background image
        let backgroundImage = UIImage(named: "BackgroundImage")
        downLineTableView.backgroundView = UIImageView(image: backgroundImage)
        downLineTableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    override func viewWillAppear(_ animated: Bool) {
        downLineApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
                        self.downLineTableView.reloadData()
                    }
    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("DownLine error res \(error)")
                }
            }
        }
    }
}


extension DownLineViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return downlineValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = downLineTableView.dequeueReusableCell(withIdentifier: "DownlineTableViewCell", for: indexPath) as! DownlineTableViewCell
        
        
        cell.nameLbl.text = self.downlineValues[indexPath.row].customerName
        cell.coinValueLbl.text = self.downlineValues[indexPath.row].coin
        cell.dojValueLbl.text = self.downlineValues[indexPath.row].dateOfBirth

        if let urlString = downlineValues[indexPath.row].customeImage!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image")
            cell.leadingImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
