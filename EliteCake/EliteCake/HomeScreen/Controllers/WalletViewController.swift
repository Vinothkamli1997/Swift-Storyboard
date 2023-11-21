//
//  WalletViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 17/03/23.
//

import UIKit

class WalletViewController: UIViewController, addReferralCloseDelegate, profilePopDelegate {

    func okBtnTapped(_ alert: ProfilePopUpViewController, alertTag: Int) {
        self.dismiss(animated: true)
    }
    
    func closeBtnTapped(_ alert: WalletAddReferralViewController, alertTag: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var headerBgView: UIView!
    
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var balanceCountLbl: UILabel!
    
    @IBOutlet weak var totalEarnLbl: UILabel!
    @IBOutlet weak var totalEarnCountLbl: UILabel!
    
    @IBOutlet weak var usedCoinLbl: UILabel!
    @IBOutlet weak var usedCoinCountLbl: UILabel!
    
    @IBOutlet weak var walletTableView: UITableView! {
        didSet {
            //Register TableView Cells
            walletTableView.register(EarningTableViewCell.nib, forCellReuseIdentifier: EarningTableViewCell.identifier)
            walletTableView.register(HistoryTableViewCell.nib, forCellReuseIdentifier: HistoryTableViewCell.identifier)
            walletTableView.separatorStyle = .none
            walletTableView.dataSource = self
            walletTableView.delegate = self
            walletTableView.backgroundColor = .clear
            walletTableView.showsVerticalScrollIndicator = false
            walletTableView.showsHorizontalScrollIndicator = false
            walletTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var customerID: String = ""
    var outletId: String = ""
    var oID: String = ""
    var walletCoins: WelcomeParameters?
    var historyValues: [History] = []
    var earnCoinValues: [WalletEarnCoinsParameter] = []
    var screenType: String = ""
    
    var earnCoinImages: [String] = ["welcome", "special", "profile_earn", "Earn", "people", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        earnCoinApi()
        welcomeApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if screenType == "Wallet" {
            backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            backBtn.tintColor = UIColor(named: "TextDarkMode")
        } else {
            backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            backBtn.tintColor = UIColor(named: "TextDarkMode")
        }
    }
    
    func createBottomBorder(color: UIColor, width: CGFloat) -> CALayer {
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = color.cgColor
        bottomBorder.frame = CGRect(x: 0, y: segmentControl.frame.height - width, width: segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments), height: width)
        return bottomBorder
    }
    
    //WelcomeAPI Call
    func welcomeApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let outlet_id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = outlet_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.welcomeApi)
        
        let parameters = [
            "customer_id": customerID,
            "outlet_id": outletId,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("Wallet welcome params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(WelcomeResponse.self, from: data)
                    
                    print("Wallet welcome res \(response)")
                    
                    DispatchQueue.main.async {
                        
                        if response.success {
                            self.walletCoins = response.parameters
                            if response.parameters.history.count > 0 {
                                self.historyValues = response.parameters.history
                            }
                        }
                        
                        if let balanceCoin = self.walletCoins?.balanceCoin?.stringValue {
                            self.balanceCountLbl.text = balanceCoin
                        }

                        if let earnedCoin = self.walletCoins?.earnedCoin?.stringValue {
                            self.totalEarnCountLbl.text = earnedCoin
                        }

                        
                        if let usedCoin = self.walletCoins?.usedCoin, let usedCoinString = usedCoin.stringValue {
                            self.usedCoinCountLbl.text = usedCoinString
                        } else {
                            self.usedCoinCountLbl.text = nil
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.walletTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    print("Wallet welcome error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    func earnCoinApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.WALLET_EARN_COIN_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("Wallet earnCoin params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(WalletEarnCoinsResponse.self, from: data)
                    
                    print("Wallet earnCoin res \(response)")
                    if response.success {
                        if response.parameters.count > 0 {
                            self.earnCoinValues = response.parameters
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.walletTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    print("Wallet earnCoin error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        walletTableView.reloadData()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        if screenType == "Wallet" {
            self.navigationController?.popViewController(animated: true)
        } else {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func walletRefresh(_ notification: Notification) {
        welcomeApi()
        earnCoinApi()
    }
    
    func setUp() {
        
        segmentControl.selectedSegmentTintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        headerBgView.backgroundColor = UIColor(named: "ViewDarkMode")
        headerBgView.layer.cornerRadius = 20
        
        headerImage.image = UIImage(named: "Earn")
        
        setShadow(view: headerBgView)
        
        balanceCountLbl.font = UIFont.boldSystemFont(ofSize: 18)
        balanceLbl.font = UIFont.systemFont(ofSize: 16)
        
        totalEarnLbl.font = UIFont.systemFont(ofSize: 18)
        totalEarnCountLbl.font = UIFont.systemFont(ofSize: 14)
        
        usedCoinLbl.font = UIFont.systemFont(ofSize: 18)
        usedCoinCountLbl.font = UIFont.systemFont(ofSize: 14)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(walletRefresh(_:)),
                                               name: .walletScreenUpdate,
                                               object: nil)
    }
}

extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return self.earnCoinValues.count
        case 1:
            return historyValues.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            let cell = walletTableView.dequeueReusableCell(withIdentifier: "EarningTableViewCell", for: indexPath) as! EarningTableViewCell
            
            cell.selectionStyle = .none
            cell.context = self
            
            if earnCoinValues[indexPath.row].isClaimBtnShow == 1 {
                cell.claimBtn.isHidden = false
            } else {
                cell.claimBtn.isHidden = true
            }
                        
            let earnCoinImages: [String] = ["welcome", "special", "profile_earn", "Earn", "people", "Thumsup"]

            if indexPath.row < earnCoinImages.count {
                let imageName = earnCoinImages[indexPath.row]
                cell.EarnimageView.image = UIImage(named: imageName)
            } else {
                print("Invalid index: \(indexPath.row)")
            }

            
            cell.coinsLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            
            cell.earnHeadingLbl.text = self.earnCoinValues[indexPath.row].eventName
            cell.welcomeBonusLbl.text = self.earnCoinValues[indexPath.row].description
            cell.coinsLbl.text = self.earnCoinValues[indexPath.row].message
            
            cell.claimBtn.tag = indexPath.row
            cell.claimBtn.addTarget(self, action: #selector(claimButtonTapped(_:)), for: .touchUpInside)
            
            
            return cell
            
        } else {
            let historycell = walletTableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
            
            historycell.selectionStyle = .none
            
            historycell.countLbl.text = "+" + self.historyValues[indexPath.row].superCoin!
            historycell.welcomeBonusLbl.text = self.historyValues[indexPath.row].message
            historycell.dateTimeLbl.text = self.historyValues[indexPath.row].addedAt
            historycell.creditLbl.text = self.historyValues[indexPath.row].type
            
            if self.historyValues[indexPath.row].type == "CREDIT" {
                historycell.creditLbl.textColor = UIColor(hexFromString: ColorConstant.GREEN)
            } else {
                historycell.countLbl.text = "-" + self.historyValues[indexPath.row].superCoin!
                historycell.countLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                historycell.creditLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            }
            
            return historycell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentControl.selectedSegmentIndex == 0 {
            return 110
        } else {
            return 80
        }
    }
    
    
    @objc func claimButtonTapped(_ sender: UIButton) {
        print("click claim")
        let row = sender.tag
        
        print("claim row \(row)")
        
        guard row >= 0 && row < earnCoinValues.count else {
            return
        }
        
        print("clain earncoin value \(earnCoinValues.count)")
        
        let selectedEvent = earnCoinValues[row]
        
        print("claim selected Event \(earnCoinValues[row])")
        
        switch selectedEvent.eventName {
        case "Welcome Bonus":
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ReferalViewController") as! ReferalViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case "Special Welcome Bonus":
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WalletAddReferralViewController") as! WalletAddReferralViewController
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false, completion: nil)
        case "Complete Profile":
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            vc.screenType = "Claim"
            self.navigationController?.pushViewController(vc, animated: true)
        case "Refer and Earn":
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ReferalViewController") as! ReferalViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case "Event Bonus":
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case "Rate Your Order":
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OrderHistoryViewController") as! OrderHistoryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

