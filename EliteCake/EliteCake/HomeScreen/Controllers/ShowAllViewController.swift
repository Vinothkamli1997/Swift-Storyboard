//
//  ShowAllViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 22/02/23.
//

import UIKit

class ShowAllViewController: UIViewController, FilterViewControllerDelegate, UITextFieldDelegate, PopUpDelegate {
    func closeBtnTapped(_ alert: PopUpViewController, alertTag: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func recommendBtnTapped(_ alert: PopUpViewController, sortName: String) {
        self.sortName = sortName
        
        self.isLoading = true
        
        current_page = 1
        
        showAllDishApi()
                
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var showAllTableView: UITableView! {
        didSet {
            //Register TableView Cells
            showAllTableView.register(DishDetailsTableViewCell.nib, forCellReuseIdentifier: DishDetailsTableViewCell.identifier)
            
            showAllTableView.separatorStyle = .none
            showAllTableView.dataSource = self
            showAllTableView.delegate = self
            showAllTableView.backgroundColor = .clear
            showAllTableView.showsVerticalScrollIndicator = false
            showAllTableView.showsHorizontalScrollIndicator = false
            showAllTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var showAllHeaderCollectionView: UICollectionView!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var filterLbl: UILabel!
    
    @IBOutlet weak var filterCountLbl: UILabel!
    
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var sortLbl: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var dishCountLbl: UILabel!
    @IBOutlet weak var cartPriceLbl: UILabel!
    
    @IBOutlet weak var nextBtnView: UIView!
    @IBOutlet weak var nextLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var viewCartLbl: UILabel!
    
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var vegSwitch: UISwitch!
    @IBOutlet weak var vegLbl: UILabel!
    
    @IBOutlet weak var nonVegSwitch: UISwitch!
    @IBOutlet weak var nonVegLbl: UILabel!
    
    var cusine_id: String = ""
    var dish_id: String = ""
    var dish_name: String = ""
    var customerID: String = ""
    var oID: String = ""
    var outlet_id: String = ""
    var searchText: String = ""
    var sortName: String = ""
    var vegNonVegType: String = ""
    var total_pages: Int = 1
    var current_page: Int = 1
    var isloader: Bool = false
    var isLoading: Bool = true
    var cartID: String = ""
    
    var selectedSizeID: String = ""
    var quantity: String = ""
    
    var showAllDishList: [FlavourDish] = []
    var tag_id: [TagID] = []
    var tag_Category_id: [TagCategoryID] = []
    
    var tagIDStrings: [String] = []
    var categoryIDString: [String] = []
    var filterList: [Cusine] = []
    var applyFilterCatID: [Filter] = []
    var applyFilterTagID: [TagsActive] = []
    
    var selectedIndexPath: IndexPath?
    
    var newFilterValue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        HomeApi()

        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(filterViewTapped))
        filterView.addGestureRecognizer(tapGesture)
        
        let sortViewaction = UITapGestureRecognizer(target: self, action: #selector(sortViewTapped))
        sortView.addGestureRecognizer(sortViewaction)
        
        let nextViewTap = UITapGestureRecognizer(target: self, action: #selector(nextViewTapped))
        nextBtnView.addGestureRecognizer(nextViewTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleOkButtonPressed), name: Notification.Name("OkButtonPressed"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        filterFetchApi()
        cartShowingApi()
    }
    
    func setUp() {
        self.searchTextField.delegate = self
        
        self.addView.isHidden = false
        self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        showAllHeaderCollectionView.register(MenuDishCollectionViewCell.nib, forCellWithReuseIdentifier: "MenuDishCollectionViewCell")
        showAllHeaderCollectionView.dataSource = self
        showAllHeaderCollectionView.delegate = self
        
        selectedIndexPath = IndexPath(item: 0, section: 0)
        showAllHeaderCollectionView.reloadData()
        
        searchBgView.backgroundColor = UIColor(named: "ViewDarkMode")
        searchBgView.layer.cornerRadius = 10
        setLightShadow(view: searchBgView)
        
        
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.tintColor = UIColor.darkGray
        
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = .clear
        searchTextField.placeholder = "Search..."
        
        vegLbl.isHidden = true
        self.vegLbl.visiblity(gone: true, dimension: 0.0, attribute: .height)
        vegSwitch.isHidden = true
        self.vegSwitch.visiblity(gone: true, dimension: 0.0, attribute: .height)

        nonVegLbl.isHidden = true
        self.nonVegLbl.visiblity(gone: true, dimension: 0.0, attribute: .height)
        nonVegSwitch.isHidden = true
        self.nonVegSwitch.visiblity(gone: true, dimension: 0.0, attribute: .height)

        vegLbl.text = "Veg"
        vegLbl.textColor = UIColor.black
        vegLbl.font = UIFont.systemFont(ofSize: 14)
        
        nonVegSwitch.onTintColor = UIColor.red
        
        nonVegLbl.text = "Non Veg"
        nonVegLbl.textColor = UIColor.black
        nonVegLbl.font = UIFont.systemFont(ofSize: 14)
        
        filterView.backgroundColor = UIColor(named: "PureWhite")
        filterLbl.textColor = UIColor.black
        filterBtn.tintColor = UIColor.black
        
        filterBtn.setImage(UIImage(named: "Sort"), for: .normal)
        sortBtn.setImage(UIImage(named: "Sort"), for: .normal)
        
        
        sortView.backgroundColor = UIColor(named: "PureWhite")
        sortLbl.textColor = UIColor.black
        sortBtn.tintColor = UIColor.black
        
        addView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        nextBtnView.backgroundColor = .white
        nextBtnView.layer.cornerRadius = 10
        
        nextLbl.font = UIFont.systemFont(ofSize: 12)
        nextLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        viewCartLbl.text = "View Cart"
        viewCartLbl.font = UIFont.systemFont(ofSize: 12)
        viewCartLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        nextBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        nextBtn.tintColor = .white
        
        cartPriceLbl.text = "In Cart"
        cartPriceLbl.textColor = .white
        cartPriceLbl.font = UIFont.systemFont(ofSize: 12)
        
        vegSwitch.isOn = true
        nonVegSwitch.isOn = true
    }
    
    @IBAction func searchFiledAction(_ sender: UITextField) {
        performAction()
    }
    
    @IBAction func closeAction(_ sender: UITextField) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartDiscartPopUpViewController") as! CartDiscartPopUpViewController
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc func handleOkButtonPressed() {
        // Handle the notification here
        print("Ok button was pressed")
        removeCartApi()
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction() {
        searchText = searchTextField.text!
        
        self.isLoading = true
        showAllDishApi()
    }
    
    //UIView Tap Navigate To Filter ViewController
    @objc func filterViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sortViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc func nextViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.backButton = "backButton"
        vc.backBtnScreenType = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // This method is called when the second view controller is done and sends back data
    func FilterViewControllerDidFinish(with data: (tagCategoryIDs: [TagCategoryID], tagIDs: [TagID])) {
        tag_id = data.tagIDs
        tag_Category_id = data.tagCategoryIDs
        
        if tag_id.count == 0 {
            filterCountLbl.isHidden = true
        } else {
            filterCountLbl.isHidden = false
            filterCountLbl.text = "\(tag_id.count)"
            print("counttttt \(tag_id.count)")
            filterCountLbl.textColor = UIColor.white
            filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            filterCountLbl.layer.cornerRadius = 8
            filterCountLbl.layer.masksToBounds = true
        }
        
        isLoading = false
        
        showAllDishApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "CreateCakeViewController") as! CreateCakeViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    @IBAction func vegSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            vegNonVegType = "veg"
        } else {
            vegNonVegType = "non-veg"
        }
        
        if !vegSwitch.isOn && !nonVegSwitch.isOn {
            vegNonVegType = ""
        }
        
        if vegSwitch.isOn && nonVegSwitch.isOn {
            vegNonVegType = ""
        }
        
        self.isLoading = true
        showAllDishApi()
    }
    
    @IBAction func nonVegSwitchAction(_ sender: UISwitch) {
        
        if sender.isOn {
            vegNonVegType = "non-veg"
        } else {
            vegNonVegType = "veg"
        }
        
        if !nonVegSwitch.isOn && !vegSwitch.isOn {
            vegNonVegType = ""
        }
        
        if vegSwitch.isOn && nonVegSwitch.isOn {
            vegNonVegType = ""
        }
        
        self.isLoading = true
        showAllDishApi()
    }
    
    
    //HomeAPI Call
    func HomeApi() {
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let outletID = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = outletID
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.homeScreen)
        
        let parameters = [
            "customer_details_id": customerID,
            "outlet_id": outlet_id,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("filterhome paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    self.filterList = response.parameters.cusine
                    print("check filt cusine \(self.filterList)")
                    
                    DispatchQueue.main.async {
                        self.showAllHeaderCollectionView.reloadData()
                    }
                } catch {
                    print("error res \(error)")
                }
            }
        }
    }
    
    //CusineDetail Call
    func showAllDishApi() {
        
        if isLoading {
            self.showLoader()
            isLoading = false
        } else {
            print("show All Loader \(isLoading)")
        }
        
        if let storedTagIDStrings = UserDefaults.standard.array(forKey: "SelectedTagIDs") as? [String] {
            print("Stored Tag IDs: \(storedTagIDStrings)")
            tag_id = storedTagIDStrings.map { TagID(tagID: $0) }
            
            DispatchQueue.main.async {
                if storedTagIDStrings.count == 0 {
                    self.filterCountLbl.isHidden = true
                } else {
                    self.filterCountLbl.isHidden = false
                    self.filterCountLbl.text = "\(storedTagIDStrings.count)"
                    self.filterCountLbl.textColor = UIColor.white
                    self.filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                    self.filterCountLbl.layer.cornerRadius = 8
                    self.filterCountLbl.layer.masksToBounds = true
                }
            }
        } else {
            print("No stored Tag IDs found.")
        }
        
        if let storedTagIDStrings = UserDefaults.standard.array(forKey: "SelectedCatTagIDs") as? [String] {
            print("Stored Tag IDs: \(storedTagIDStrings)")
            let uniqueTagCategoryIDs = Array(Set(storedTagIDStrings)) // Remove duplicates
            
            tag_Category_id = uniqueTagCategoryIDs.map { TagCategoryID(tagCategoryID: $0) }
            
        } else {
            print("No stored Tag IDs found.")
        }

        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + cusine_id)
        let url = URL(string: ApiConstant.CUSINEWITHDISH)
        
        let parameters = [
            "cuisine_id": cusine_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "tag_category_id" : tag_Category_id.map { $0.tagCategoryID },
            "tag_id" : tag_id.map { $0.tagID },
            "search" : searchText,
            "sort" : sortName,
            "dish_type" : vegNonVegType,
            "page" : current_page
        ] as [String : Any]
        
        print("showall params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FlavourCusineResponse.self, from: data)
                    
                    if response.success {
                        
                        if let dishList = response.parameters?.dish {
                            self.showAllDishList = dishList
                        }
                                                
                        self.total_pages = response.parameters?.page.totalPages ?? 0
                        
                        DispatchQueue.main.async {
                            
                            if response.parameters == nil {
                                
                                self.showAllDishList = []
                                self.showAllTableView.reloadData()
                                
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                                vc.modalPresentationStyle = .overCurrentContext
                                vc.context = self
                                self.present(vc, animated: false, completion: nil)
                            } else {
                                self.showAllTableView.reloadData()
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.showAllDishList = []
                            
                            self.showAllTableView.reloadData()

                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                            
                            vc.context = self
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("showall error res \(error)")
                }
            }
        }
    }
    
    //FavoriteAdd Api Call
    func FavoriteAddApi() {
        self.showLoader()
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
        
        print("flavour params \(parameters)")
        
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
                    
                    
                    DispatchQueue.main.async {
                        self.showAllTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("error res \(error)")
                }
            }
        }
    }
    
    //FavoriteRemove Api Call
    func FavoriteRemoveApi() {
        self.showLoader()
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
        
        print("flavour params \(parameters)")
        
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
                    
                    DispatchQueue.main.async {
                        self.showAllTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("error res \(error)")
                }
            }
        }
    }
    
    //RemoveFilter Api Call
    func filterFetchApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.FILTER_FETCH_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID
        ] as [String : Any]
        
        print("fetchFiter params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { [self] (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FilterFetchResponse.self, from: data)
                    
                    if response.success {
                        if response.parameters != nil {
                            tag_id = response.parameters!.tagID
                            
                            tag_Category_id = response.parameters!.tagCategoryID
                        }
                        
                        DispatchQueue.main.async {
                            if self.tag_id.count == 0 {
                                print("check filter count else \(self.tag_id.count)")
                                self.filterCountLbl.isHidden = true
                            } else {
                                self.filterCountLbl.text = "\(self.tag_id.count)"
                                print("check filter count \(self.tag_id.count)")
                                self.filterCountLbl.textColor = UIColor.white
                                self.filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                                self.filterCountLbl.layer.cornerRadius = 8
                                self.filterCountLbl.layer.masksToBounds = true
                            }
                        }
                        
                        self.showAllDishApi()
                    } else {
                        tag_id = []
                        tag_Category_id = []
                        
                        DispatchQueue.main.async {
                            if self.tag_id.count == 0 {
                                print("check filter count else \(self.tag_id.count)")
                                self.filterCountLbl.isHidden = true
                            } else {
                                self.filterCountLbl.text = "\(self.tag_id.count)"
                                print("check filter count \(self.tag_id.count)")
                                self.filterCountLbl.textColor = UIColor.white
                                self.filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                                self.filterCountLbl.layer.cornerRadius = 8
                                self.filterCountLbl.layer.masksToBounds = true
                            }
                        }
                        
                        self.showAllDishApi()
                    }
                } catch {
                    print("fetch Filter error res \(error)")
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
                    DispatchQueue.main.async {
                        self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CartShowingResponse.self, from: data)
                    if response.success {
                        if response.parameters.cart!.count > 0 {
                            self.cartID = response.parameters.cart![0].cartID!
                        }
                        DispatchQueue.main.async {
                            if response.parameters.totalItems == 0 {
                                print("show all cat count \(response.parameters.totalItems)")
                                self.addBtn.isHidden = true
                                self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                                
                            } else {
                                self.addBtn.isHidden = false
                                self.addView.visiblity(gone: false, dimension: 50, attribute: .height)
                            }
                            
                            if response.parameters.cart!.count > 0 {
                                self.nextLbl.text = HomeConstant.rupeesSym + response.parameters.cart![0].amountPayable!
                            }
                            self.dishCountLbl.text = String(response.parameters.totalItems) + " Item"
                        }
                    }
                } catch {
                    print("cart Showing error res localize \(error)")
                }
            }
        }
    }
    
    func showAllDishScrollApi() {
        
//         newFilterValue = false
        
        isloader = true
        
        if isloader {
            if newFilterValue {
                self.showLoader()
                isloader = false

            } else {
                self.hideLoader()
            }
        }
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + cusine_id)
        let url = URL(string: ApiConstant.CUSINEWITHDISH)
        
        let parameters = [
            "cuisine_id": cusine_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "tag_category_id" : tag_Category_id.map { $0.tagCategoryID },
            "tag_id" : tag_id.map { $0.tagID },
            "search" : searchText,
            "sort" : sortName,
            "page" : current_page
        ] as [String : Any]
        
        print("showall category \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        // Show toast message for non-200 response
                        self.showToast(message: "Server Error")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FlavourCusineResponse.self, from: data)
                    
                    if response.success {
                        
                        if let dishList = response.parameters?.dish {
                            self.showAllDishList.append(contentsOf: dishList)
                        }
                        
                        DispatchQueue.main.async {
                            if response.parameters == nil {
                                self.showAllDishList = []
                                self.showAllTableView.reloadData()
                                
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                                vc.modalPresentationStyle = .overCurrentContext
                                vc.context = self
                                self.present(vc, animated: false, completion: nil)
                            } else {
                                self.showAllTableView.reloadData()
                                self.current_page = 1
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.isloader = false
                            self.newFilterValue = true
                        }
                    }
                    
                    self.hideLoader()
                    self.isloader = false
                    
                } catch {
                    self.hideLoader()
                    self.isloader = false
                    print("showall Category error res \(error)")
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
                    self.hideLoader()
                    
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
    
    func removeCartApi() {
        
        self.showLoader()
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.remove_cart)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "outlet_id": outlet_id,
            "cart_id": cartID,
            "id":oID
        ] as [String : Any]
        
        print("remove cart params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { [self] (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(DiscartResponse.self, from: data)
                    
                    print("remove discart success")
                    
                    if response.success {
                        self.hideLoader()
                        
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                            self.cartShowingApi()
                        }
                    }
                    
                } catch {
                    print("remove cart error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
}


extension ShowAllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showAllDishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showAllTableView.dequeueReusableCell(withIdentifier: "DishDetailsTableViewCell", for: indexPath) as! DishDetailsTableViewCell
        
        cell.context = self
        cell.selectionStyle = .none
        
        if let urlString = showAllDishList[indexPath.row].dishImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image") // Optional placeholder image
            cell.cakeImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
        
        cell.cakeName.text = showAllDishList[indexPath.row].dishName
        cell.cakeFlavourName.text = HomeConstant.IN + showAllDishList[indexPath.row].category.categoryName
        
//        cell.ratingView.rating = Double(showAllDishList[indexPath.row].dishRating)!
        
        if showAllDishList[indexPath.row].dishRating == "" {
            cell.ratingView.rating = Double(4)
        } else {
            cell.ratingView.rating = Double(showAllDishList[indexPath.row].dishRating)!
        }
        
        cell.addView.visiblity(gone: false, dimension: 100, attribute: .width)
        cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
        
//        if showAllDishList[indexPath.row].cartHasDishDetails.count > 0 {
//            cell.PlusMinusView.visiblity(gone: false, dimension: 100, attribute: .width)
//            cell.addView.visiblity(gone: true, dimension: 0.0, attribute: .width)
//
//            cell.countLbl.text = showAllDishList[indexPath.row].cartHasDishDetails[0].quantity
//        }
        
        cell.realPriceLbl.text = HomeConstant.rupeesSym + showAllDishList[indexPath.row].dishPrice!
        cell.discountPriceLbl.text = HomeConstant.rupeesSym + showAllDishList[indexPath.row].dishDiscounts!
        cell.discountPercentage.text = showAllDishList[indexPath.row].discountPercentage + HomeConstant.percentageSym
        cell.landingPriceLbl.text = HomeConstant.rupeesSym + showAllDishList[indexPath.row].landingPrice
        cell.cakeBakedTypeLbl.text = showAllDishList[indexPath.row].availability
        
//        cell.poundLbl.text = "(" + showAllDishList[indexPath.row].dishsizes[0].sizeDetailsSize.sizeName + showAllDishList[indexPath.row].dishsizes[0].sizeDetailsSize.unit!.unitName + ")"
        
        if let size = showAllDishList[indexPath.row].dishsizes.first?.sizeDetailsSize {
            let labelText = "(\(size.sizeName) \(size.unit!.unitName))"
            cell.poundLbl.text = labelText
        } else {
            // Handle the case where there are no elements in dishsizes or sizeDetailsSize is nil
            cell.poundLbl.text = "N/A" // or any other appropriate fallback
        }

        
        let custom = showAllDishList[indexPath.row].customerApplicableClass
        
        if custom != nil || custom != "" {
            cell.customizeLbl.text = "Customizable"
        } else {
            cell.customizeLbl.isHidden = true
        }
        
        if showAllDishList[indexPath.row].tag == "Premium" {
            cell.cakeTypeLbl.setTitle(showAllDishList[indexPath.row].tag, for: .normal)
            cell.cakeTypeLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PREMIUMCOLOR)
            cell.cakeTypeLbl.tintColor = UIColor.white
        } else if showAllDishList[indexPath.row].tag == "Elite"{
            cell.cakeTypeLbl.setTitle(showAllDishList[indexPath.row].tag, for: .normal)
            cell.cakeTypeLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            cell.cakeTypeLbl.tintColor = UIColor.white
        } else {
            cell.cakeTypeLbl.setTitle(showAllDishList[indexPath.row].tag, for: .normal)
            cell.cakeTypeLbl.backgroundColor = UIColor(hexFromString: ColorConstant.BASICCOLOR)
            cell.cakeTypeLbl.tintColor = UIColor.white
        }
        
        if showAllDishList[indexPath.row].dishType == "veg" {
            cell.vegNonvegImg.image = UIImage(named: "vegImage")
        } else {
            cell.vegNonvegImg.image = UIImage(named: "nonVegImage")
        }
        
        if showAllDishList[indexPath.row].availability == "Instantly Baked" {
            cell.availabilityTypeImg.image = UIImage(named: "instantly")
            cell.cakeBakedTypeLbl.textColor = UIColor(hexFromString: ColorConstant.INSTANTLY)
        }
        else if showAllDishList[indexPath.row].availability.contains("Freshly") {
            cell.availabilityTypeImg.image = UIImage(named: "freshlybaked")
            cell.cakeBakedTypeLbl.textColor = UIColor(hexFromString: ColorConstant.FREASHLY)
        }
        else {
            cell.availabilityTypeImg.image = UIImage(named: "speciallybaked")
            cell.cakeBakedTypeLbl.textColor = UIColor(hexFromString: ColorConstant.SPECIALLY)
        }
        
        
        //Add or remove favorite
        if showAllDishList[indexPath.row].foodFavorite == true {
            // Load the original image
            let originalImage = UIImage(named: "heart_fill")
            // Create a new image with the desired color
            let tintedImage = originalImage?.withTintColor(.red)
            // Set the tinted image as the button's image
            cell.favBtn.setImage(tintedImage, for: .normal)
        } else {
            // Load the original image
            let originalImage = UIImage(named: "heart")
            // Create a new image with the desired color
            let tintedImage = originalImage?.withTintColor(.red)
            // Set the tinted image as the button's image
            cell.favBtn.setImage(tintedImage, for: .normal)
        }
        
        if ((showAllDishList[indexPath.row].dishsizes.count) == 1) && (showAllDishList[indexPath.row].addonDetailsCat.count) == 0 {
            print("no add add-on there")
            if showAllDishList[indexPath.row].cartHasDishDetails.count > 0 {
                let addonCountValue = Int(showAllDishList[indexPath.row].cartHasDishDetails[0].quantity)
                if addonCountValue! > 0 {
                    cell.PlusMinusView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.addView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                    cell.countLbl.text = showAllDishList[indexPath.row].cartHasDishDetails[0].quantity
                }
            }
        } else {
            print("add add-on there")
            cell.addView.visiblity(gone: false, dimension: 100, attribute: .width)
            cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
        }
        
        if showAllDishList[indexPath.row].dishAvailability != "Available" {
            cell.addView.cornerRadius = 10
            cell.addView.layer.borderWidth = 2
            cell.addView.layer.borderColor = UIColor.gray.cgColor
            
            cell.addLbl.text = "ADD"
            cell.addLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.addLbl.textColor = UIColor.gray
            
            cell.addView.backgroundColor = UIColor(named: "AddViewBgColor")
            
            cell.plusLbl.textColor = UIColor.gray
        }
        
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(favBtnAction(_:)), for: .touchUpInside)
        
        cell.favBtnView.tag = indexPath.row
        let favBtnViewAction = UITapGestureRecognizer(target: self, action: #selector(favBtnViewTapped))
        cell.favBtnView.addGestureRecognizer(favBtnViewAction)
        
        cell.infoBtn.tag = indexPath.row
        cell.infoBtn.addTarget(self, action: #selector(infoBtTapped(_:)), for: .touchUpInside)
        
        cell.addView.tag = indexPath.row
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didAddTapView))
        cell.addView.addGestureRecognizer(tapGesture)
        
        cell.plusBtn.tag = indexPath.row
        cell.plusBtn.addTarget(self, action: #selector(plusBtnAction(_:)), for: .touchUpInside)
        
        cell.minusBtn.tag = indexPath.row
        cell.minusBtn.addTarget(self, action: #selector(minusBtnAction(_:)), for: .touchUpInside)

        return cell
    }
    
    func filledHeart(sender: UIButton, isFavorite: Bool) {
//        let row = sender.tag
        let imageName = isFavorite ? "heart_fill" : "heart"
        let originalImage = UIImage(named: imageName)
        let tintedImage = originalImage?.withTintColor(.red)
        sender.setImage(tintedImage, for: .normal)
    }
    
    @objc func didAddTapView(_ sender: UITapGestureRecognizer) {
        let row = sender.view?.tag ?? 0
        
        if showAllDishList[row].dishAvailability == "Available" {
            if ((showAllDishList[row].dishsizes.count) > 1) || (showAllDishList[row].addonDetailsCat.count) >= 1 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as? CakeAddonScreen,
                      let view = sender.view,
                      let index = view.tag as? Int else {
                    return
                }
                let selectedDish = showAllDishList[index]
                vc.dish_id = selectedDish.dishID
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let indexPath = IndexPath(row: row, section: 0)
                if let cell = showAllTableView.cellForRow(at: indexPath) as? DishDetailsTableViewCell {
                    cell.PlusMinusView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.addView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                    
                    cell.countLbl.text = "1"
                }
                
                self.dish_id = showAllDishList[row].dishID
                self.quantity = "\(1)"
                self.selectedSizeID = showAllDishList[row].dishsizes[0].sizeDetailsSize.sizeID
                
                AddToCartApi()
            }
        } else {
            print("Add view tapped dish un available")
            showAlert(message: "this dish Currently Unavailbale")
        }
    }
    
    @objc func plusBtnAction(_ sender: UIButton) {
        let row = sender.tag
        if let cell = showAllTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? DishDetailsTableViewCell {

        print("plus btn tappeddddddd")
        
            if let count = Int(cell.countLbl.text ?? "1") {
                let newCount = count + 1
                cell.countLbl.text = "\(newCount)"
                
                self.dish_id = showAllDishList[row].dishID
                self.quantity = "\(newCount)"
                self.selectedSizeID = showAllDishList[row].dishsizes[0].sizeDetailsSize.sizeID
                                
                AddToCartApi()
            } else {
                print("plus btn tappeddddddd else")
            }
        }
    }
    
    @objc func minusBtnAction(_ sender: UIButton) {
        let row = sender.tag
        if let cell = showAllTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? DishDetailsTableViewCell {

        print("plus btn tappeddddddd")
            
            var newCount = 0
            if let count = Int(cell.countLbl.text ?? "1") {
                newCount = max(0, count - 1)
                cell.countLbl.text = "\(newCount)"
                
                self.dish_id = showAllDishList[row].dishID
                self.quantity = "\(newCount)"
                self.selectedSizeID = showAllDishList[row].dishsizes[0].sizeDetailsSize.sizeID
                
                if newCount == 0 {
                    cell.addView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                }
                
                AddToCartApi()

            }
        }
    }
    
    @objc func favBtnAction(_ sender: UIButton) {
        let row = sender.tag
        dish_id = showAllDishList[row].dishID
        dish_name = showAllDishList[row].dishName
        
        if showAllDishList[row].foodFavorite! {
            showAllDishList[row].foodFavorite = false
            filledHeart(sender: sender, isFavorite: false)
            FavoriteRemoveApi()
            showToast(message: dish_name + "is Remove to My Wishlist")
        } else {
            showAllDishList[row].foodFavorite = true
            filledHeart(sender: sender, isFavorite: true)
            FavoriteAddApi()
            showToast(message: dish_name + "is Add to My Wishlist")
        }
    }
    
    @objc func favBtnViewTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view, let button = view as? UIButton {
            // Retrieve the row from the tapped button's tag
            let row = button.tag

            dish_id = showAllDishList[row].dishID
            dish_name = showAllDishList[row].dishName

            if showAllDishList[row].foodFavorite! {
                showAllDishList[row].foodFavorite = false
                filledHeart(sender: button, isFavorite: false)
                FavoriteRemoveApi()
                showToast(message: dish_name + " is Removed from My Wishlist")
            } else {
                showAllDishList[row].foodFavorite = true
                filledHeart(sender: button, isFavorite: true)
                FavoriteAddApi()
                showToast(message: dish_name + " is Added to My Wishlist")
            }
        }
    }
    
    @objc func infoBtTapped(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = showAllDishList[row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            if total_pages > current_page {
                current_page += 1
                isloader = true
                newFilterValue = true
                showAllDishScrollApi()
            }
        }
    }
}

extension ShowAllViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("check cusine fil count \(filterList.count)")
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuDishCollectionViewCell", for: indexPath) as? MenuDishCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.filterNameLbl.text = filterList[indexPath.row].cuisineName
        
        if indexPath == selectedIndexPath {
            cell.filterNameLbl.textColor = UIColor.white
            cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        } else {
            cell.filterNameLbl.textColor = UIColor.gray
            cell.bgView.backgroundColor = UIColor.white
            cell.bgView.layer.borderColor = UIColor.gray.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            // If selected cell is already selected, do nothing
            return
        }
        
        // Deselect the previously selected item if a new one is selected
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? MenuDishCollectionViewCell {
                previousCell.filterNameLbl.textColor =  UIColor.gray
                previousCell.bgView.backgroundColor = UIColor.white
                previousCell.bgView.layer.borderColor = UIColor.gray.cgColor
            }
        }
        
        // Update the selected index path and style the new cell
        selectedIndexPath = indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuDishCollectionViewCell {
            cell.filterNameLbl.textColor = UIColor.white
            cell.bgView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            cell.bgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
            
            print("check cusine fil click id \(filterList[indexPath.row].cuisineID)")
            print("check cusine filList \(filterList[indexPath.row])")
            cusine_id = filterList[indexPath.row].cuisineID
            searchText = ""
            current_page = 1

            isLoading = true
            
            searchText = searchTextField.text!
            showAllDishApi()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = showAllDishList[indexPath.row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: 50)
    }
    
}

