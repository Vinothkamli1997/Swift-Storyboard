//
//  NotificationViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 20/03/23.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var notificationTableView: UITableView! {
        didSet {
            //Register TableView Cells
            notificationTableView.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.identifier)

            notificationTableView.separatorStyle = .none
            notificationTableView.dataSource = self
            notificationTableView.delegate = self
            notificationTableView.backgroundColor = .clear
            notificationTableView.showsVerticalScrollIndicator = false
            notificationTableView.showsHorizontalScrollIndicator = false
            notificationTableView.tableFooterView = UIView()
        }
    }
    
    var customerID: String = ""
    var notificationValues: [NotificationParameter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLbl.text = "Notification"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.textColor = .black
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationApi()
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func NotificationApi() {
        self.showLoader()
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.notificationApi)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
                
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(NotificationResponse.self, from: data)
                    
                    if response.success {
                        self.notificationValues = response.parameters
                    }
                    
                    DispatchQueue.main.async {
                        self.notificationTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("notification error res \(error)")
                }
            }
        }
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell

        if notificationValues.count > 0 {
            cell.contentLbl.text = notificationValues[indexPath.row].message
            cell.dateTimeLbl.text = notificationValues[indexPath.row].createdAt
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }
}
