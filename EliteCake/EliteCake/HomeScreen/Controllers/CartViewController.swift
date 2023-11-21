//
//  CartViewController.swift
//  EliteCake
//
//  Created by apple on 09/01/23.
//

import UIKit

class CartViewController: UIViewController, TakeAwayDeliveryDelegate, UITextFieldDelegate, soltTimeDelegate {
    
    func selectTime(selectSlot: String) {
        self.delSlot = selectSlot
    }
    
    
    @IBOutlet weak var cartTableView: UITableView! {
        didSet {
            //Register TableView Cells
            cartTableView.register(CartHeaderTableViewCell.nib, forCellReuseIdentifier: CartHeaderTableViewCell.identifier)
            cartTableView.register(CartDishListTableViewCell.nib, forCellReuseIdentifier: CartDishListTableViewCell.identifier)
//            cartTableView.register(CartDishListNewTableViewCell.nib, forCellReuseIdentifier: CartDishListNewTableViewCell.identifier)

            
            cartTableView.register(AddressTableViewCell.nib, forCellReuseIdentifier: AddressTableViewCell.identifier)
            cartTableView.register(GetDirectionTableViewCell.nib, forCellReuseIdentifier: GetDirectionTableViewCell.identifier)
            cartTableView.register(SelectTimeSlotTableViewCell.nib, forCellReuseIdentifier: SelectTimeSlotTableViewCell.identifier)
            cartTableView.register(SelectDateTableViewCell.nib, forCellReuseIdentifier: SelectDateTableViewCell.identifier)
            cartTableView.register(CustomSelectionTableViewCell.nib, forCellReuseIdentifier: CustomSelectionTableViewCell.identifier)
            cartTableView.register(CouponTableViewCell.nib, forCellReuseIdentifier: CouponTableViewCell.identifier)
            cartTableView.register(SummaryTableViewCell.nib, forCellReuseIdentifier: SummaryTableViewCell.identifier)
            
            cartTableView.separatorStyle = .none
            cartTableView.dataSource = self
            cartTableView.delegate = self
            cartTableView.backgroundColor = .clear
            cartTableView.showsVerticalScrollIndicator = false
            cartTableView.showsHorizontalScrollIndicator = false
            cartTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var emptyCartImage: UIImageView!
    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var exploreBtn: UIButton!
    @IBOutlet weak var cartEmptyView: UIView!
    @IBOutlet weak var cartEmptyViewBackBtn: UIButton!
    
    @IBOutlet weak var bottomAddPersonalView: UIView!
    @IBOutlet weak var addPersonalLbl: UILabel!
    @IBOutlet weak var addPersonalBtn: UIButton!
    
    
    var deliveryView: UIView!
    var takeAwayView: UIView!
    
    var customerID: String = ""
    var outletId: String = ""
    var oID: String = ""
    var dish_id: String = ""
    var quantity: String = ""
    var selectedSizeID: String = ""
    var typeTakeAway: String = "Take Away"
    var typeDelivery: String = "Delivery"
    var selectedType: String = "Take Away"
    var getAddress:  AddressDefaultGetParameters!
    var selectedTIme: String = ""
    var delivery_Type: String = "Take Away"
    var del_Type: String = "Take Away"
    var cart_ID: String = ""
    var getOrderID: Int = 0
    var set_Del_Type: String = ""
    var is_select: String = "0"
    var voucher_id: String = ""
    var refreshCart: String = ""
    var selectType: String = "CurrentDate"
    var delSlot: String = ""
    var slotDate: String = ""
    var bottomHide: Bool = false
    var backButton: String = ""
    var singleDelTypeValue: String = ""
    var backBtnScreenType: Bool = true
    var isLoading: Bool = false
    var del_type_api: String = ""
    var cakeCuttingTime: String = ""
    var birthDayText: String = ""
    var instructionText: String = ""
    var cartID: String = ""
    var orderID: String = ""
    var delSlotID: String = ""
    var deliverySlot: String = ""
    var paymentType: String = ""
    var redeemValue: Int!
    var isSelect: Int!
    var isFirstTime: Bool = true
    
    var totalItemCount: Int = 0
    var isCellHidden = false
    
    var outletDetails: OutletDetails?
    var cartDishDetails: [Cart] = []
    var cartDishListDetails: [CartHasDishDetail] = []
    var timeSlot: [OutletSlot] = []
    var setOutlet: [OutletSlot] = []
    var addProfileCheck: ProfileParameters?
    var voucherList: [VoucherList] = []
    var showAllCategoryList: [Category] = []
    var addonList: AddonCart?
    var filteredTimeSlot = [OutletSlot]()
    var timeSlotCollectionViewCell: SelectTimeSlotTableViewCell?
    var orderType: [OutletDeliveryType] = []
    var singleDelType: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.backgroundColor = .white
        
        initialLoads()
                        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cartRefresh(_:)),
                                               name: .cartScreenUpdate,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedTimeSlot(_:)), name: .selectSlotID, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onlinePaymentApi()
        voucherListApi()
        HomeApi()
        profileApi()
        cartShowingApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addressDefaultGetApi()
        
        if let select = UserDefaults.standard.string(forKey: "RedeemSelecct") {
            if select == "1" {
                is_select = "1"
            }
        }
    }
    
    @objc private func cartRefresh(_ notification: Notification) {
        cartShowingApi()
    }
    
    @objc func handleSelectedTimeSlot(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let deliverySlotID = userInfo["deliverySlotID"] as? String {
            
            self.delSlot = deliverySlotID
                        
            UserDefaults.standard.set(deliverySlotID, forKey: "SlotID")
        } else {
            print("eklse")
        }
    }
    
    @IBAction func emptyViewBackBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func exploreBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
        
        UserDefaults.standard.removeObject(forKey: "Bday")
        UserDefaults.standard.removeObject(forKey: "Instruction")
        UserDefaults.standard.removeObject(forKey: "cakeCutTime")
        UserDefaults.standard.removeObject(forKey: "SlotID")
        UserDefaults.standard.removeObject(forKey: "SelectedDate")
        
        UserDefaults.standard.synchronize()

        vc.category_ID = showAllCategoryList[0].categoryID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addPersonalDetailsBtnAction(_ sender: UIButton) {
        
        if addProfileCheck?.customerMobile == nil || addProfileCheck?.customerMobile == "" {
            self.addPersonalLbl.text = "Add Personal Details"
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddPersonalDetailsViewController") as! AddPersonalDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else if addProfileCheck?.customerEmail == nil || addProfileCheck?.customerEmail == "" || addProfileCheck?.dateOfBirth == "" || addProfileCheck?.dateOfBirth == nil {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.addPersonalLbl.text = "Complete Profile"
            vc.cartScreen = "Cart"
            UserDefaults.standard.set("Cart", forKey: "CartScreen")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //Profile Api
    func profileApi() {
        
        //        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.PROFILE_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID
        ] as [String : Any]
        
        print("profile params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ProfileResponse.self, from: data)
                    print("profile Response \(response)")
                    
                    self.addProfileCheck = response.parameters
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                    
                    //                    self.hideLoader()
                } catch {
                    //                    self.hideLoader()
                    print("profile error res \(error)")
                }
            }
        }
    }
    
    //Address Get Api
    func addressDefaultGetApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.ADDRESS_DEFAULT_GET_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.auth_token: hash,
        ] as [String : Any]
        
        print("AddressGet paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddressDefaultGetResponse.self, from: data)
                    
                    print("AddressGet res \(response)")
                    DispatchQueue.main.async {
                        
                        if response.success == true {
                            if response.parameters != nil {
                                self.getAddress = response.parameters
                            } else {
                                print("no address")
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                } catch {
                    print("AddressGet error \(error)")
                }
            }
        }
    }
    
    //Set Del Type Api
    func setDelTypeApi() {
        
//        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.SET_DEL_TYPE_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.auth_token: hash,
            "cart_id" : cart_ID,
            "outlet_id" : outletId,
            "del_type" : set_Del_Type,
            "id" : oID
        ] as [String : Any]
        
        print("setDelType paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(SetDelTypeResponse.self, from: data)
                    
                    print("setDelType res \(response)")
                    DispatchQueue.main.async {
                        
                        if response.success {
                            self.hideLoader()
                            self.cartShowingApi()
                        }
                    }
                } catch {
                    print("setDelType error \(error)")
                }
            }
        }
    }
    
    //Cake Detail API
    func cartShowingApi() {
        
        if self.singleDelType {
            self.hideLoader()
        } else {
            self.showLoader()
        }

        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.CARTSHOWING)
        
        let parameters = [
            "outlet_id": outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID
        ] as [String : Any]
        
        print("CartShowing params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.sync {
                        self.cartEmptyView.isHidden = false
                        self.bgView.isHidden = false
                        self.bottomAddPersonalView.isHidden = true
                        self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                        
                        self.cartEmptyViewBackBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
                        self.cartEmptyViewBackBtn.tintColor = .black
                        self.cartEmptyViewBackBtn.isHidden = false
                    }
                    self.hideLoader()
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CartShowingResponse.self, from: data)
                    DispatchQueue.main.async {
                        
                        if response.success {
                            
                            self.outletDetails = response.parameters.outletDetails
                            self.cartDishDetails = response.parameters.cart!
                            self.timeSlot = response.parameters.outletSlot
                            self.setOutlet = response.parameters.outletSlot
                            
                            self.filterList()
                            
                            self.orderType = response.parameters.outletDeliveryType
                            
                            if response.parameters.cart!.count > 0 {
                                self.cartID = response.parameters.cart![0].cartID!
                                
                                UserDefaults.standard.set(self.cartID, forKey: "CartIDValue")
                                
                                self.cartDishListDetails = response.parameters.cart![0].cartHasDishDetails
                            }
                            
                            if let cartDetails = response.parameters.cart?.first {
                                if !cartDetails.cartHasDishDetails.isEmpty {
                                    self.cartDishListDetails = cartDetails.cartHasDishDetails
                                    self.cart_ID = self.cartDishDetails[0].cartID!
                                    self.orderID = response.parameters.cart![0].cartHasDishDetails[0].cartCartID!
                                } else {
                                    //                            self.showToast(message: "DishList Array Empty")
                                    print("DishList Array Empty")
                                }
                                
                                if !cartDetails.cartHasDishaddon.isEmpty {
                                    if cartDetails.cartHasDishaddon.count > 0 {
                                        self.addonList = cartDetails.cartHasDishaddon[0].addonCart
                                    }
                                } else {
                                    print("cartdish addon count \(cartDetails.cartHasDishaddon.count)")
                                    print("addon empty")
                                }
                            } else {
                                print("Cart Array Empty")
                            }
                            
                            if let cartDetails = response.parameters.cart?.first {
                                if !cartDetails.cartHasDishaddon.isEmpty {
                                    self.addonList = cartDetails.cartHasDishaddon[0].addonCart
                                    print("addon array \(cartDetails)")
                                }
                            }
                            
                            self.totalItemCount = response.parameters.totalItems
                            
                            NotificationCenter.default.post(name: .badgeCountUpdate, object: nil, userInfo: ["count": self.totalItemCount])
                            
                            self.set_Del_Type = response.parameters.outletDeliveryType[0].deliverytype!
                            
                            UserDefaults.standard.set(self.set_Del_Type, forKey: "SetDelType")
                            
                            if self.isFirstTime {
                                self.setDelTypeApi()
                                self.isFirstTime = false
                            } else {
                                print("else part execute")
                            }
                        } else {
                            self.hideLoader()
                            self.cartEmptyView.isHidden = false
                            self.bgView.isHidden = false
                            self.bottomAddPersonalView.isHidden = true
                            
                            UserDefaults.standard.removeObject(forKey: "Bday")
                            UserDefaults.standard.removeObject(forKey: "Instruction")
                            UserDefaults.standard.removeObject(forKey: "cakeCutTime")
                            UserDefaults.standard.removeObject(forKey: "SlotID")
                            UserDefaults.standard.removeObject(forKey: "SelectedDate")
                            
                            self.cartEmptyViewBackBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
                            self.cartEmptyViewBackBtn.tintColor = .black
                            self.cartEmptyViewBackBtn.isHidden = false
                        }
                    }
                    
                    print("CartShowing res \(response)")
                    DispatchQueue.main.async {
                        
                        if response.parameters.totalItems != 0 {
                            self.bottomAddPersonalView.isHidden = false
                            self.cartEmptyView.isHidden = true
                            self.bgView.isHidden = true
                            
                            if self.addProfileCheck?.customerEmail == nil ||  self.addProfileCheck?.customerMobile == nil {
                                self.bottomAddPersonalView.visiblity(gone: false, dimension: 50, attribute: .height)
                            } else {
                                self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                            }
                        } else {
                            self.bottomHide = true
                            
                            if self.addProfileCheck?.customerMobile != nil || self.addProfileCheck?.customerEmail != nil {
                                self.bottomAddPersonalView.isHidden = true
                                self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                            }
                            self.hideLoader()
                            self.cartEmptyView.isHidden = false
                            self.bgView.isHidden = false
                            self.bottomAddPersonalView.isHidden = true
                            
                            UserDefaults.standard.removeObject(forKey: "Bday")
                            UserDefaults.standard.removeObject(forKey: "Instruction")
                            UserDefaults.standard.removeObject(forKey: "cakeCutTime")
                            UserDefaults.standard.removeObject(forKey: "SlotID")
                            UserDefaults.standard.removeObject(forKey: "SelectedDate")
                            
                            if self.bottomHide {
                                self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                            }
                            
                            self.cartEmptyViewBackBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
                            self.cartEmptyViewBackBtn.tintColor = .black
                            self.cartEmptyViewBackBtn.isHidden = false
                        }
                        
                        self.cartTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    print("cart Showing error res localize \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    //Add to cart API
    func AddToCartApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        
        let url = URL(string: ApiConstant.ADDTOCART)
        
        let parameters = [
            "dish_id": dish_id,
            "outlet_id": outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "size" : selectedSizeID,
            "quantity" : quantity
        ] as [String : Any]
        print("addtocart params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddToCartResponse.self, from: data)
                    
                    print("addtocart res cart \(response)")
                    DispatchQueue.main.async {
                        if response.success {
                            self.hideLoader()
                            self.cartShowingApi()
                        }
                    }
                } catch {
                    print("Addtocart error res localize \(error)")
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
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                } catch {
                    print("onlinePayment error \(error)")
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
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.CART_TO_ADD_API)
        
        let parameters = [
            "customer_id": customerID,
            "outlet_id" : outletId,
            "id" : oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "del_slot" : self.delSlot,
            "paymode" : paymentType,
            "del_type" : del_type_api,
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
                            
                            print("Compltede OrderID \(response.parameters!.orderID)")
                            
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
                            
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "CardManagementViewController") as! CardManagementViewController
                            
                            vc.isFirst = true
                            vc.backButton = true
                            vc.orderPlaced = true
                            
                            if self.cartDishDetails.count > 0 {
                                vc.pay_Amount = self.cartDishDetails[0].amountPayable!
                            }
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
//                        else {
//
//                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
//                            let vc = storyboard.instantiateViewController(withIdentifier: "EmptyPopupViewController") as! EmptyPopupViewController
//
//                            vc.message = response.message
//
//                            vc.modalPresentationStyle = .overCurrentContext
//                            self.present(vc, animated: false, completion: nil)
//                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                } catch {
                    print("cart to Add error \(error)")
                }
            }
        }
    }
    
    func redeemApi(is_Select_num: String) {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.REDEEM_COIN_API)
        
        let parameters = [
            "customer_id": customerID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "is_select" : is_Select_num,
            "id" : oID,
            "outlet_id" : outletId
        ] as [String : Any]
        
        print("RedeemCoin paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        showAlert(message: "Api Status \(response.statusCode)")
                    }
                    
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(RedeemCoinResponse.self, from: data)
                    
                    print("RedeemCoin res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.parameters != nil {
                            if response.success {
                                
                                self.is_select = response.parameters!.isSelect
                                
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "RedeemCoinViewController") as! RedeemCoinViewController
                                
                                print("response.message \(response.message)")
                                vc.voucherMsg = response.message
                                
                                
                                vc.modalPresentationStyle = .overCurrentContext
                                self.present(vc, animated: false, completion: nil)
                                
                                NotificationCenter.default.post(name: .cartScreenUpdate, object: nil, userInfo: ["Cart": self.refreshCart])
                                
                                let dismissalTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                    vc.dismiss(animated: true, completion: nil)
                                }
                                
                            } else {
                                //                            self.showToast(message: response.message)
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "RedeemCoinViewController") as! RedeemCoinViewController
                                
                                print("response.message \(response.message)")
                                vc.contentTextLbl.text = response.message
                                
                                
                                vc.modalPresentationStyle = .overCurrentContext
                                self.present(vc, animated: false, completion: nil)
                                
                                
                                let dismissalTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                    vc.dismiss(animated: true, completion: nil)
                                }
                            }
                        } else {
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "EmptyPopupViewController") as! EmptyPopupViewController
                            
                            vc.message = response.message
                            
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                        }

                        
                        DispatchQueue.main.async {
                            self.cartTableView.reloadData()
                        }
                    }
                } catch {
                    print("RedeemCoin error \(error)")
                }
            }
        }
    }
    
    //VoucherListApi Api
    func voucherListApi() {
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.VOUCHER_LIST_API)
        
        let parameters = [
            MobileRegisterConstant.auth_token: hash,
            "outlet_id" : outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            "id" : oID
        ] as [String : Any]
        
        print("voucherList paramsI/P \(parameters)")
        
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
                    let response = try decoder.decode(VoucherListResponse.self, from: data)
                    
                    print("voucherList res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            if response.parameters != nil {
                                self.voucherList = response.parameters!.voucher
                            }
                        } else {
                            self.showToast(message: response.message)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                } catch {
                    print("voucherList error \(error)")
                }
            }
        }
    }
    
    //HomeAPI Call
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
                    self.showToast(message: "Status Code Error")
                    DispatchQueue.main.async {
                        showAlert(message: "Api Res \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.showAllCategoryList = response.parameters.category
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                } catch {
                    print("home error res \(error)")
                }
            }
        }
    }
    
    func voucherRemoveApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.VOUCHER_REMOVE_API)
        
        let parameters = [
            MobileRegisterConstant.auth_token: hash,
            "customer_id" : customerID
        ] as [String : Any]
        
        print("voucherRemove paramsI/P \(parameters)")
        
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
                    let response = try decoder.decode(UpdateEventDetailsResponse.self, from: data)
                    
                    print("voucherRemove res \(response)")
                    if response.success {
                        DispatchQueue.main.async {
                            self.cartShowingApi()
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.cartTableView.reloadData()
                    }
                } catch {
                    print("voucherRemove error \(error)")
                }
            }
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
                    
                    DispatchQueue.main.async {
                        if response.success {
                            if response.parameters.availablePaymentModes!.count > 0 {
                                
                                if response.parameters.availablePaymentModes!.count == 2 {
                                    let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "PaymentModeViewController") as! PaymentModeViewController
                                    
                                    if self.cartDishDetails.count > 0 {
                                        vc.priceAmount = self.cartDishDetails[0].amountPayable!
                                    }
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                } else {
                                    self.paymentType = response.parameters.availablePaymentModes![0]
                                    self.cartToAddApi()
                                }
                            } else {
//                                self.paymentType = "Online"
//                                self.cartToAddApi()
                            }
                        } else {
                            showAlert(message: response.message)
                        }
                    }
                   
                } catch {
                    print("paymentOption error \(error)")
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
    
    func filterList() {
        self.filteredTimeSlot = []
        self.timeSlot.forEach { slot in
            if slot.isDisabled == 0 {
                self.filteredTimeSlot.append(slot)
            }
        }
    }
    
    func didTapOkButton(type: String) {
        selectedType = type
        self.setDelTypeApi()
        self.cartTableView.reloadData()
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return cartDishListDetails.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartHeaderTableViewCell", for: indexPath) as! CartHeaderTableViewCell
            
            cell.selectionStyle = .none
            cell.context = self
            
            if self.orderType.count > 0 {
                if self.orderType.count == 1 {
                    cell.deliveryBgView.isHidden = true
                    cell.singleDelTpeView.isHidden = false
                    cell.singleTypeLbl.text = self.orderType[indexPath.row].deliverytype
                    
                    if self.orderType[indexPath.row].deliverytype == "Delivery" {
                        self.singleDelType = true
//                        self.typeTakeAway = self.orderType[indexPath.row].deliverytype!
                        self.set_Del_Type = self.orderType[indexPath.row].deliverytype!
                        let deliveryImg = UIImage(named: "motorbike")?.withRenderingMode(.alwaysTemplate)
                        cell.singleTypeImage.image = deliveryImg
                        cell.singleTypeImage.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                        
                        selectedType = typeDelivery
                        del_type_api = "Delivery"
                        delSlotID = self.orderType[indexPath.row].deliveryID!
                    } else {
                        self.singleDelType = true
                        self.typeTakeAway = self.orderType[indexPath.row].deliverytype!
                        self.set_Del_Type = self.orderType[indexPath.row].deliverytype!
                        let takeAwayImg = UIImage(named: "delivery-boy")?.withRenderingMode(.alwaysTemplate)
                        cell.singleTypeImage.image = takeAwayImg
                        cell.singleTypeImage.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                    }
                } else {
                    cell.deliveryBgView.isHidden = false
                    cell.singleDelTpeView.isHidden = true
                }
            }

            takeAwayView = cell.takeAwayView
            deliveryView = cell.deliveryView
            
            cell.backBtn.addTarget(self, action: #selector(backBtnTap(_:)), for: .touchUpInside)
            
            cell.takeAwayBtn.tag = indexPath.row
            cell.takeAwayBtn.addTarget(self, action: #selector(takeAwayAction(_:)), for: .touchUpInside)
            
            cell.deliveryBtn.tag = indexPath.row
            cell.deliveryBtn.addTarget(self, action: #selector(deliveryAction(_:)), for: .touchUpInside)
            
            cell.takeAwayView.tag = indexPath.row
            let takAwayView = UITapGestureRecognizer(target: self, action: #selector(takeAwayViewTapped(_:)))
            cell.takeAwayView.addGestureRecognizer(takAwayView)
            
            cell.deliveryView.tag = indexPath.row
            let deliveryView = UITapGestureRecognizer(target: self, action: #selector(deliveryViewTapped(_:)))
            cell.deliveryView.addGestureRecognizer(deliveryView)
            
            return cell
        }
        else if indexPath.section == 1 {

            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartDishListTableViewCell", for: indexPath) as! CartDishListTableViewCell

            cell.selectionStyle = .none
                                            
            cell.addonList = cartDishListDetails[indexPath.row].addon!
                        
            if cartDishDetails.count > 0 {
                if cartDishDetails[0].cartHasDishDetails.count > indexPath.row {
                    cell.dishNameLbl.text = cartDishListDetails[indexPath.row].dishName
                    cell.dishTypeLbl.text = cartDishListDetails[indexPath.row].category.categoryName
                    cell.priceLbl.text = HomeConstant.rupeesSym + cartDishListDetails[indexPath.row].orderAmount!
                    cell.dishCountLbl.text = cartDishDetails[0].cartHasDishDetails[indexPath.row].quantity
                    
                    if let encodedImageUrlString = cartDishDetails[0].cartHasDishDetails[indexPath.row].withBackground!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let imageUrl = URL(string: encodedImageUrlString) {
                        cell.dishImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
                    } else {
                        cell.dishImage.image = UIImage(named: "no_image")
                    }
                }
            }
            
            
            if cartDishListDetails.count == 1 {
                cell.bgView.layer.cornerRadius = 10
                cell.bgView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
                cell.bottomView.isHidden = true
                //                setShadow(view: bgView)
            } else if indexPath.row == 0 {
                cell.bgView.clipsToBounds = true
                cell.bgView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
                cell.bottomView.isHidden = false
            } else if indexPath.row == cartDishListDetails.count - 1 {
                cell.bgView.clipsToBounds = true
                cell.bgView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
                cell.bottomView.isHidden = true
            } else {
                cell.bgView.clipsToBounds = true
                cell.bgView.layer.cornerRadius = 0
                cell.bottomView.isHidden = false
            }
            
            cell.plusBtn.tag = indexPath.row
            cell.minusBtn.tag = indexPath.row + 100
            
            cell.plusBtn.tag = indexPath.row
            cell.plusBtn.addTarget(self, action: #selector(plusBtnAction(_:)), for: .touchUpInside)
            
            cell.minusBtn.tag = indexPath.row
            cell.minusBtn.addTarget(self, action: #selector(minusBtnAction(_:)), for: .touchUpInside)
            
            cell.multiAddOnTableView.reloadData()
            
            return cell
            
        }
        else if indexPath.section == 2 {
            
            var cell: UITableViewCell? = nil
            
            if selectedType == typeTakeAway {
                cell = cartTableView.dequeueReusableCell(withIdentifier: "GetDirectionTableViewCell", for: indexPath) as! GetDirectionTableViewCell
                
                cell?.selectionStyle = .none
                
                if let cell = cell as? GetDirectionTableViewCell {
                    cell.addressLbl.text = outletDetails?.address
                    cell.locationBtn.addTarget(self, action: #selector(getDiresctionAction(_:)), for: .touchUpInside)
                    cell.outletDetail = outletDetails
                }
                
            } else {
                cell = cartTableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
                
                cell?.selectionStyle = .none
                
                if let cell = cell as? AddressTableViewCell {
                    
                    cell.selectAddressLbl.text = "No Address Selected"
                    
                    cell.changeBtn.addTarget(self, action: #selector(changeButtonAction(_:)), for: .touchUpInside)
                    
                    if self.getAddress != nil {
                        let area = self.getAddress.area
                        let addArea = area.components(separatedBy: ",")
                        print(addArea)
                        cell.deliveryTYpeLbl.isHidden = false
                        cell.deliveryTYpeLbl.text = self.getAddress.type
                        cell.selectAddressLbl.text = self.getAddress.houseNo
                    } else {
                        cell.deliveryTYpeLbl.text = ""
                        cell.selectAddressLbl.text = "No Address Selected"
                    }
                }
            }
            return cell ?? UITableViewCell()
            
        }  else if indexPath.section == 3 {
            
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "SelectDateTableViewCell", for: indexPath) as! SelectDateTableViewCell
            
            cell.selectionStyle = .none
            cell.context = self
            
            cell.cartDetails = self.cartDishDetails
            
            if let selectedDate = UserDefaults.standard.string(forKey: "SelectedDate") {
                cell.selectDateLbl.setTitle(selectedDate, for: .normal)
                cell.selectDateView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                cell.selectDateLbl.tintColor = .white
                
                cell.todayView.backgroundColor = .clear
                cell.todayDateLbl.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            } else {
                cell.todayView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                cell.todayDateLbl.tintColor = .white

                cell.selectDateView.backgroundColor = .clear
                cell.selectDateLbl.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            }
            
            
//            cell.todayView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            
//            if self.cartDishDetails.count > 0 {
//                if self.cartDishDetails[0].expectedDeliveryDate == "" {
//                    if self.setOutlet.count > 0 {
//                        if setOutlet[indexPath.row].isDisabled == 1 {
//                            // Get the date for tomorrow
//                            let tomorrowDate = getTomorrowDate()
//
//                            // Format the date as "Tomorrow, 22 Jul"
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "dd MMM"
//                            let formattedTomorrowDate = "Tomorrow, " + dateFormatter.string(from: tomorrowDate)
//
//                            // Update the label with the formatted date
//                            cell.todayDateLbl.setTitle(formattedTomorrowDate, for: .normal)
//                            cell.todayDateLbl.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//                            //                        cell.todayLbl.tintColor = UIColor.white
//
//                            self.slotDate = formattedTomorrowDate
//                        }
//                    }
//                }
//            }
            
            if self.cartDishDetails.count > 0 {
                if let expectedDeliveryDate = self.cartDishDetails[0].expectedDeliveryDate {
                    // Safely unwrap the optional value
                    cell.todayDateLbl.setTitle(expectedDeliveryDate, for: .normal)
                    //                    cell.todayLbl.tintColor = UIColor.white
                    self.slotDate = expectedDeliveryDate
                    UserDefaults.standard.setValue(slotDate, forKey: "SelectedDateLbl")
                } else {
                    // Get the current date
                    let currentDate = Date()
                    
                    // Get tomorrow's date
//                    let tomorrowDate = getTomorrowDate()
                    
                    // Format the current date as "Today"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMM"
                    let formattedCurrentDate = "Today, " + dateFormatter.string(from: currentDate)
                    
                    // Format tomorrow's date as "Tomorrow"
//                    let formattedTomorrowDate = "Tomorrow, " + dateFormatter.string(from: tomorrowDate)
                    
                    // Update the label with the formatted date
                    cell.todayDateLbl.setTitle(formattedCurrentDate, for: .normal)
                    cell.todayDateLbl.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    
                    slotDate = formattedCurrentDate
                    
                    UserDefaults.standard.setValue(slotDate, forKey: "SelectedDateLbl")

                    filteredTimeSlot = timeSlot
                    
                    self.deliverySlot = timeSlot[indexPath.row].deliverySlotID!
                }
            }

            cell.selectDateLbl.addTarget(self, action: #selector(selectDateAction(_:)), for: .touchUpInside)
            cell.todayDateLbl.addTarget(self, action: #selector(todayBtnAction(_:)), for: .touchUpInside)
            
            
            return cell
            
        } else if indexPath.section == 4 {
            
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "SelectTimeSlotTableViewCell", for: indexPath) as! SelectTimeSlotTableViewCell
            
            cell.selectionStyle = .none

            cell.timeSlot = filteredTimeSlot
            
            if self.cartDishDetails.count > 0 {
                if self.cartDishDetails[0].expectedDeliveryDate == "" {
                    cell.timeSlot = self.timeSlot
                    self.deliverySlot = timeSlot[indexPath.row].deliverySlotID!
                }
            }
            
            cell.timeSlotCollectionView.reloadData()
            
            return cell
            
        }
        
        else if indexPath.section == 5 {
            
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CustomSelectionTableViewCell", for: indexPath) as! CustomSelectionTableViewCell
            
            cell.selectionStyle = .none
            
            selectedTIme = cell.secondLbl.text!
            
            self.cakeCuttingTime = cell.secondLbl.text!
            self.birthDayText = cell.bdatTextField.text!
            self.instructionText = cell.instructionField.text!
            
            if cell.secondLbl.text == "Add Cake Cutting Time Here" {
                cell.secondLbl.font = UIFont.systemFont(ofSize: 14)
                cell.secondLbl.textColor = UIColor.lightGray
            } else {
                cell.secondLbl.font = UIFont.systemFont(ofSize: 14)
                cell.secondLbl.textColor = UIColor.black
            }
            
            cell.instructionField.delegate = self
            cell.instructionField.returnKeyType = .done
            
            cell.bdatTextField.delegate = self
            cell.bdatTextField.returnKeyType = .done
            
            cell.instructionField.returnKeyType = .done
            cell.instructionField.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
            
            cell.bdatTextField.returnKeyType = .done
            cell.bdatTextField.addTarget(self, action: #selector(doneButtonPressed), for: .primaryActionTriggered)
            
            return cell
            
        } else if indexPath.section == 6 {
            
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell", for: indexPath) as! CouponTableViewCell
            
            
            if let voucherMsg = UserDefaults.standard.string(forKey: "Voucher") {
                print("Voucher Applied \(voucherMsg)")
                cell.availableLbl.text = voucherMsg
            } else {
                cell.availableLbl.text = "\(self.voucherList.count)" + " Offers Available"
            }
            
            if !self.cartDishDetails.isEmpty && self.cartDishDetails[0].isVoucherApplied == 1 {
                let xmarkImage = UIImage(systemName: "xmark.circle.fill")
                cell.trailingBtn.setImage(xmarkImage, for: .normal)
                cell.trailingBtn.tintColor = UIColor.black
            } else {
                let xmarkImage = UIImage(systemName: "chevron.right")
                cell.trailingBtn.setImage(xmarkImage, for: .normal)
                cell.trailingBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            }
            
            cell.trailingBtn.addTarget(self, action: #selector(voucherRemoveButtonTapped(_:)), for: .touchUpInside)
            
            return cell
            
        }
        else {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            
            cell.selectionStyle = .none
            
            if cartDishDetails.count > 0 {
                cell.subTotalCount.text = HomeConstant.rupeesSym + cartDishDetails[0].amount!
                cell.coinsCount.text = HomeConstant.rupeesSym + cartDishDetails[0].totalAmount!
                cell.totalCountlabel.text = HomeConstant.rupeesSym + cartDishDetails[0].amountPayable!
                
                if cartDishDetails[0].superCoin! != nil {
                    cell.coinRedemptionLbl.text = "-" + HomeConstant.rupeesSym + cartDishDetails[0].superCoin!
                } else {
                    cell.coinRedemptionLbl.text =  "-" + HomeConstant.rupeesSym + "0"
                }
                
                let deliveryCharge = cartDishDetails[0].deliveryDiscount
                
                let deliveryDiscount = cartDishDetails[0].deliveryCharge
                
                print("deliveryDiscount \(String(describing: deliveryDiscount))")
                
                // Example usage to handle both cases
                if let chargeStringValue = deliveryCharge?.stringValue {
                    cell.deliveryDiscountCountLbl.text = HomeConstant.rupeesSym + chargeStringValue
                } else {
                    cell.deliveryDiscountCountLbl.text = HomeConstant.rupeesSym + "0"
                }
                
                if cartDishDetails[0].voucherDiscount != nil {
                    cell.discountCountLbl.text = "-" + HomeConstant.rupeesSym + cartDishDetails[0].voucherDiscount!
                } else {
                    cell.discountCountLbl.text = HomeConstant.rupeesSym + "0"
                }
            }
            
            if cartDishDetails.count > 0 {
                if set_Del_Type == typeTakeAway {
                    cell.deliveryChargeCount.text = HomeConstant.rupeesSym + "0"
                } else {
                    cell.deliveryChargeCount.text = HomeConstant.rupeesSym + cartDishDetails[0].delAmt!
                }
            }
            
            
            let redeemView = UITapGestureRecognizer(target: self, action: #selector(redeemViewTapped(_:)))
            cell.redeemView.addGestureRecognizer(redeemView)
            
            cell.redeemBtn.addTarget(self, action: #selector(redeemBtnAction(_:)), for: .touchUpInside)
            
            if cartDishDetails.count > 0 {
                isSelect = cartDishDetails[0].isCoinSelect
            }
        
            if isSelect == 0 {
                cell.redeemBtn.isHidden = false
                cell.redeemBtn.tintColor = UIColor.black
                cell.redeemView.backgroundColor = UIColor.systemGreen
                
                is_select = "1"
            } else {
                cell.redeemBtn.isHidden = true
                cell.redeemView.backgroundColor = UIColor.white
                cell.redeemView.layer.borderWidth = 1
                cell.redeemView.layer.borderColor = UIColor.black.cgColor
                cell.redeemView.layer.cornerRadius = 10
                
                is_select = "0"
            }
            
//            if is_select == "1" {
//                cell.redeemBtn.isHidden = false
//                cell.redeemBtn.tintColor = UIColor.black
//                cell.redeemView.backgroundColor = UIColor.systemGreen
//            } else {
//                cell.redeemBtn.isHidden = true
//                cell.redeemView.backgroundColor = UIColor.white
//                cell.redeemView.layer.borderWidth = 1
//                cell.redeemView.layer.borderColor = UIColor.black.cgColor
//                cell.redeemView.layer.cornerRadius = 10
//            }
            
            if addProfileCheck?.customerMobile == nil || addProfileCheck?.customerEmail == nil || addProfileCheck?.dateOfBirth == nil || addProfileCheck?.customerAddress == nil {
                cell.continueBtn.isHidden = true
            } else  if addProfileCheck?.customerMobile == "" || addProfileCheck?.customerEmail == "" || addProfileCheck?.dateOfBirth == "" || addProfileCheck?.customerAddress == "" {
                cell.continueBtn.isHidden = true
            } else {
                cell.continueBtn.isHidden = false
            }
            
            DispatchQueue.main.async {
                if self.addProfileCheck?.customerMobile == nil || self.addProfileCheck?.customerEmail == nil {
                    self.addPersonalLbl.text = "Complete Profile"
                    self.bottomAddPersonalView.visiblity(gone: false, dimension: 50, attribute: .height)
                    if self.bottomHide {
                        self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                    }
                } else if self.addProfileCheck?.customerMobile == "" || self.addProfileCheck?.customerEmail == "" {
                    self.addPersonalLbl.text = "Complete Profile"
                    self.bottomAddPersonalView.visiblity(gone: false, dimension: 50, attribute: .height)
                    if self.bottomHide {
                        self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                    }
                } else if self.addProfileCheck?.customerName == nil || self.addProfileCheck?.customerAddress == nil || self.addProfileCheck?.dateOfBirth == nil {
                    self.bottomAddPersonalView.visiblity(gone: false, dimension: 50, attribute: .height)
                    self.addPersonalLbl.text = "Complete Profile"
                    if self.bottomHide {
                        self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                    }
                } else if self.addProfileCheck?.customerName == "" || self.addProfileCheck?.customerAddress == "" || self.addProfileCheck?.dateOfBirth == "" {
                    self.bottomAddPersonalView.visiblity(gone: false, dimension: 50, attribute: .height)
                    self.addPersonalLbl.text = "Complete Profile"
                    if self.bottomHide {
                        self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                    }
                } else {
                    self.bottomAddPersonalView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                }
            }
            
            let addProfileView = UITapGestureRecognizer(target: self, action: #selector(addProfileViewTapped(_:)))
            self.bottomAddPersonalView.addGestureRecognizer(addProfileView)
            
            cell.continueBtn.tag = indexPath.row
            cell.continueBtn.addTarget(self, action: #selector(continueBtnAction(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }
//        else if indexPath.section == 1 {
//            return 100
//        }
        else if indexPath.section == 1 {
            return UITableView.automaticDimension
       }
        else if indexPath.section == 2 {
            return 100
        } else if indexPath.section == 3 {
            return 80
        } else if indexPath.section == 4 {
            if filteredTimeSlot.count == 0 {
                return 0
            } else {
                return 80
            }
        } else if indexPath.section == 5 {
            return 190
        } else if indexPath.section == 6 {
            return 70
        } else  {
            return 330
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if selectedType != typeTakeAway {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MyAddressViewController") as! MyAddressViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.section == 6 {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ApplyCouponViewController") as! ApplyCouponViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getTomorrowDate() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }
    
    @objc func plusBtnAction(_ sender: UIButton) {
        
        print("Plus button presseddddddd!!!!!!!")
        let row = sender.tag
        
        let quantity = (Int(cartDishDetails[0].cartHasDishDetails[row].quantity!)! + 1)
        self.quantity = String(quantity)
        
        // Set the selected dish_id and size based on the row
        let selectedCartHasDishDetail = cartDishDetails[0].cartHasDishDetails[row]
        self.dish_id = selectedCartHasDishDetail.dishID!
        self.selectedSizeID = selectedCartHasDishDetail.size!
        
        AddToCartApi()
    }
    
    @objc func minusBtnAction(_ sender: UIButton) {
        print("Minus button presseddddddd!!!!!!!")

        let row = sender.tag
        
        let currentQuantity = Int(cartDishDetails[0].cartHasDishDetails[row].quantity!)!
        
        if currentQuantity > 0 {
            let quantity = currentQuantity - 1
            self.quantity = String(quantity)
            
            // Set the selected dish_id and size based on the row
            let selectedCartHasDishDetail = cartDishDetails[0].cartHasDishDetails[row]
            self.dish_id = selectedCartHasDishDetail.dishID!
            self.selectedSizeID = selectedCartHasDishDetail.size!
            
            AddToCartApi()
        }
    }
    
    @objc func backBtnTap(_ sender: UIButton) {
        if !backBtnScreenType {
            self.navigationController?.popViewController(animated: true)
        } else {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let homeViewCOntroller = storyboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
            self.navigationController?.pushViewController(homeViewCOntroller, animated: true)
        }
    }
    
    @objc func takeAwayAction(_ sender: UIButton) {
        let row = sender.tag

        delivery_Type = "Take Away"
        set_Del_Type = "Take Away"
        del_type_api = "Take Away"
        
        UserDefaults.standard.set(set_Del_Type, forKey: "SetDelType")

        delSlotID = self.orderType[row].deliveryID!

        takeAwayView.backgroundColor = UIColor.white
        deliveryView.backgroundColor = nil
        deliveryView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let takeAwayDeliveryVC = storyboard.instantiateViewController(withIdentifier: "TakeAwayDeliveryViewController") as! TakeAwayDeliveryViewController
        takeAwayDeliveryVC.modalPresentationStyle = .overFullScreen
        takeAwayDeliveryVC.type = self.typeTakeAway
        takeAwayDeliveryVC.delegate = self // Assign the delegate to self
        present(takeAwayDeliveryVC, animated: true, completion: nil)
    }
    
    @objc func takeAwayViewTapped(_ sender: UITapGestureRecognizer) {
        let row = sender.view?.tag ?? 0
        delSlotID = self.orderType[row].deliveryID!
        
        delivery_Type = "Take Away"
        set_Del_Type = "Take Away"
        del_type_api = "Take Away"
        
        UserDefaults.standard.set(set_Del_Type, forKey: "SetDelType")
        
        takeAwayView.backgroundColor = UIColor.white
        deliveryView.backgroundColor = nil
        deliveryView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let takeAwayDeliveryVC = storyboard.instantiateViewController(withIdentifier: "TakeAwayDeliveryViewController") as! TakeAwayDeliveryViewController
        takeAwayDeliveryVC.modalPresentationStyle = .overFullScreen
        takeAwayDeliveryVC.type = self.typeTakeAway
        takeAwayDeliveryVC.delegate = self
        present(takeAwayDeliveryVC, animated: true, completion: nil)
    }
    
    
    @objc func deliveryViewTapped(_ sender: UITapGestureRecognizer) {
        let row = sender.view?.tag ?? 0
        delSlotID = self.orderType[row].deliveryID!

        delivery_Type = "Delivery"
        del_Type = "Delivery"
        set_Del_Type = "Delivery"
        del_type_api = "Delivery"
        
        UserDefaults.standard.set(set_Del_Type, forKey: "SetDelType")

        deliveryView.backgroundColor = UIColor.white
        takeAwayView.backgroundColor = nil
        deliveryView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let takeAwayDeliveryVC = storyboard.instantiateViewController(withIdentifier: "TakeAwayDeliveryViewController") as! TakeAwayDeliveryViewController
        takeAwayDeliveryVC.modalPresentationStyle = .overFullScreen
        takeAwayDeliveryVC.type = self.typeDelivery
        takeAwayDeliveryVC.delegate = self
        present(takeAwayDeliveryVC, animated: true, completion: nil)
        
    }
    
    
    @objc func deliveryAction(_ sender: UIButton) {
        let row = sender.tag

        delivery_Type = "Delivery"
        del_Type = "Delivery"
        set_Del_Type = "Delivery"
        del_type_api = "Delivery"
        
        UserDefaults.standard.set(set_Del_Type, forKey: "SetDelType")

        delSlotID = self.orderType[row].deliveryID!

        
        deliveryView.backgroundColor = UIColor.white
        takeAwayView.backgroundColor = nil
        deliveryView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let takeAwayDeliveryVC = storyboard.instantiateViewController(withIdentifier: "TakeAwayDeliveryViewController") as! TakeAwayDeliveryViewController
        takeAwayDeliveryVC.modalPresentationStyle = .overFullScreen
        takeAwayDeliveryVC.type = self.typeDelivery
        takeAwayDeliveryVC.delegate = self // Assign the delegate to self
        present(takeAwayDeliveryVC, animated: true, completion: nil)
    }
    
    @objc func changeButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyAddressViewController") as! MyAddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func getDiresctionAction(_ sender: UIButton) {
        print("get Direction Func")
    }
    
    @objc func addProfileViewTapped(_ sender: UITapGestureRecognizer) {
        
        if addProfileCheck?.customerMobile == nil || addProfileCheck?.customerMobile == "" {
            self.addPersonalLbl.text = "Add Personal Details"
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddPersonalDetailsViewController") as! AddPersonalDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else if addProfileCheck?.customerEmail == nil || addProfileCheck?.customerEmail == "" || addProfileCheck?.dateOfBirth == "" || addProfileCheck?.dateOfBirth == nil || addProfileCheck?.customerAddress == nil || addProfileCheck?.customerAddress == "" || addProfileCheck?.customerName == nil || addProfileCheck?.customerName == "" {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.addPersonalLbl.text = "Complete Profile"
            vc.cartScreen = "Cart"
            UserDefaults.standard.set("Cart", forKey: "CartScreen")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func continueBtnAction(_ sender: UIButton) {
        
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "CustomSelectionTableViewCell") as! CustomSelectionTableViewCell
        
        NotificationCenter.default.addObserver(forName: .timeDidChange, object: nil, queue: .main) { notification in
            if let time = notification.object as? String {
                self.selectedTIme = time
            }
        }
        
        if set_Del_Type == "Delivery" {
            if self.getAddress == nil {
                showAlert(message: "Please Add Address")
            } else if cell.secondLbl.text == "Add Cake Cutting Time Here" {
                showAlert(message: "Please select cake cutting time first")
            } else if timeSlot.isEmpty {
                paymentOptionApi()
            } else if UserDefaults.standard.value(forKey: "SlotID") != nil {
                paymentOptionApi()
            } else {
                showAlert(message: "Please select your slot")
            }
        } else if cell.secondLbl.text == "Add Cake Cutting Time Here" {
            showAlert(message: "Please select cake cutting time first")
        } else {
            paymentOptionApi()
        }
    }
    
    @objc func redeemViewTapped(_ sender: UITapGestureRecognizer) {
        if is_select == "0" {
            redeemApi(is_Select_num: "1")
        } else {
            redeemApi(is_Select_num: "0")
        }
    }
    
    @objc func redeemBtnAction(_ sender: UIButton) {
        redeemApi(is_Select_num: "0")
    }
    
    @objc func voucherRemoveButtonTapped(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "Voucher")
        UserDefaults.standard.synchronize()
        
        if !self.cartDishDetails.isEmpty && self.cartDishDetails[0].isVoucherApplied == 1 {
            voucherRemoveApi()
        } else {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ApplyCouponViewController") as! ApplyCouponViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func timeLabelTapped(_ sender: UITapGestureRecognizer) {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "CustomSelectionTableViewCell") as! CustomSelectionTableViewCell
        
        
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
            cell.secondLbl.textAlignment = .center // align center
            cell.secondLbl.text = formatter.string(from: datePicker.date)
            self.selectedTIme = formatter.string(from: datePicker.date)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            alertController.popoverPresentationController?.sourceView = window
            alertController.popoverPresentationController?.sourceRect = cell.secondLbl.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc func selectDateAction(_ sender: UIButton) {
        // Get the index path of the cell containing the button
        let buttonPosition = sender.convert(CGPoint.zero, to: self.cartTableView)
        if let indexPath = self.cartTableView.indexPathForRow(at: buttonPosition) {
            if let cell = self.cartTableView.cellForRow(at: indexPath) as? SelectDateTableViewCell {
                cell.selectDateView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                cell.selectDateLbl.tintColor = .white
                
                cell.todayView.backgroundColor = .clear
                cell.todayDateLbl.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                
                let datePicker = UIDatePicker()
                datePicker.datePickerMode = .date
                
                // Get the current date
                let currentDate = Date()
                
                let calendar = Calendar.current
                // Calculate tomorrow's date
                if let tomorrowDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                    // Set tomorrow's date as the minimum date for the datePicker
                    datePicker.minimumDate = tomorrowDate
                    
                    // Automatically select tomorrow's date in the date picker
                    datePicker.date = tomorrowDate
                    
                    let contentViewController = UIViewController()
                    contentViewController.view.addSubview(datePicker)
                    datePicker.translatesAutoresizingMaskIntoConstraints = false
                    datePicker.centerXAnchor.constraint(equalTo: contentViewController.view.centerXAnchor).isActive = true
                    datePicker.centerYAnchor.constraint(equalTo: contentViewController.view.centerYAnchor).isActive = true
                    
                    let alertController = UIAlertController(title: "Select Date", message: nil, preferredStyle: .actionSheet)
                    let attributedTitle = NSAttributedString(string: "Select Date", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
                    alertController.setValue(attributedTitle, forKey: "attributedTitle")
                    alertController.setValue(contentViewController, forKey: "contentViewController")
                    
                    let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
                        let formatter = DateFormatter()
                        formatter.dateStyle = .medium
                        let selectedDate = datePicker.date
                        
                        // Check if the selected date is not today or a past date
                        if selectedDate >= tomorrowDate {
                            let components = calendar.dateComponents([.day, .month, .year], from: selectedDate)
                            
                            if let day = components.day, let month = components.month, let year = components.year {
                                cell.selectDateLbl.setTitle("\(year)-\(month)-\(day)", for: .normal)
                                self.slotDate = (cell.selectDateLbl.titleLabel?.text)!
                                UserDefaults.standard.setValue("\(year)-\(month)-\(day)", forKey: "SelectedDate")
                            }
                            
                            self.filteredTimeSlot = self.timeSlot
                            self.selectType = "SelectDate"
                            self.cartTableView.reloadData()
                        } else {
                            // Handle the case where the user selected today or a past date
                            // You can show an error message or take appropriate action here
                        }
                    }
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
                    alertController.addAction(doneAction)
                    alertController.addAction(cancelAction)
                    
                    // Present the alert controller
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func todayBtnAction(_ sender: UIButton) {
        self.filterList()
        self.selectType = "CurrentDate"
        UserDefaults.standard.removeObject(forKey: "SelectedDate")
        self.cartTableView.reloadData()
    }
    
    @objc func doneButtonPressed() {
        view.endEditing(true) // Hide the keyboard
    }
}

extension CartViewController {
    
    private func initialLoads() {

        emptyCartImage.image = UIImage(named: "online_shop")
        
        exploreBtn.setTitle("Explore", for: .normal)
        exploreBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        exploreBtn.layer.borderWidth = 1.0
        exploreBtn.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        exploreBtn.layer.cornerRadius = 10
        
        emptyLbl.text = "Your Cart is Empty"
        emptyLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        contentLbl.text = "Looks like you haven't made your choice yet"
        contentLbl.font = UIFont.boldSystemFont(ofSize: 16)
        contentLbl.textColor = UIColor.lightGray
        contentLbl.numberOfLines = 2
        
        bottomAddPersonalView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        bottomAddPersonalView.isUserInteractionEnabled = true
        
        self.cartEmptyViewBackBtn.isHidden = false
    }
}
