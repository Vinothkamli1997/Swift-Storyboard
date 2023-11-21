//
//  CardManagementViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/03/23.
//

import UIKit

class CardManagementViewController: UIViewController {

    @IBOutlet weak var scrollingView: UIScrollView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var firstBgView: UIView!
    @IBOutlet weak var payableLbl: UILabel!
    @IBOutlet weak var rupeesLbl: UILabel!
    @IBOutlet weak var payAmontContentLbl: UILabel!
    
    @IBOutlet weak var secondBgView: UIView!
    @IBOutlet weak var qrContentLbl: UILabel!
    
    @IBOutlet weak var takeScreenShotBtn: UIButton!
    
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var chooseLbl: UILabel!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var gpayImage: UIButton!
    @IBOutlet weak var gpayLbl: UILabel!

    @IBOutlet weak var paytmImage: UIButton!
    @IBOutlet weak var paytmLbl: UILabel!

    @IBOutlet weak var BhimImage: UIButton!
    @IBOutlet weak var bhimLbl: UILabel!

    @IBOutlet weak var chromeImage: UIButton!
    @IBOutlet weak var chromeLbl: UILabel!

    @IBOutlet weak var phoneNumLbl: UIButton!

    var pay_Amount: String = ""
    var isFirst: Bool = true
    var backButton: Bool = true
    var customerID: String = ""
    var outletId: String = ""
    var oID: String = ""
    var mobileNum: String = ""
    var orderPlaced: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollingView.showsVerticalScrollIndicator = false
        
        if isFirst {
            continueBtn.isHidden = true
            rupeesLbl.isHidden = true
        } else {
            continueBtn.isHidden = false
            rupeesLbl.isHidden = false
            rupeesLbl.text = HomeConstant.rupeesSym + pay_Amount
        }
        
        if backButton {
            backBtn.isHidden = false
            
            backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            backBtn.tintColor = UIColor.black
        } else {
            backBtn.isHidden = true
        }
        
        titleLbl.text = "Bill Details"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.textColor = .black
                
        payableLbl.text = "Payable Amount"
        payableLbl.font = UIFont.boldSystemFont(ofSize: 18)
        payableLbl.textColor = .black
        
        payAmontContentLbl.text = ContentConstant.CARD_PAGE_CONTENT
        payAmontContentLbl.font = UIFont.systemFont(ofSize: 12)
        payAmontContentLbl.textColor = .black
        
        paymentLbl.text = "Payment Method"
        paymentLbl.font = UIFont.boldSystemFont(ofSize: 18)
        paymentLbl.textColor = .black
        
        qrContentLbl.text = ContentConstant.CARD_PAGE_CONTENT1
        qrContentLbl.font = UIFont.systemFont(ofSize: 16)
        qrContentLbl.textColor = .black
        
        chooseLbl.text = "Choose your bank"
        chooseLbl.font = UIFont.boldSystemFont(ofSize: 18)
        chooseLbl.textColor = .black
        
        takeScreenShotBtn.setTitle("Take Screen Shoot", for: .normal)
        takeScreenShotBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        takeScreenShotBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        gpayLbl.font = UIFont.boldSystemFont(ofSize: 12)
        bhimLbl.font = UIFont.boldSystemFont(ofSize: 12)
        paytmLbl.font = UIFont.boldSystemFont(ofSize: 12)
        chromeLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        continueBtn.setTitle("Continue", for: .normal)
        continueBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        continueBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        continueBtn.tintColor = UIColor.white
        continueBtn.layer.cornerRadius = 10
        setShadow(view: continueBtn)
        
        firstBgView.backgroundColor = UIColor.white
        firstBgView.layer.cornerRadius = 10
        setShadow(view: firstBgView)
        
        secondBgView.backgroundColor = UIColor.white
        secondBgView.layer.cornerRadius = 10
        setShadow(view: secondBgView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HomeApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        if !orderPlaced {
            self.navigationController?.popViewController(animated: true)
        } else {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            vc.backBtnScreenType = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func continueBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrderHistoryViewController") as! OrderHistoryViewController
        vc.backButtonAction = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func gpayBtnAction(_ sender: UIButton) {
        if let url = URL(string: "https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func bhimBtnAction(_ sender: UIButton) {
        if let url = URL(string: "https://play.google.com/store/apps/details?id=in.org.npci.upiapp") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func paytmBtnAction(_ sender: UIButton) {
        if let url = URL(string: "https://play.google.com/store/apps/details?id=net.one97.paytm") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func chromeBtnAction(_ sender: UIButton) {
        if let url = URL(string: "https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func takeScreenshotBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let screenShotPopup = storyboard.instantiateViewController(withIdentifier: "TakeScreenShotViewController") as! TakeScreenShotViewController
        
        screenShotPopup.modalPresentationStyle = .overCurrentContext
        self.present(screenShotPopup, animated: false, completion: nil)
    }
    
    @IBAction func phoneBtnAction(_ sender: UIButton) {
        let mobileNumber = self.mobileNum
        
        print("mobilenum about \(mobileNumber)")

        let cleanedMobileNumber = mobileNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        if !cleanedMobileNumber.isEmpty {
            if let dialURL = URL(string: "tel:\(cleanedMobileNumber)") {
                if UIApplication.shared.canOpenURL(dialURL) {
                    UIApplication.shared.open(dialURL, options: [:], completionHandler: nil)
                } else {
                    showAlert(message: "Unable to open the dial pad")
                }
            } else {
                showAlert(message: "Unable to create a valid dial URL")
            }
        } else {
            showAlert(message: "Invalid mobile number")
        }
    }
    
    func HomeApi() {
        
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
        let url = URL(string: ApiConstant.homeScreen)
        
        let parameters = [
            "customer_details_id": customerID,
            "outlet_id": outletId,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("home paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                    self.showToast(message: "Status Code Error")
                        print("Status Code Error")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    print("home response \(response)")
                    
                    if response.success {
                        DispatchQueue.main.async {
                            self.phoneNumLbl.setTitle(response.parameters.mobile, for: .normal)
                            self.mobileNum = response.parameters.mobile
                        }
                    }
                    
                } catch {
                    print("home error res \(error)")
                }
            }
        }
    }
}
