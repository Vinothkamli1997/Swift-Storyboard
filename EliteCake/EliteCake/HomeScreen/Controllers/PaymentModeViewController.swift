//
//  PaymentModeViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 14/10/23.
//

import UIKit

class PaymentModeViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    @IBOutlet weak var codView: UIView!
    @IBOutlet weak var codImageView: UIImageView!
    @IBOutlet weak var codLbl: UILabel!
    @IBOutlet weak var codContentLbl: UILabel!
    @IBOutlet weak var codButton: UIButton!
    
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var bankLbl: UILabel!
    @IBOutlet weak var bankContentLbl: UILabel!
    @IBOutlet weak var bankButton: UIButton!
    
    @IBOutlet weak var payableView: UIView!
    @IBOutlet weak var payableLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!

    var priceAmount: String = ""
    var payMode: String = ""
    var customerID: String = ""
    var outletId: String = ""
    var oID: String = ""
    var availablerPayModes: [String] = []
    var getOrderID: Int = 0
    var delSlot: String = ""
    var paymentType: String = ""
    var del_type_api: String = ""
    var slotDate: String = ""
    var birthDayText: String = ""
    var instructionText: String = ""
    var cakeCuttingTime: String = ""
    var cartID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUP()
        paymentOptionApi()
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func codBtnAction(_ sender: UIButton) {
        if payMode == "cod" {
             // Deselect the button
             payMode = ""
             codButton.tintColor = UIColor.gray
             codButton.setImage(UIImage(systemName: "square"), for: .normal)
         } else {
             // Select the button
             payMode = "cod"
             codButton.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
             codButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
             
             // Deselect the other button
             bankButton.tintColor = UIColor.gray
             bankButton.setImage(UIImage(systemName: "square"), for: .normal)
         }
    }
    
    @IBAction func bankBtnAction(_ sender: UIButton) {
        if payMode == "online" {
             // Deselect the button
             payMode = ""
             bankButton.tintColor = UIColor.gray
             bankButton.setImage(UIImage(systemName: "square"), for: .normal)
         } else {
             // Select the button
             payMode = "online"
             bankButton.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
             bankButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
             
             // Deselect the other button
             codButton.tintColor = UIColor.gray
             codButton.setImage(UIImage(systemName: "square"), for: .normal)
         }
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        if payMode != "cod" && payMode != "online" {
            showAlert(message: "Please select a payment mode")
        } else {
            cartToAddApi()
        }
    }
    
    func paymentOptionApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.paymentOptionApi)
        
        let parameters = [
            MobileRegisterConstant.auth_token: hash,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            "customer_id": customerID
        ] as [String : Any]
        
        print("paymentOption paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        showAlert(message: "Api Res \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(PaymentOptionResponse.self, from: data)
                    
                    print("paymentOption res \(response)")
                    
                    if response.success {
                        self.availablerPayModes = response.parameters.availablePaymentModes!
                    }
                   
                } catch {
                    print("paymentOption error \(error)")
                }
            }
        }
    }
    
    func cartToAddApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        if let slotId = UserDefaults.standard.string(forKey: "SlotID"){
            self.delSlot = slotId
        }
        
        if let slotDate = UserDefaults.standard.string(forKey: "SelectedDateLbl"){
            print("Slot Date \(slotDate)")
            self.slotDate = slotDate
        }
        
        if let delType = UserDefaults.standard.string(forKey: "SetDelType"){
            self.del_type_api = delType
        }
        
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.CART_TO_ADD_API)
        
        let parameters = [
            "customer_id": customerID,
            "outlet_id" : outletId,
            "id" : oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "del_slot" : self.delSlot,
            "paymode" : self.payMode,
            "del_type" : self.del_type_api,
            "slot_date" : self.slotDate
        ] as [String : Any]
        
        print("cart to Add paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CartToAddResponse.self, from: data)
                    
                    print("cart to Add res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            
                            self.getOrderID = response.parameters!.orderID
                                                        
                            self.getTextTypeApi()
                            self.onlinePaymentApi()
                            
                            UserDefaults.standard.removeObject(forKey: "Bday")
                            UserDefaults.standard.removeObject(forKey: "Instruction")
                            UserDefaults.standard.removeObject(forKey: "cakeCutTime")
                            UserDefaults.standard.removeObject(forKey: "SlotID")
                            UserDefaults.standard.removeObject(forKey: "SelectedDate")
                            UserDefaults.standard.removeObject(forKey: "Voucher")
                            
                            // Synchronize the changes (optional, not always necessary)
                            UserDefaults.standard.synchronize()
                            
                                if self.payMode == "online" {
                                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "CardManagementViewController") as! CardManagementViewController
                                    
                                    vc.isFirst = false
                                    vc.orderPlaced = true
                                    vc.backButton = true
                                    
                                    vc.pay_Amount = self.priceAmount
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                } else {
                                    print("Execute Else paertttttttttt eeeeee")
                                }
                        } else {
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "EmptyPopupViewController") as! EmptyPopupViewController
                            
                            vc.message = response.message
                            
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                        }
                    }
                } catch {
                    print("cart to Add error \(error)")
                }
            }
        }
    }
    
    func getTextTypeApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let bDay = UserDefaults.standard.string(forKey: "Bday"){
            birthDayText = bDay
        }
        
        if let insText = UserDefaults.standard.string(forKey: "Instruction"){
            instructionText = insText
        }
        
        if let cuttingTime = UserDefaults.standard.string(forKey: "cakeCutTime"){
            cakeCuttingTime = cuttingTime
        }
        
        if let cartid = UserDefaults.standard.string(forKey: "CartIDValue"){
            self.cartID = cartid
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.getTextType)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.auth_token: hash,
            "cake_cut_time": cakeCuttingTime,
            "birthday": self.birthDayText,
            "cart_id": self.cartID,
            "special_instruction": self.instructionText,
            "order_id": self.getOrderID
        ] as [String : Any]
        
        print("getText paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FilterCheckResponse.self, from: data)
                    
                    print("getText res \(response)")
                
                } catch {
                    print("getText error \(error)")
                }
            }
        }
    }
    
    func onlinePaymentApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.ONLINE_PAYMENT_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
        ] as [String : Any]
        
        print("onlinePayment paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(OnlinePaymntResponse.self, from: data)
                    
                    print("onlinePayment res \(response)")
                    
                } catch {
                    print("onlinePayment error \(error)")
                }
            }
        }
    }

    func setUP() {
        
        titleLbl.text = "Pay Mode"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        codView.backgroundColor = UIColor.white
        codView.layer.cornerRadius = 20
        setShadow(view: codView)
        
        codLbl.text = "Cash On Delivery"
        codLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        codContentLbl.text = "Cash will be collect at the time of delivery"
        codContentLbl.font = UIFont.systemFont(ofSize: 14)
        
        codButton.tintColor = UIColor.gray
        
        bankView.backgroundColor = UIColor.white
        bankView.layer.cornerRadius = 20
        setShadow(view: bankView)
        
        bankLbl.text = "Bank Transfer"
        bankLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        bankContentLbl.text = "Pay through Wallets, UPI and net Banking."
        bankContentLbl.font = UIFont.systemFont(ofSize: 14)
        
        bankButton.tintColor = UIColor.gray
        
        payableView.backgroundColor = UIColor.white
        payableView.layer.cornerRadius = 20
        setShadow(view: payableView)
        
        payableLbl.text = "PAYABLE"
        payableLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        priceLbl.text = HomeConstant.rupeesSym + priceAmount
        priceLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.tintColor = UIColor.white
        confirmButton.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        confirmButton.layer.cornerRadius = 20
        setShadow(view: confirmButton)
    }
}
