//
//  FlavourCusineViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 13/02/23.
//

import UIKit

class FlavourCusineViewController: UIViewController, CusineWithDishTableViewCellDelegate, PopUpDelegate, FilterViewControllerDelegate {
    
    func recommendBtnTapped(_ alert: PopUpViewController, sortName: String) {
        self.sortName = sortName
        
        CusineDetailApi()
        
        self.dismiss(animated: true, completion: nil)
        
        self.sortName = ""

    }
    
    func closeBtnTapped(_ alert: PopUpViewController, alertTag: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var addItemView: UIView!
    
    @IBOutlet weak var additemLbl: UILabel!
    @IBOutlet weak var dishTotalLbl: UILabel!
    
    @IBOutlet weak var nextBtnView: UIView!
    @IBOutlet weak var nextBtnLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var viewCartLbl: UILabel!

    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var filterCountLbl: UILabel!
    
    @IBOutlet weak var sortView: UIView!
    
    @IBOutlet weak var filterBtnIcon: UIButton!
    
    @IBOutlet weak var sortBgnIcon: UIButton!
    
    @IBOutlet weak var vegSwitch: UISwitch!
    
    @IBOutlet weak var nonVegSwitch: UISwitch!
    
    @IBOutlet weak var vegLbl: UILabel!
    
    @IBOutlet weak var nonVegLbl: UILabel!
    
    @IBOutlet weak var flavouCusineTableView: UITableView!{
        didSet {
            //Register TableView Cells
            flavouCusineTableView.register(CusineWithDishTableViewCell.nib, forCellReuseIdentifier: CusineWithDishTableViewCell.identifier)
            flavouCusineTableView.separatorStyle = .none
            flavouCusineTableView.dataSource = self
            flavouCusineTableView.delegate = self
            flavouCusineTableView.backgroundColor = .clear
            flavouCusineTableView.showsVerticalScrollIndicator = false
            flavouCusineTableView.showsHorizontalScrollIndicator = false
            flavouCusineTableView.tableFooterView = UIView()
        }
    }
    
    var cusine_id: String = ""
    var dish_id: String = ""
    var dish_name: String = ""
    var customerID: String = ""
    var oID: String = ""
    var outlet_id: String = ""
    var flavourCusineDatas: [FlavourDish] = []
    var favMessage: CommonResponse!
    var addItem: Bool = true
    var dishPrice: Int = 0
    var dishAmount: String = ""
    var sortName: String = ""
    var vegNonVegType: String = ""
    var isLoading: Bool = true
    var quantity: String = ""
    var selectedSizeID: String = ""
    var cartID: String = ""
    
    var total_pages: Int = 1
    var current_page: Int = 1
    
    var tag_id: [TagID] = []
    var tag_Category_id: [TagCategoryID] = []
    
    var tagIDStrings: [TagID] = []
    var categoryIDString: [TagCategoryID] = []
    
    
    var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"HomeScreen", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        setUp()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(filterViewTapped))
        filterView.addGestureRecognizer(tapGesture)
        
        let sortViewaction = UITapGestureRecognizer(target: self, action: #selector(sortViewTapped))
        sortView.addGestureRecognizer(sortViewaction)
        
        let nextView = UITapGestureRecognizer(target: self, action: #selector(nextViewTapped))
        nextBtnView.addGestureRecognizer(nextView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleOkButtonPressed), name: Notification.Name("OkButtonPressed"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterFetchApi()
        cartShowingApi()
    }
    
    
    func setUp() {
        addItemView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        additemLbl.textColor = UIColor.white
        additemLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        dishTotalLbl.textColor = UIColor.white
        dishTotalLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        nextBtnLbl.textColor = UIColor.white
        
        filterBtnIcon.setImage(UIImage(named: "Sort"), for: .normal)
        sortBgnIcon.setImage(UIImage(named: "Sort"), for: .normal)
        
        vegSwitch.isOn = true
        nonVegSwitch.isOn = true
        
        nonVegSwitch.onTintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        nextBtnView.backgroundColor = .white
        nextBtnView.layer.cornerRadius = 10
        
        nextBtnLbl.font = UIFont.systemFont(ofSize: 12)
        nextBtnLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        viewCartLbl.text = "View Cart"
        viewCartLbl.font = UIFont.systemFont(ofSize: 12)
        viewCartLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        nextBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        nextBtn.tintColor = .white
        
        dishTotalLbl.text = "In Cart"
        dishTotalLbl.textColor = .white
        dishTotalLbl.font = UIFont.systemFont(ofSize: 12)
        
        vegLbl.isHidden = true
        self.vegLbl.visiblity(gone: true, dimension: 0.0, attribute: .height)
        vegSwitch.isHidden = true
        self.vegSwitch.visiblity(gone: true, dimension: 0.0, attribute: .height)

        nonVegLbl.isHidden = true
        self.nonVegLbl.visiblity(gone: true, dimension: 0.0, attribute: .height)
        nonVegSwitch.isHidden = true
        self.nonVegSwitch.visiblity(gone: true, dimension: 0.0, attribute: .height)
    }
    
    @objc func nextViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.backButton = "backButton"
        vc.backBtnScreenType = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //UIView Tap Navigate To Filter ViewController
    @objc func filterViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // This method is called when the second view controller is done and sends back data
    func FilterViewControllerDidFinish(with data: (tagCategoryIDs: [TagCategoryID], tagIDs: [TagID])) {
        tag_id = data.tagIDs
        print("Tag Id  \(tag_id)")
        tag_Category_id = data.tagCategoryIDs
        
        if tag_id.count == 0 {
            print("check filter count else \(tag_id.count)")
            filterCountLbl.isHidden = true
        } else {
            filterCountLbl.isHidden = false
            filterCountLbl.text = "\(tag_id.count)"
            print("check filter count \(tag_id.count)")
            filterCountLbl.textColor = UIColor.white
            filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            filterCountLbl.layer.cornerRadius = 8
            filterCountLbl.layer.masksToBounds = true
        }
        
        isLoading = false
        CusineDetailApi()
    }
    
    @objc func sortViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    deinit {
        // Unregister from the notification when the view controller is deallocated
        NotificationCenter.default.removeObserver(self, name: .addOnDishPriceAdded, object: nil)
        NotificationCenter.default.removeObserver(self, name: .addOnDishPriceremoved, object: nil)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeAction(_ sender: UITextField) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartDiscartPopUpViewController") as! CartDiscartPopUpViewController
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func sortBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    
    @IBAction func vegBtnAction(_ sender: UISwitch) {
        
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
        
        CusineDetailApi()
    }
    
    @IBAction func nonVegBtnAction(_ sender: UISwitch) {
        
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
        
        CusineDetailApi()
    }
    
    @objc func handleOkButtonPressed() {
        // Handle the notification here
        print("Ok button was pressed")
        removeCartApi()
    }
    
    //CusineDetail Call
    func CusineDetailApi() {
        
        if isLoading {
            self.showLoader()
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
            "sort" : sortName,
            "dish_type" : vegNonVegType
        ] as [String : Any]
        
        print("Cusineflavour params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FlavourCusineResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        if response.success {
                            if response.parameters != nil {
                                self.flavourCusineDatas = (response.parameters?.dish!)!
                                self.total_pages = response.parameters?.page.totalPages ?? 0
                                
                                print("Totallllllll page \(self.total_pages)")
                                print("Totallllllll pahge api \(response.parameters?.page.totalPages)")
                                      
                            }
                        } else {
                            self.flavourCusineDatas = []
                            self.flavouCusineTableView.reloadData()
                            
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                            vc.screenType = "Cusine"
                            vc.context = self
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.flavouCusineTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Cusineflavour error res \(error)")
                }
            }
        }
    }
    
    func CusineDetailScrollingApi() {
        
        if isLoading {
            self.showLoader()
            isLoading = false
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
            "sort" : sortName,
            "dish_type" : vegNonVegType,
            "page" : current_page
        ] as [String : Any]
        
        print("Cusineflavour params \(parameters)")
        
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
                            self.flavourCusineDatas.append(contentsOf: dishList)
                            
                            self.hideLoader()
                        }
                        
                        DispatchQueue.main.async {
                            
                            if response.parameters == nil {
                                self.flavourCusineDatas = []
                                self.flavouCusineTableView.reloadData()
                                
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                                vc.context = self
                                vc.modalPresentationStyle = .overCurrentContext
                                self.present(vc, animated: false, completion: nil)
                            } else{
                                self.flavouCusineTableView.reloadData()
                            }
                        }
                    } else {
                            self.hideLoader()
                            self.isLoading = false
                    }
                    
                    DispatchQueue.main.async {
                        self.flavouCusineTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Cusineflavour error res \(error)")
                }
            }
        }
    }

    
    //FavoriteAdd Api Call
    func FavoriteAddApi() {
        //        self.showLoader()
        
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
                    print("error res \(error)")
                }
            }
        }
    }
    
    //FavoriteRemove Api Call
    func FavoriteRemoveApi() {
        
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
                                self.filterCountLbl.isHidden = true
                            } else {
                                self.filterCountLbl.text = "\(self.tag_id.count)"
                                self.filterCountLbl.textColor = UIColor.white
                                self.filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                                self.filterCountLbl.layer.cornerRadius = 8
                                self.filterCountLbl.layer.masksToBounds = true
                            }
                        }
                        
                        self.CusineDetailApi()
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

                        
                        self.CusineDetailApi()
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
                        self.addItemView.isHidden = true
                        self.addItemView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                        self.hideLoader()
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
                                print("flavour total item \(response.parameters.totalItems)")
                                self.addItemView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                            } else {
                                self.addItemView.visiblity(gone: false, dimension: 50, attribute: .height)
                            }
                            
                            if response.parameters.cart!.count > 0 {
                                self.nextBtnLbl.text = HomeConstant.rupeesSym + response.parameters.cart![0].amountPayable!
                            }
                            
                            self.additemLbl.text = String(response.parameters.totalItems) + " Item"
                        }
                    }
                } catch {
                    print("cart Showing error res localize \(error)")
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

//FlavourCusine TableViewCell
extension FlavourCusineViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flavourCusineDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = flavouCusineTableView.dequeueReusableCell(withIdentifier: "CusineWithDishTableViewCell", for: indexPath) as! CusineWithDishTableViewCell
        
        cell.selectionStyle = .none
        cell.context = self
        cell.flavourCusineDatasList = flavourCusineDatas
        
        
        cell.cakeName.text = flavourCusineDatas[indexPath.row].dishName
        cell.cakeSubtitle.text = HomeConstant.IN + flavourCusineDatas[indexPath.row].category.categoryName
                
        if flavourCusineDatas[indexPath.row].dishRating == "" {
            cell.ratingView.rating = Double(4)
        } else {
            cell.ratingView.rating = Double(flavourCusineDatas[indexPath.row].dishRating)!
        }
        
        if let urlString = flavourCusineDatas[indexPath.row].withBackground.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image") // Optional placeholder image
            cell.cakeImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
        
        cell.indexPath = indexPath
        cell.delegate = self
        
        let price = flavourCusineDatas[indexPath.row].dishPrice
        let priceString = HomeConstant.rupeesSym + price!
        let attributedString = NSAttributedString(string: priceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        cell.realPriceLbl.attributedText = attributedString
        
        cell.discountPriceLbl.text = HomeConstant.rupeesSym + flavourCusineDatas[indexPath.row].dishDiscounts!
        cell.discountPercentageLbl.text = flavourCusineDatas[indexPath.row].discountPercentage + HomeConstant.percentageSym
        cell.landPriceLbl.text = HomeConstant.rupeesSym +  flavourCusineDatas[indexPath.row].landingPrice
        cell.cakeTypeLbl.text = flavourCusineDatas[indexPath.row].availability
        
        if flavourCusineDatas[indexPath.row].dishAvailability != "Available" {
            cell.addBtnView.cornerRadius = 10
            cell.addBtnView.layer.borderWidth = 2
            cell.addBtnView.layer.borderColor = UIColor.gray.cgColor
            
            cell.addtextLbl.text = "ADD"
            cell.addtextLbl.font = UIFont.boldSystemFont(ofSize: 16)
            cell.addtextLbl.textColor = UIColor.gray
            
            cell.addBtnView.backgroundColor = UIColor(named: "AddViewBgColor")
            
            cell.plusLbl.textColor = UIColor.gray
        }
        
        cell.favBtnView.isUserInteractionEnabled = true
        cell.favBtnView.tag = indexPath.row // Assuming you want to use the row as the tag
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favViewTapped(_:)))
        cell.favBtnView.addGestureRecognizer(tapGesture)
        
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(favBtnAction(_:)), for: .touchUpInside)
        
        cell.infoBtn.tag = indexPath.row
        cell.infoBtn.addTarget(self, action: #selector(infoButtonAction(_:)), for: .touchUpInside)
        
        cell.addBtnView.visiblity(gone: false, dimension: 100, attribute: .width)
        cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
        
        print("counttttt \(flavourCusineDatas[indexPath.row].dishsizes.count)")
        print("counttttt add-on \(flavourCusineDatas[indexPath.row].addonDetailsCat.count)")
        
        if ((flavourCusineDatas[indexPath.row].dishsizes.count) == 1) && (flavourCusineDatas[indexPath.row].addonDetailsCat.count) == 0 {
            if flavourCusineDatas[indexPath.row].cartHasDishDetails.count > 0 {
                let addonCountValue = Int(flavourCusineDatas[indexPath.row].cartHasDishDetails[0].quantity)
                if addonCountValue! > 0 {
                    cell.PlusMinusView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.addBtnView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                    cell.countLbl.text = flavourCusineDatas[indexPath.row].cartHasDishDetails[0].quantity
                }
            }
        } else {
            cell.addBtnView.visiblity(gone: false, dimension: 100, attribute: .width)
            cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
        }
        
        if flavourCusineDatas[indexPath.row].tag == "Premium" {
            cell.premiumBtn.setTitle(flavourCusineDatas[indexPath.row].tag, for: .normal)
            cell.premiumBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PREMIUMCOLOR)
            cell.premiumBtn.tintColor = UIColor.white
        } else if flavourCusineDatas[indexPath.row].tag == "Elite"{
            cell.premiumBtn.setTitle(flavourCusineDatas[indexPath.row].tag, for: .normal)
            cell.premiumBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            cell.premiumBtn.tintColor = UIColor.white
        } else {
            cell.premiumBtn.setTitle(flavourCusineDatas[indexPath.row].tag, for: .normal)
            cell.premiumBtn.backgroundColor = UIColor(hexFromString: ColorConstant.BASICCOLOR)
            cell.premiumBtn.tintColor = UIColor.white
        }
        
        //Veg NonVeg Image Handled
        if flavourCusineDatas[indexPath.row].dishType == "veg" {
            cell.vegorNongImg.image = UIImage(named: "vegImage")
        } else {
            cell.vegorNongImg.image = UIImage(named: "nonVegImage")
        }
        
        //set cake availability image
        if flavourCusineDatas[indexPath.row].availability == "Instantly Baked" {
            cell.availabilityImg.image = UIImage(named: "instantly")
            cell.cakeTypeLbl.textColor = UIColor(hexFromString: ColorConstant.INSTANTLY)
        }
        else if flavourCusineDatas[indexPath.row].availability.contains("Freshly") {
            cell.availabilityImg.image = UIImage(named: "freshlybaked")
            cell.cakeTypeLbl.textColor = UIColor(hexFromString: ColorConstant.FREASHLY)
        }
        else {
            cell.availabilityImg.image = UIImage(named: "speciallybaked")
            cell.cakeTypeLbl.textColor = UIColor(hexFromString: ColorConstant.SPECIALLY)
        }
        
        //Add or remove favorite
        if flavourCusineDatas[indexPath.row].foodFavorite == true {
            let originalImage = UIImage(named: "heart_fill")
            let tintedImage = originalImage?.withTintColor(.red)
            cell.favBtn.setImage(tintedImage, for: .normal)
        } else {
            let originalImage = UIImage(named: "heart")
            let tintedImage = originalImage?.withTintColor(.red)
            cell.favBtn.setImage(tintedImage, for: .normal)
        }
        
        let custom = flavourCusineDatas[indexPath.row].customerApplicableClass
        
        if custom != nil || custom != "" {
            cell.customizeLbl.text = "Customizable"
        } else {
            cell.customizeLbl.isHidden = true
        }
        
        cell.plusBtn.tag = indexPath.row
        cell.plusBtn.addTarget(self, action: #selector(plusBtnAction(_:)), for: .touchUpInside)
        
        cell.minusBtn.tag = indexPath.row
        cell.minusBtn.addTarget(self, action: #selector(minusBtnAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func didTapCakeImage(at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = flavourCusineDatas[indexPath.row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func filledHeart(sender: UIButton, isFavorite: Bool) {
        let imageName = isFavorite ? "heart_fill" : "heart"
        let originalImage = UIImage(named: imageName)
        let tintedImage = originalImage?.withTintColor(.red)
        sender.setImage(tintedImage, for: .normal)
    }
    
    @objc func favBtnAction(_ sender: UIButton) {
        let row = sender.tag
        dish_id = flavourCusineDatas[row].dishID
        dish_name = flavourCusineDatas[row].dishName
        
        if flavourCusineDatas[row].foodFavorite! {
            flavourCusineDatas[row].foodFavorite! = false
            filledHeart(sender: sender, isFavorite: false)
            FavoriteRemoveApi()
            showToast(message: dish_name + "is Remove to My Wishlist")
        } else {
            flavourCusineDatas[row].foodFavorite! = true
            filledHeart(sender: sender, isFavorite: true)
            FavoriteAddApi()
            showToast(message: dish_name + "is Add to My Wishlist")
        }
    }
    
    @objc func favViewTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view as? UIView else {
            return
        }

        let row = tappedView.tag // Assuming you've set the tag for the view
        dish_id = flavourCusineDatas[row].dishID
        dish_name = flavourCusineDatas[row].dishName
        
        if flavourCusineDatas[row].foodFavorite! {
            flavourCusineDatas[row].foodFavorite! = false
            filledHeart(sender: tappedView as! UIButton, isFavorite: false) // Pass the tapped view to identify the tapped dish
            FavoriteRemoveApi()
            showToast(message: dish_name + " is Removed from My Wishlist")
        } else {
            flavourCusineDatas[row].foodFavorite! = true
            filledHeart(sender: tappedView as! UIButton, isFavorite: true) // Pass the tapped view to identify the tapped dish
            FavoriteAddApi()
            showToast(message: dish_name + " is Added to My Wishlist")
        }
    }
    
    @objc func infoButtonAction(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = flavourCusineDatas[row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapAddButton(at indexPath: IndexPath) {
        
        if flavourCusineDatas[indexPath.row].dishAvailability == "Available" {
            
            
            if ((flavourCusineDatas[indexPath.row].dishsizes.count) > 1) || (flavourCusineDatas[indexPath.row].addonDetailsCat.count) >= 1 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
                vc.dish_id = flavourCusineDatas[indexPath.row].dishID
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                if let cell = flavouCusineTableView.cellForRow(at: indexPath) as? CusineWithDishTableViewCell {
                    cell.PlusMinusView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.addBtnView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                    
                    cell.countLbl.text = "1"
                }
                
                self.dish_id = flavourCusineDatas[indexPath.row].dishID
                self.quantity = "\(1)"
                self.selectedSizeID = flavourCusineDatas[indexPath.row].dishsizes[0].sizeDetailsSize.sizeID
                
                AddToCartApi()
            }
        } else {
            print("Add view tapped dish un available")
            showAlert(message: "this dish Currently Unavailbale")
        }
    }
    
    @objc func plusBtnAction(_ sender: UIButton) {
        let row = sender.tag
        if let cell = flavouCusineTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CusineWithDishTableViewCell {
        
            if let count = Int(cell.countLbl.text ?? "1") {
                let newCount = count + 1
                cell.countLbl.text = "\(newCount)"
                
                self.dish_id = flavourCusineDatas[row].dishID
                self.quantity = "\(newCount)"
                self.selectedSizeID = flavourCusineDatas[row].dishsizes[0].sizeDetailsSize.sizeID
                                
                AddToCartApi()
            } else {
                print("plus btn tappeddddddd else")
            }
        }
    }
    
    @objc func minusBtnAction(_ sender: UIButton) {
        let row = sender.tag
        if let cell = flavouCusineTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CusineWithDishTableViewCell {
            
            var newCount = 0
            if let count = Int(cell.countLbl.text ?? "1") {
                newCount = max(0, count - 1)
                cell.countLbl.text = "\(newCount)"
                
                self.dish_id = flavourCusineDatas[row].dishID
                self.quantity = "\(newCount)"
                self.selectedSizeID = flavourCusineDatas[row].dishsizes[0].sizeDetailsSize.sizeID
                
                if newCount == 0 {
                    cell.addBtnView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                }
                
                AddToCartApi()

            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = flavourCusineDatas[indexPath.row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            print("Scolling End")
            if total_pages > current_page {
                print("Scolling End current_page \(current_page)")
                current_page += 1
                isLoading = true
                CusineDetailScrollingApi()
            }
        }
    }
}

