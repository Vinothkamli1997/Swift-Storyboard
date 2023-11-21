//
//  AccountViewController.swift
//  EliteCake
//
//  Created by apple on 09/01/23.
//

import UIKit
import GoogleSignIn

class AccountViewController: UIViewController {
    
    @IBOutlet weak var accountTableView: UITableView! {
        didSet {
            //Register TableView Cells
            accountTableView.register(AccountHeaderTableViewCell.nib, forCellReuseIdentifier: AccountHeaderTableViewCell.identifier)
            accountTableView.register(WalletAndLikeTableViewCell.nib, forCellReuseIdentifier: WalletAndLikeTableViewCell.identifier)
            accountTableView.register(ListSectionTableViewCell.nib, forCellReuseIdentifier: ListSectionTableViewCell.identifier)
            accountTableView.register(LogoutTableViewCell.nib, forCellReuseIdentifier: LogoutTableViewCell.identifier)
            accountTableView.separatorStyle = .none
            accountTableView.dataSource = self
            accountTableView.delegate = self
            accountTableView.backgroundColor = .clear
            accountTableView.showsVerticalScrollIndicator = false
            accountTableView.showsHorizontalScrollIndicator = false
            accountTableView.tableFooterView = UIView()
        }
    }
    
    var loginScreen: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    var backButtonAction: Bool = true
    
    
    let listHeading = ["Your Rating", "My Referral ID", "Add Event", "Order History",/* "Your Offers",*/ "Earn Cash", "Address Book", "Card Management", "About us", "Help Center"]
    
    let headingIcon = ["star.circle", "giftcard.fill", "clock.circle", "calendar.badge.plus", "percent", "creditcard", "text.book.closed",
    "list.bullet.rectangle.fill", "info.circle.fill", "questionmark.circle.fill"]
    
    var customerID: String = ""
    var outlet_id: String = ""
    var accountDetails: AccountParameters?
    var ratingDetails: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        accountApi()
//        ratingApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            self.ratingApi()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.accountApi()
    }
    
    func accountApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.ACCOUNT_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID
        ] as [String : Any]
        
        print("Account params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AccountResponse.self, from: data)
                    print("Account Response \(response)")
                    
                    self.accountDetails = response.parameters
                    
                    DispatchQueue.main.async {
                        self.accountTableView.reloadData()
                    }
                    self.hideLoader()
//                    DispatchQueue.main.async {
//                        hideCustomLoader()
//                    }
                } catch {
                    self.hideLoader()
//                    DispatchQueue.main.async {
//                        hideCustomLoader()
//                    }
                    print("Account error res \(error)")
                }
            }
        }
    }
    
    func ratingApi() {
        
//        self.showLoader()
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.RATING_API)
        
        let parameters = [
            "outlet_id": outlet_id,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID
        ] as [String : Any]
        
        print("Rating params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(RatingResponse.self, from: data)
                    print("Rating Response \(response)")
                    
                    if let myValue = response.parameters {
                        let stringValue = myValue.stringValue
                        
                        self.ratingDetails = stringValue!
                    } else {
                        // Handle the case where response.parameters is nil
                    }

                    DispatchQueue.main.async {
                        self.accountTableView.reloadData()
                    }
                } catch {
                    print("Rating error res \(error)")
                }
            }
        }
    }
}


extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 9
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "AccountHeaderTableViewCell", for: indexPath) as! AccountHeaderTableViewCell
            
            cell.selectionStyle = .none
            
            cell.userNameLbl.text = accountDetails?.customerName
            cell.phoneNumLbl.text = accountDetails?.customerMobile
            cell.emailLbl.text = accountDetails?.customerEmail
            
            if accountDetails?.customeImage != nil {
                cell.accountHeaderImage.sd_setImage(with: URL(string: (accountDetails?.customeImage)!), placeholderImage: UIImage(named: "no_image"))
            }
                        
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
            cell.accountHeaderImage.isUserInteractionEnabled = true
            cell.accountHeaderImage.addGestureRecognizer(tapGesture)
            
            return cell
        } else if indexPath.section == 1 {
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "WalletAndLikeTableViewCell", for: indexPath) as! WalletAndLikeTableViewCell
            
            cell.context = self
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 2  {
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "ListSectionTableViewCell", for: indexPath) as! ListSectionTableViewCell
            
            cell.selectionStyle = .none
            
            cell.headingLbl.text = listHeading[indexPath.row]
            cell.leadingBtn.setImage(UIImage(systemName: headingIcon[indexPath.row]), for: .normal)
            
            if indexPath.row == 0 {
                cell.ratingView.isHidden = false
            } else {
                cell.ratingView.isHidden = true
            }
            
            cell.ratingLbl.text = self.ratingDetails
            
            return cell
        } else {
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
            
            cell.selectionStyle = .none
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoutViewTapped))

            // Add the tap gesture recognizer to the view
            cell.logOutBgView.addGestureRecognizer(tapGestureRecognizer)
            return cell
        }
    }
    
    @objc func logoutViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LogoutPopupViewController") as! LogoutPopupViewController
        vc.context = self
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc func imageViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        UserDefaults.standard.set("Account", forKey: "AccountScreen")
        vc.accountScreen = "Account"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ReferalViewController") as! ReferalViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 3 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "OrderHistoryViewController") as! OrderHistoryViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            else if indexPath.row == 4 {
//                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "ApplyCouponViewController") as! ApplyCouponViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            else if indexPath.row == 4 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "EarnCashViewController") as! EarnCashViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 5 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MyAddressViewController") as! MyAddressViewController
//                let vc = storyboard.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 6 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CardManagementViewController") as! CardManagementViewController
                vc.isFirst = true
                vc.backButton = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 7 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 8 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "HelpCenterViewController") as! HelpCenterViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    //Cell Heights
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else if indexPath.section == 1 {
            return 90
        } else if indexPath.section == 2 {
            return 80
        } else {
            return 50
        }
    }
}
