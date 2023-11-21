//
//  CakeAddonScreen.swift
//  EliteCake
//
//  Created by Apple - 1 on 16/02/23.
//

import UIKit
import Cosmos
import iOSDropDown

class CakeAddonScreen: UIViewController {
    
    @IBOutlet weak var addItemLbl: UILabel!
    @IBOutlet weak var dishTotalLbl: UILabel!
    @IBOutlet weak var nextLbl: UILabel!
//    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var viewCartLbl: UILabel!

    @IBOutlet weak var nextBtnView: UIView!
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var cakeAddonTableView: UITableView! {
        didSet {
            //Register TableView Cells
            cakeAddonTableView.register(CakeDetailQuantityCell.nib, forCellReuseIdentifier: CakeDetailQuantityCell.identifier)
            cakeAddonTableView.register(SuggesstionTableViewCell.nib
                                        , forCellReuseIdentifier: SuggesstionTableViewCell.identifier)
            cakeAddonTableView.register(ChangeFlavourTableViewCell.nib, forCellReuseIdentifier: ChangeFlavourTableViewCell.identifier)
            cakeAddonTableView.register(SecondAddonTableViewCell.nib, forCellReuseIdentifier: SecondAddonTableViewCell.identifier)
            cakeAddonTableView.separatorStyle = .none
            cakeAddonTableView.dataSource = self
            cakeAddonTableView.delegate = self
            cakeAddonTableView.backgroundColor = .clear
            cakeAddonTableView.showsVerticalScrollIndicator = false
            cakeAddonTableView.showsHorizontalScrollIndicator = false
            cakeAddonTableView.tableFooterView = UIView()
        }
    }
    
    var customerID: String = ""
    var oID: String = ""
    var outlet_id: String = ""
    var dish_id: String = ""
    var dish_name: String = ""
    var selectedPoundPrice: String = ""
    var quantity: String = "1"
    var size: String = ""
    var selectedSizeID: String = ""
    var selectedName: String = ""
    var addOnSizeId: String = ""
    var addOnCatID: String = ""
    var addOnCount: Int = 0
    var videoScreen: String = ""
    var dishAddCount: Int?
    var addTocartSuccess: Bool = false

    var foodFavotiteCheck: Bool = false
    var poundOptions = [String]()
    var poundId = [Int]()
    var poundPrice = [String]()
    var sizeName = [String]()
    var sizeID = [String]()
    var dishPrice: Int = 0
    var newCount = 0
    var dropDownSelectIndex: Int = 0
    var addOnCounts: [Int] = []
    
    var newAddonCount: Int = 0
    
    var AddonDatas: [Suggested] = []
    var AddonResponse: AddonDish? = nil
    var addonDatasList: [AddonDetailsCatAdddon] = []
    var fetchAddONList: [FetchAddon] = []
    var fetchCategory: FetchCategory?
    var selectedAddonDish: [String] = []
    var addonListParams: FetchAddOnParameters?
    var addOnPriceAdded: String = ""
    var addonPricecheck: String = ""
    var singleAddon: String = ""
    var addOnPriceValues: [String] = []
    var totalValue = 0 // Initialize the total value
    var valueToRemove: String = ""
    var mergedAddonDishSet: Set<String> = Set() // Property to store the merged set

    var newAddonDetails: [DishAddonDetailsCat] = []
    var selectedAddOnCounts: [Int] = [] // Keep track of selected add-ons
    var currentPrice: Int = 0 // Initialize with the initial price
    
    var originalPrice: Int = 0
    var singleAddOnPrice: Int = 0
    var multiAddOnPrice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        designSetUp()
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dishPriceAdded(_:)),
                                               name: .addOnDishPriceAdded,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dishPriceRemoved(_:)),
                                               name: .addOnDishPriceremoved,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addonPrice(_:)), name: .addOnPrice, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addonPriceDisselect(_:)), name: .addOnPriceDisselect, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelectedAddOnDish(_:)), name: .selectedAddOnDish, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(multiaddonPrice(_:)), name: .multiaddOnPrice, object: nil)
                
        NotificationCenter.default.addObserver(self, selector: #selector(multiaddonPriceDisselect(_:)), name: .multiaddOnPriceDisselect, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMultipleSelectedAddOnDish(_:)), name: .selectedMultipleAddOnDish, object: nil)
        
        // Create a UITapGestureRecognizer and add it to your UILabel
        let addItemapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        addItemLbl.addGestureRecognizer(addItemapGesture)

        // Make sure userInteractionEnabled is enabled for the label
        addItemLbl.isUserInteractionEnabled = true
        
        let dishTotalGestuture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        dishTotalLbl.addGestureRecognizer(dishTotalGestuture)

        // Make sure userInteractionEnabled is enabled for the label
        dishTotalLbl.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonTapped))
        nextBtnView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cakeAddonApi()
        cartShowingApi()
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .addOnDishPriceAdded, object: nil)
        NotificationCenter.default.removeObserver(self, name: .addOnDishPriceremoved, object: nil)
    }
    
    func designSetUp() {
        nextBtnView.backgroundColor = .white
        nextBtnView.layer.cornerRadius = 10
        
        nextLbl.font = UIFont.systemFont(ofSize: 12)
        nextLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        viewCartLbl.text = "View Cart"
        viewCartLbl.font = UIFont.systemFont(ofSize: 12)
        viewCartLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        dishTotalLbl.text = "Click To Add"
        dishTotalLbl.font = UIFont.systemFont(ofSize: 16)
        
        addItemLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        nextLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        addToCartView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        addToCartView.layer.masksToBounds = true
        addToCartView.layer.cornerRadius = 20
        setShadow(view: addToCartView)
    }
    
    // MARK:- Notification
    @objc private func dishPriceAdded(_ notification: Notification) {
        
        if let count = notification.userInfo?["count"] as? Int {
            
            self.dishAddCount = count
            
            originalPrice = Int(self.selectedPoundPrice)!

            dishPrice = multiAddOnPrice + (Int(self.selectedPoundPrice)! * count) + addOnCount

            self.addItemLbl.text = HomeConstant.rupeesSym + String(dishPrice)
            self.quantity = String(count)
            self.dishTotalLbl.text = "Click to add"
            
        }
    }
    
    // MARK:- Notification
    @objc private func dishPriceRemoved(_ notification: Notification) {
        
        if let count = notification.userInfo?["count"] as? Int {
            
            self.dishAddCount = count
            
            dishPrice = multiAddOnPrice + (Int(self.selectedPoundPrice)! * count) + addOnCount

            self.addItemLbl.text = HomeConstant.rupeesSym + String(dishPrice)
            self.dishTotalLbl.text = "Click to add"
            self.quantity = String(count)
        }
    }
    
    @objc private func addonPriceDisselect(_ notification: Notification) {
        
        if let dishAddonPrice = self.addItemLbl.text {
            if let newAddOnCount = notification.userInfo?["addonPriceDisselect"] as? String {
                // Remove the currency symbol from dishAddonPrice
                let numericPriceString = dishAddonPrice.replacingOccurrences(of: HomeConstant.rupeesSym, with: "")
                
                addOnCount -= Int(newAddOnCount)!
                print("Disselect value \(multiAddOnPrice)")
                
                let total = multiAddOnPrice + (Int(self.selectedPoundPrice)! * Int(self.quantity)!) + addOnCount
                
                self.addItemLbl.text = HomeConstant.rupeesSym + String(total)

            } else {
                // Handle the case where newAddOnCount is not a valid String
                print("newAddOnCount is not a valid String")
            }
        } else {
            // Handle the case where self.addItemLbl.text is nil
            print("self.addItemLbl.text is nil")
        }
    }

    
    @objc private func addonPrice(_ notification: Notification) {
        if self.dishTotalLbl.text == "Click to add" {
            if let newAddOnCount = notification.userInfo?["addonPrice"] as? String {
                
                if let dishAddonPrice = self.addItemLbl.text {
                    // Remove the currency symbol from dishAddonPrice
                    let numericPriceString = dishAddonPrice.replacingOccurrences(of: HomeConstant.rupeesSym, with: "")

                    // Check if numericPriceString can be converted to an integer
                    if let dishPriceValue = Int(numericPriceString), let quantityValue = Int(self.quantity), let addOnCountValue = Int(newAddOnCount) {
                        
                        addonPricecheck = String(newAddOnCount)

                        addOnCount = Int(newAddOnCount)!
                        
                        dishPrice = (Int(self.selectedPoundPrice)! * Int(self.quantity)!) + addOnCount + multiAddOnPrice

                        self.addItemLbl.text = HomeConstant.rupeesSym + String(dishPrice)
                        
                        self.addItemLbl.text = HomeConstant.rupeesSym + String(dishPrice)
                        self.dishTotalLbl.text = "Click to add"
                    } else {
                        // Handle the case where the conversion to Int fails
                        print("Conversion to Int failed")
                    }
                } else {
                    // Handle the case where self.addItemLbl.text is nil
                    print("self.addItemLbl.text is nil")
                }
            }
        } else {
            if let newAddOnCount = notification.userInfo?["addonPrice"] as? String {
                addOnCount = Int(newAddOnCount)!
                dishPrice = (Int(self.selectedPoundPrice)! * Int(self.quantity)!) + addOnCount
                self.addItemLbl.text = HomeConstant.rupeesSym + String(dishPrice)
                self.dishTotalLbl.text = "Click to add"
            }
        }
    }


    @objc private func multiaddonPrice(_ notification: Notification) {
        if let newAddOnCount = notification.userInfo?["MultiaddonPrice"] as? String {
            
            multiAddOnPrice += Int(newAddOnCount)!
            
            let total = multiAddOnPrice + (Int(self.selectedPoundPrice)! * Int(self.quantity)!) + addOnCount
                                    
            addOnPriceValues.append(newAddOnCount)

            addOnPriceAdded = newAddOnCount
            
            self.addItemLbl.text = HomeConstant.rupeesSym + String(total)
        }
    }
    
    @objc private func multiaddonPriceDisselect(_ notification: Notification) {
        if let removedAddOnCount = notification.userInfo?["MultiaddonPriceDisselect"] as? String {
            if let count = Int(removedAddOnCount) {
                
                multiAddOnPrice -= Int(removedAddOnCount)!
                
                let total = multiAddOnPrice + (Int(self.selectedPoundPrice)! * Int(self.quantity)!) + addOnCount
                
                self.addItemLbl.text = HomeConstant.rupeesSym + String(total)
            }
        }
    }
    
    private func calculateTotalCountAndPrice() {
        if let currentPriceString = self.addItemLbl.text?.replacingOccurrences(of: HomeConstant.rupeesSym, with: ""),
           let currentPrice = Int(currentPriceString) {
            
            let newPrice = currentPrice + newAddonCount
            
            self.addItemLbl.text = HomeConstant.rupeesSym + String(newPrice)
            
            // Update dishTotalLbl to indicate that it can be clicked
            self.dishTotalLbl.text = "Click to add"
        }
    }

    @objc func handleSelectedAddOnDish(_ notification: Notification) {
        if let selectedAddOnDishArray = notification.userInfo?["selectedAddOnDish"] as? [String] {
            // Remove the previous counts from the set
            for count in self.selectedAddonDish {
                mergedAddonDishSet.remove(count)
            }

            // Add the new count
            mergedAddonDishSet.formUnion(selectedAddOnDishArray)

            // Update the selectedAddonDish array
            self.selectedAddonDish = selectedAddOnDishArray

            // Convert the set back to an array
            let mergedAddonDishArray = Array(mergedAddonDishSet)
            
            self.selectedAddonDish = mergedAddonDishArray

            // Post the merged array
            NotificationCenter.default.post(name: .mergedSelectedAddOnDish, object: nil, userInfo: ["mergedAddOnDish": mergedAddonDishArray])
        }
    }

    @objc func handleMultipleSelectedAddOnDish(_ notification: Notification) {
        if let selectedMultipleAddOnDishArray = notification.userInfo?["selectedMultipleAddOnDish"] as? [String] {
            // Access and use the addOnDishList array
            
            // Merge the sets to avoid duplicates
            mergedAddonDishSet.formUnion(selectedMultipleAddOnDishArray)

            // Convert the set back to an array if needed
            let mergedAddonDishArray = Array(mergedAddonDishSet)

            self.selectedAddonDish = mergedAddonDishArray


            NotificationCenter.default.post(name: .mergedSelectedAddOnDish, object: nil, userInfo: ["mergedAddOnDish": mergedAddonDishArray])
        }
    }


    
    @objc func nextButtonTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.backButton = "backButton"
        vc.backBtnScreenType = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func labelTapped() {
        // Call the addtocart() API here
        AddToCartApi()
    }
    
    //Cake Detail API
    func cakeAddonApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + dish_id)
        let url = URL(string: ApiConstant.CAKEADDON)
        
        let parameters = [
            "dish_id": dish_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID
        ] as [String : Any]
        
        print("cakeaddon params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        showAlert(message: "Api Status \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CakeAddonResponse.self, from: data)
                    
                    print("cakeaddon response \(response)")
                    
                    if response.success {
                        
                        self.AddonDatas = response.parameters.dish.suggested!
                        self.AddonResponse = response.parameters.dish
                        
                        if !response.parameters.dish.addonDetailsCat!.isEmpty {
                            self.newAddonDetails = response.parameters.dish.addonDetailsCat!
                        }
                        
                        
                        if let addonDetailsCat = self.AddonResponse?.addonDetailsCat, !addonDetailsCat.isEmpty, let addonCategoryID = addonDetailsCat[0].addonCategoryID as? String {
                            UserDefaults.standard.set(addonCategoryID, forKey: "addoncartid")
                        }
                        
                        if let dishSizes = self.AddonResponse?.dishsizes, !dishSizes.isEmpty {
                            self.addOnSizeId = dishSizes[0].sizeDetailsSize.sizeID
                        }
                        
                        if let firstAddonCat = response.parameters.dish.addonDetailsCat?.first,
                           let addonList = firstAddonCat.addonDetailsCatAdddon {
                            self.addonDatasList = addonList
                            
                        } else {
                            // Handle the case when addonDetailsCat or addonDetailsCatAdddon is nil
                            self.addonDatasList = []
                        }
                        
                        if (self.AddonResponse?.addonDetailsCat?.count)! > 0 {
                            self.addonApi()
                        } else {
                            print("addon detail cat count else ")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.cakeAddonTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("cake addon error res localize \(error)")
                }
            }
        }
    }
    
    //FavoriteAdd Api Call
    func FavoriteAddApi() {
        //        self.showLoader()
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.ADDFAVOURITE)
        
        let parameters = [
            "dish_id": dish_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
        
        print("flavour addparams \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddFavouriteResponse.self, from: data)
                    print("AddFav Response \(response)")
                } catch {
                    self.hideLoader()
                    print("error res \(error)")
                }
            }
        }
    }
    
    //FavoriteRemove Api Call
    func FavoriteRemoveApi() {
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.REMOVEFAVOURITE)
        
        let parameters = [
            "dish_id": dish_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
        
        print("flavour removeparams \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CommonResponse.self, from: data)
                    print("removeFav Response \(response)")
                } catch {
                    print("error res \(error)")
                }
            }
        }
    }
    
    //Add To Cart API
    func AddToCartApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        
        let url = URL(string: ApiConstant.ADDTOCART)
        
        let parameters = [
            "dish_id": dish_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "size" : selectedSizeID,
            "quantity" : quantity,
            "addon" : self.selectedAddonDish
        ] as [String : Any]
        
        print("addtocart params \(parameters)")
        
        self.showLoader()
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddToCartResponse.self, from: data)
                    
                    print("addtocart response \(response)")
                    DispatchQueue.main.async {
                        self.cakeAddonTableView.reloadData()
                        
                        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
                        vc.dish_id = self.dish_id
                        
                        if response.success {
                            self.addTocartSuccess = true
                            
                            
                            let cell = self.cakeAddonTableView.dequeueReusableCell(withIdentifier: "ChangeFlavourTableViewCell") as! ChangeFlavourTableViewCell

                            cell.changeFlavourCollectionview.reloadData()
                            
                            let cell1 = self.cakeAddonTableView.dequeueReusableCell(withIdentifier: "SecondAddonTableViewCell") as! SecondAddonTableViewCell
                            
                            cell1.changeFlavourCollectionview.reloadData()

                            
                            self.addItemLbl.text = "Item Added"
                            self.dishTotalLbl.text = self.quantity
                            
                            self.cartShowingApi()
                        }
                        
                        self.hideLoader()

                    }
                } catch {
                    
                    self.hideLoader()

                    print("Addtocart error res localize \(error)")
                }
            }
        }
    }
    
    func addonApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        if let cat_ID = UserDefaults.standard.string(forKey: "addoncartid"){
            addOnCatID = cat_ID
            }
        
        let hash = md5(string: ApiConstant.salt_key + dish_id)
        let url = URL(string: ApiConstant.ADDON_API)
        
        let parameters = [
            "dish_id": dish_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "addon_size" : addOnSizeId,
            "addon_category_id" : addOnCatID
        ] as [String : Any]
        
        print("newaddon params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FetchAddOnResponse.self, from: data)
                    
                    print("newaddon response \(response)")
                    
                    if response.success {
                        self.fetchAddONList = response.parameters!.addon
                        print("New Addon Items \(self.fetchAddONList)")
                        self.fetchCategory = response.parameters?.category
                    } else {
                        self.fetchAddONList = []
                        print("New Addon Items \(self.fetchAddONList)")
                    }
            

                    DispatchQueue.main.async {
                        self.cakeAddonTableView.reloadData()
                    }
                } catch {
                    print("newaddon error res localize \(error)")
                }
            }
        }
    }
    
    func newAddonApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        if let cat_ID = UserDefaults.standard.string(forKey: "addoncartid"){
            addOnCatID = cat_ID
            }
        
        let hash = md5(string: ApiConstant.salt_key + dish_id)
        let url = URL(string: ApiConstant.ADDON_API)
        
        let parameters = [
            "dish_id": dish_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "addon_size" : addOnSizeId,
            "addon_category_id" : addOnCatID
        ] as [String : Any]
        
        print("newaddon params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FetchAddOnResponse.self, from: data)
                    
                    print("newaddon response \(response)")
                    
                    if response.success {
                        self.fetchAddONList = response.parameters!.addon
                        print("New Addon Items \(self.fetchAddONList)")
                        self.fetchCategory = response.parameters?.category
                    } else {
                        self.fetchAddONList = []
                        print("New Addon Items \(self.fetchAddONList)")
                    }
            

                    DispatchQueue.main.async {
                        self.cakeAddonTableView.reloadData()
                    }
                } catch {
                    print("newaddon error res localize \(error)")
                }
            }
        }
    }

    
    //Cake Detail API
    func cartShowingApi() {

        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.CARTSHOWING)
        
        let parameters = [
            "outlet_id": outlet_id,
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
                    self.hideLoader()
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CartShowingResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        if response.success {
                                if response.parameters.cart?.count != 0 {
                                    self.nextLbl.text = HomeConstant.rupeesSym + response.parameters.cart![0].amount!
                                    print("Addon Amount \(response.parameters.cart![0].amount!)")
                                    self.dishTotalLbl.text = "Click To add"
                                } else {
                                    self.nextLbl.text = HomeConstant.rupeesSym + " 0"
                                }
                            if self.addTocartSuccess {
                                if response.parameters.cart?.count != 0 {
                                    self.addItemLbl.text = self.quantity
                                    self.dishTotalLbl.text = "Item Added"
                                } else {
                                    self.nextLbl.text = HomeConstant.rupeesSym + " 0"
                                }
                                
                            }
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    print("cart Showing error res localize \(error)")
                    self.hideLoader()
                }
            }
        }
    }
}

extension CakeAddonScreen: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if AddonResponse?.addonDetailsCat?.count == 0 {
            
            return 2
        } else {
            if newAddonDetails.count == 2 {
                return 4
            } else {
                return 3
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "CakeDetailQuantityCell", for: indexPath) as! CakeDetailQuantityCell
            cell.selectionStyle = .none
            cell.context = self
            cell.addonDish = AddonResponse
            
            cell.cakeNameLbl.text = AddonResponse?.dishName
            
            if AddonResponse?.descriptiveImage != nil {
                cell.cakeImage.sd_setImage(with: URL(string: AddonResponse!.dishImage), placeholderImage: UIImage(named: "no_image"))
            }
            
            if let dishRating = AddonResponse?.dishRating, let ratingDouble = Double(dishRating) {
                cell.ratingView.rating = ratingDouble
            } else {
                cell.ratingView.rating = 4.0
            }
            
            
            if AddonResponse?.dishType == "veg" {
                cell.vegNonvegImg.image = UIImage(named: "vegImage")
            } else {
                cell.vegNonvegImg.image = UIImage(named: "nonVegImage")
            }
            
            if AddonResponse?.foodFavorite == true {
                // Load the original image
                let originalImage = UIImage(named: "heart_fill")
                // Create a new image with the desired color
                let tintedImage = originalImage?.withTintColor(.red)
                cell.addFavBtn.setImage(tintedImage, for: .normal)
            } else {
                // Load the original image
                let originalImage = UIImage(named: "heart")
                // Create a new image with the desired color
                let tintedImage = originalImage?.withTintColor(.red)
                // Set the tinted image as the button's image
                cell.addFavBtn.setImage(tintedImage, for: .normal)
            }
            
            cell.addFavBtn.tag = indexPath.row
            cell.addFavBtn.addTarget(self, action: #selector(favBtnAction(_:)), for: .touchUpInside)
            
            if let dishSizes = AddonResponse?.dishsizes {
                poundOptions = []
                poundPrice = []
                
                for size in dishSizes {
                    let line1 = "\(size.sizeDetailsSize.sizeName) \(size.sizeDetailsSize.unit?.unitName ?? "") \("(RS") \(size.dsDishPrice)\(")")"
                    let line2 = "Best Price \(size.landingPrice) with coupon"
                    
                    let option = "\(line1)\n\(line2)"
                    poundOptions.append(option)
                    poundPrice.append(size.dsDishPrice)
                    
                    sizeName.append(size.sizeDetailsSize.sizeName)
                    sizeID.append(size.sizeDetailsSize.sizeID)
                    
                    if let unwrappedId = Int(size.sizeDetailsSize.sizeID) {
                        poundId.append(unwrappedId)
                    }
                }
                
                // Customize the appearance of the dropdown
                cell.dropDown.textColor = UIColor.black
                
                // Set the list of options
                cell.dropDown.optionArray = poundOptions
                
                // Set the optional ID values
                cell.dropDown.optionIds = poundId
                cell.dropDown.text = poundOptions[self.dropDownSelectIndex]
                self.selectedPoundPrice = poundPrice[self.dropDownSelectIndex]
                self.selectedName = self.sizeName[self.dropDownSelectIndex]
                self.selectedSizeID = self.sizeID[self.dropDownSelectIndex]
                
                self.addItemLbl.text = HomeConstant.rupeesSym + poundPrice[self.dropDownSelectIndex]
                
                print("update price default price \(poundPrice[self.dropDownSelectIndex])")
                
                // The the Closure returns Selected Index and String
                cell.dropDown.didSelect{ [self] (selectedText , index ,id) in
                    self.dropDownSelectIndex = index
                    self.selectedPoundPrice = self.poundPrice[self.dropDownSelectIndex]
                    self.addItemLbl.text = HomeConstant.rupeesSym + self.poundPrice[self.dropDownSelectIndex]
                    
                    print("update price count \(self.poundPrice[self.dropDownSelectIndex])")
                    
                    self.selectedName = self.sizeName[self.dropDownSelectIndex]
                    self.selectedSizeID = self.sizeID[self.dropDownSelectIndex]
                    
                    self.addOnSizeId = (self.AddonResponse?.dishsizes[self.dropDownSelectIndex].sizeDetailsSize.sizeID)!
                    
                    self.addonApi()
                    
                    if let count = Int(cell.countLbl.text ?? "1") {
                        self.newCount = count
                        cell.countLbl.text = "\(self.newCount)"
                        print("update price quantity count \(self.newCount)")
                        selectedName = "\(self.newCount)"
                    }
                    
                    let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "ChangeFlavourTableViewCell", for: indexPath) as! ChangeFlavourTableViewCell
                    
                    cell.selectedFlavourButton?.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                    cell.selectedFlavourButton?.tintColor = UIColor.gray
                    
                    NotificationCenter.default.post(name: .addOnDishPriceAdded, object: nil, userInfo: ["count": newCount])
                }
            }
            
            return cell
            
        }
        
        if AddonResponse?.addonDetailsCat?.count == 0 && addonListParams == nil {
            let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SuggesstionTableViewCell", for: indexPath) as! SuggesstionTableViewCell
            
            cell.selectionStyle = .none
            cell.suggestionDatas = AddonDatas
            cell.suggestionCollectionView.reloadData()
            cell.suggestionCollectionView.showsHorizontalScrollIndicator = false
            cell.context = self
            
            return cell
        } else {
            if indexPath.section == 1 {
                if !newAddonDetails.isEmpty {
                    if newAddonDetails[0].addonCategorySequenceNo == "1" {
                        let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "ChangeFlavourTableViewCell", for: indexPath) as! ChangeFlavourTableViewCell

                        cell.selectionStyle = .none
                        cell.changeFlavourCollectionview.showsHorizontalScrollIndicator = false
                        cell.changeFlavourDatasDatas = AddonResponse
                        cell.changeFlavourTitleLbl.text = newAddonDetails[0].addonCategoryName
                        cell.addonDatasList = addonDatasList
                        
                        cell.fetchAddon = self.fetchAddONList
                        cell.fetchCategory = self.fetchCategory
                        cell.changeFlavourCollectionview.reloadData()

                        return cell
                    } else if newAddonDetails[0].addonCategorySequenceNo == "2" {
                        let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SecondAddonTableViewCell", for: indexPath) as! SecondAddonTableViewCell

                        cell.selectionStyle = .none
                        cell.changeFlavourCollectionview.showsHorizontalScrollIndicator = false
                        cell.changeFlavourDatasDatas = AddonResponse
                        cell.addonDatasList = addonDatasList
                        
                        if newAddonDetails.count == 2 {
                            cell.changeFlavourTitleLbl.text = newAddonDetails[1].addonCategoryName
                        } else {
                            cell.changeFlavourTitleLbl.text = newAddonDetails[0].addonCategoryName
                        }

                        // Assuming that newAddonDetails[0].addonDetailsCatAdddon is not nil
                        cell.fetchAddon = newAddonDetails[0].addonDetailsCatAdddon!
                                                
                        cell.newAddonList = newAddonDetails
                        cell.fetchCategory = self.fetchCategory
                        cell.changeFlavourCollectionview.reloadData()

                        return cell
                    } else {
                        let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SuggesstionTableViewCell", for: indexPath) as! SuggesstionTableViewCell

                        cell.selectionStyle = .none
                        cell.suggestionDatas = AddonDatas
                        cell.suggestionCollectionView.showsHorizontalScrollIndicator = false
                        cell.context = self
                        cell.suggestionCollectionView.reloadData()

                        return cell
                    }
                } else {
                    let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SuggesstionTableViewCell", for: indexPath) as! SuggesstionTableViewCell

                    cell.selectionStyle = .none
                    cell.suggestionDatas = AddonDatas
                    cell.suggestionCollectionView.showsHorizontalScrollIndicator = false
                    cell.context = self
                    cell.suggestionCollectionView.reloadData()

                    return cell
                }
            } else if indexPath.section == 2 {
                if !newAddonDetails.isEmpty {
                    if newAddonDetails.count == 2 {
                        let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SecondAddonTableViewCell", for: indexPath) as! SecondAddonTableViewCell

                        cell.selectionStyle = .none
                        cell.changeFlavourCollectionview.showsHorizontalScrollIndicator = false
                        cell.changeFlavourDatasDatas = AddonResponse
                        cell.addonDatasList = addonDatasList
                        
                        if newAddonDetails.count == 2 {
                            cell.changeFlavourTitleLbl.text = newAddonDetails[1].addonCategoryName
                        } else {
                            cell.changeFlavourTitleLbl.text = newAddonDetails[0].addonCategoryName
                        }
                        
                        // Assuming that newAddonDetails[0].addonDetailsCatAdddon is not nil
                        cell.fetchAddon = newAddonDetails[0].addonDetailsCatAdddon!
                                                
                        cell.newAddonList = newAddonDetails
                        cell.fetchCategory = self.fetchCategory
                        cell.changeFlavourCollectionview.reloadData()

                        return cell
                    } else {
                        let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SuggesstionTableViewCell", for: indexPath) as! SuggesstionTableViewCell
                        
                        cell.selectionStyle = .none
                        cell.suggestionDatas = AddonDatas
                        cell.suggestionCollectionView.showsHorizontalScrollIndicator = false
                        cell.context = self
                        cell.suggestionCollectionView.reloadData()

                        return cell
                    }
                } else {
                    let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SuggesstionTableViewCell", for: indexPath) as! SuggesstionTableViewCell
                    
                    cell.selectionStyle = .none
                    cell.suggestionDatas = AddonDatas
                    cell.suggestionCollectionView.showsHorizontalScrollIndicator = false
                    cell.context = self
                    cell.suggestionCollectionView.reloadData()

                    return cell
                }
            } else {
                let cell = cakeAddonTableView.dequeueReusableCell(withIdentifier: "SuggesstionTableViewCell", for: indexPath) as! SuggesstionTableViewCell
                
                cell.selectionStyle = .none
                cell.suggestionDatas = AddonDatas
                cell.suggestionCollectionView.showsHorizontalScrollIndicator = false
                cell.context = self
                cell.suggestionCollectionView.reloadData()

                return cell
            }
        }
    }
    
    func filledHeart(sender: UIButton, isFavorite: Bool) {
        let imageName = isFavorite ? "heart_fill" : "heart"
        let originalImage = UIImage(named: imageName)
        let tintedImage = originalImage?.withTintColor(.red)
        sender.setImage(tintedImage, for: .normal)
    }
    
    @objc func favBtnAction(_ sender: UIButton) {
        dish_id = AddonResponse!.dishID
        dish_name = AddonResponse!.dishName
        
        let foodFavotiteCheck = AddonResponse?.foodFavorite
        
        if foodFavotiteCheck! {
            AddonResponse?.foodFavorite = false
            filledHeart(sender: sender, isFavorite: false)
            FavoriteRemoveApi()
            showToast(message: dish_name + "is Remove to My Wishlist")
        } else {
            AddonResponse?.foodFavorite = true
            filledHeart(sender: sender, isFavorite: true)
            FavoriteAddApi()
            showToast(message: dish_name + "is Add to My Wishlist")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if AddonResponse?.addonDetailsCat?.count == 0 {
            if indexPath.section == 0 {
                return 340
            } else {
                return 400
            }
        } else {
            if newAddonDetails.count == 1 {
                if indexPath.section == 0 {
                    return 340
                } else if indexPath.section == 1  {
                    return 200
                } else {
                    return 400
                }
            } else {
                if indexPath.section == 0 {
                    return 340
                } else if indexPath.section == 1  {
                    return 200
                } else if indexPath.section == 2  {
                    return 200
                }else {
                    return 400
                }
            }
        }
    }
}


