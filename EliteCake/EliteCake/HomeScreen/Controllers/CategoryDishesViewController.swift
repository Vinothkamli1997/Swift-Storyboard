//
//  CategoryDishesViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/02/23.
//

import UIKit

class CategoryDishesViewController: UIViewController, FilterViewControllerDelegate, FilterPopUpDelegate, PopUpDelegate, ClearButtonDelegate {
    
    func clearButtonTapped() {
        print("chekck ok button tapped")
    }
    
    
    func closeBtnTapped(_ alert: FilterPopupViewController, alertTag: Int) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func closeBtnTapped(_ alert: PopUpViewController, alertTag: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func recommendBtnTapped(_ alert: PopUpViewController, sortName: String) {
        self.sortName = sortName
        
        self.isLoading = true
        
        ViewbyCategoryApi()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var categoryDishCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var dishCountLbl: UILabel!
    @IBOutlet weak var cartPriceLbl: UILabel!
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var viewCartLbl: UILabel!
    
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var filterCountLbl: UILabel!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var sortLbl: UILabel!
    
    var category_id: String = ""
    var dish_id: String = ""
    var dish_name: String = ""
    var customerID: String = ""
    var oID: String = ""
    var outlet_id: String = ""
    var sortName: String = ""
    var isLoading: Bool = true
    var quantity: String = ""
    var selectedSizeID: String = ""
    var total_pages: Int = 1
    var current_page: Int = 1
    var cartID: String = ""
    
    var foodFavotiteCheck: Bool = false
    
    var categoryList: [CategoryDish] = []
    var tag_id: [TagID] = []
    var tag_Category_id: [TagCategoryID] = []
    
    var tagIDStrings: [TagID] = []
    var categoryIDString: [TagCategoryID] = []
    
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
        
        let nextViewTap = UITapGestureRecognizer(target: self, action: #selector(nextViewTapped))
        nextView.addGestureRecognizer(nextViewTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleOkButtonPressed), name: Notification.Name("OkButtonPressed"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterFetchApi()
        cartShowingApi()
    }
    
    func setUp() {
        categoryDishCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        categoryDishCollectionView.dataSource = self
        categoryDishCollectionView.delegate = self
        categoryDishCollectionView.showsVerticalScrollIndicator = false
                
        titleLbl.text = "Category Dishes"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.textColor = .black
        
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = UIColor.black
        
        filterLbl.text = "Filter"
        filterBtn.setImage(UIImage(named: "Sort"), for: .normal)
        filterBtn.tintColor = UIColor.black
        
        filterLbl.textColor = .black
        sortLbl.textColor = .black
        
        sortLbl.text = "Sort"
        sortBtn.setImage(UIImage(named: "Sort"), for: .normal)
        sortBtn.tintColor = UIColor.black
        
        nextView.backgroundColor = .white
        nextView.layer.cornerRadius = 10
        
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
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    @objc func sortViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
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
            print("check filter count \(tag_id.count)")
            filterCountLbl.textColor = UIColor.white
            filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            filterCountLbl.layer.cornerRadius = 8
            filterCountLbl.layer.masksToBounds = true
        }
        
        isLoading = false
        
        ViewbyCategoryApi()
    }
    
    //CusineDetail Call
    func ViewbyCategoryApi() {
        
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
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + category_id)
        let url = URL(string: ApiConstant.CATEGORYWITHDISH)
        
        let parameters = [
            "category_id": category_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_details_id": customerID,
            "id":oID,
            "tag_category_id" : tag_Category_id.map { $0.tagCategoryID },
            "tag_id" : tag_id.map { $0.tagID },
            "sort" : sortName,
        ] as [String : Any]
        
        print("viewbycategory params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        showAlert(message: "Api res \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ViewbyCategoryResponse.self, from: data)
                    
                    if response.success {
                        self.sortName = ""
                        DispatchQueue.main.async {
                            if response.parameters != nil {
                                self.categoryList = response.parameters!.dish
                                
                                self.total_pages = (response.parameters?.page.totalPages)!

                            } else {
                                self.categoryList = []
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                                
                                vc.delegate = self
                                vc.context = self
                                vc.modalPresentationStyle = .overCurrentContext
                                self.present(vc, animated: false, completion: nil)
                            }
                            self.categoryDishCollectionView.reloadData()
                        }
                        self.hideLoader()
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.categoryList = []
                            self.categoryDishCollectionView.reloadData()

                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                            
                            vc.delegate = self
                            vc.context = self
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                        }
                        
                    }
                    
                } catch {
                    self.hideLoader()
                    print("viewby error res \(error)")
                }
            }
        }
    }
    
    func ViewbyCategoryScrollApi() {
        
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
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + category_id)
        let url = URL(string: ApiConstant.CATEGORYWITHDISH)
        
        let parameters = [
            "category_id": category_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_details_id": customerID,
            "id":oID,
            "tag_category_id" : tag_Category_id.map { $0.tagCategoryID },
            "tag_id" : tag_id.map { $0.tagID },
            "sort" : sortName,
            "page" : current_page
        ] as [String : Any]
        
        print("viewbycategory params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ViewbyCategoryResponse.self, from: data)
                    
                    if response.success {
                        self.sortName = ""
                        DispatchQueue.main.async {
                            if response.parameters != nil {
                                if let dishList = response.parameters?.dish {
                                    print("Category List Append222222 \(self.categoryList)")
                                    self.categoryList.append(contentsOf: dishList)
                                    print("Category List Append \(dishList)")
                                }
                                print("Category List Append111 \(self.categoryList)")

                            } else {
                                self.categoryList = []
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                                
                                vc.delegate = self
                                vc.context = self
                                vc.modalPresentationStyle = .overCurrentContext
                                self.present(vc, animated: false, completion: nil)
                            }
                            
                            self.categoryDishCollectionView.reloadData()
                        }
                        self.hideLoader()
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.categoryList = []
                            self.categoryDishCollectionView.reloadData()

                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "FilterPopupViewController") as! FilterPopupViewController
                            
                            vc.delegate = self
                            vc.context = self
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                        }
                        
                    }
                    
                } catch {
                    self.hideLoader()
                    print("viewby error res \(error)")
                }
            }
        }
    }

    
    //FavoriteAdd Api Call
    func FavoriteAddApi() {
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
        
        print("category Fav params\(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddFavouriteResponse.self, from: data)
                    print("Category res \(response)")
                    
                    DispatchQueue.main.async {
                        self.categoryDishCollectionView.reloadData()
                    }
                } catch {
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
        
        print("category FavouriteRem params \(parameters)")
        
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
                        self.categoryDishCollectionView.reloadData()
                    }
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
                    
                    print("fetch filter res \(response)")
                    
                    if response.success {
                        if response.parameters != nil {
                            tag_id = response.parameters!.tagID
                            
                            tag_Category_id = response.parameters!.tagCategoryID
                        }
                        
                        DispatchQueue.main.async {
                            if self.tag_id.count == 0 {
                                print("check catehroy count tag \(self.tag_id.count)")
                                self.filterCountLbl.isHidden = true
                            } else {
                                self.filterCountLbl.text = "\(self.tag_id.count)"
                                print("check catehroy count cat \(self.tag_id.count)")
                                self.filterCountLbl.textColor = UIColor.white
                                self.filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                                self.filterCountLbl.layer.cornerRadius = 8
                                self.filterCountLbl.layer.masksToBounds = true
                            }
                        }
                        
                        self.isLoading = true
                        self.ViewbyCategoryApi()
                        
                    } else {
                        
                        print("check catehroy else")
                        tag_id = []
                        tag_Category_id = []
                        
                        DispatchQueue.main.async {
                            if self.tag_id.count == 0 {
                                print("check catehroy count tag \(self.tag_id.count)")
                                self.filterCountLbl.isHidden = true
                            } else {
                                self.filterCountLbl.text = "\(self.tag_id.count)"
                                print("check catehroy count cat \(self.tag_id.count)")
                                self.filterCountLbl.textColor = UIColor.white
                                self.filterCountLbl.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                                self.filterCountLbl.layer.cornerRadius = 8
                                self.filterCountLbl.layer.masksToBounds = true
                            }
                        }
                        
                        self.isLoading = true
                        self.ViewbyCategoryApi()
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
                        self.addView.isHidden = true
                        self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
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
                            self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                        } else {
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

extension CategoryDishesViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.cakeName.text = categoryList[indexPath.row].dishName
        cell.flavourName.text = HomeConstant.IN + categoryList[indexPath.row].category.categoryName
        
//        if let urlString = categoryList[indexPath.row].dishImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
//            let placeholderImage = UIImage(named: "no_image") // Optional placeholder image
//            cell.cakeImage.sd_setImage(with: url, placeholderImage: placeholderImage)
//        }
        
        if let encodedImageUrlString = categoryList[indexPath.row].dishImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let imageUrl = URL(string: encodedImageUrlString) {
            cell.cakeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
        } else {
            cell.cakeImage.image = UIImage(named: "no_image")
        }
        
//        cell.ratingView.rating = Double(categoryList[indexPath.row].dishRating)!
        
        if categoryList[indexPath.row].dishRating == "" {
            cell.ratingView.rating = Double(4)
        } else {
            cell.ratingView.rating = Double(categoryList[indexPath.row].dishRating)!
        }
        
        if categoryList[indexPath.row].dishDiscounts != nil {
            cell.discountPriceLabel.text = HomeConstant.rupeesSym + categoryList[indexPath.row].dishDiscounts!
        }
        
        if categoryList[indexPath.row].dishPrice != nil {
            let priceString = HomeConstant.rupeesSym + categoryList[indexPath.row].dishPrice!
            let attributedString = NSAttributedString(string: priceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.realPriceLbl.attributedText = attributedString
        }
        
        cell.discountLbl.text = categoryList[indexPath.row].discountPercentage + HomeConstant.percentageSym
        cell.speaciallyLbl.text = categoryList[indexPath.row].availability
        cell.bestPriceValueLbl.text = HomeConstant.rupeesSym + categoryList[indexPath.row].landingPrice
        
        cell.addView.visiblity(gone: false, dimension: 100, attribute: .width)
        cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
        
        if ((categoryList[indexPath.row].dishsizes.count) == 1) && (categoryList[indexPath.row].addonDetailsCat.count) == 0 {
            print("no add add-on there")
            if categoryList[indexPath.row].cartHasDishDetails.count > 0 {
                let addonCountValue = Int(categoryList[indexPath.row].cartHasDishDetails[0].quantity)
                if addonCountValue! > 0 {
                    cell.PlusMinusView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.addViw.visiblity(gone: true, dimension: 0.0, attribute: .width)
                    cell.countLbl.text = categoryList[indexPath.row].cartHasDishDetails[0].quantity
                }
            }
        } else {
            print("add add-on there")
            cell.addViw.visiblity(gone: false, dimension: 100, attribute: .width)
            cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
        }
        
        //Veg Nonveg Image set
        if  categoryList[indexPath.row].dishType == "veg" {
            cell.vegNonvenImg.image = UIImage(named: "vegImage")
        } else {
            cell.vegNonvenImg.image = UIImage(named: "nonVegImage")
        }
        
        if categoryList[indexPath.row].tag == "Premium" {
            cell.eliteLblBtn.setTitle(categoryList[indexPath.row].tag, for: .normal)
            cell.eliteLblBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PREMIUMCOLOR)
            cell.eliteLblBtn.tintColor = UIColor.white
        } else if categoryList[indexPath.row].tag == "Elite"{
            cell.eliteLblBtn.setTitle(categoryList[indexPath.row].tag, for: .normal)
            cell.eliteLblBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            cell.eliteLblBtn.tintColor = UIColor.white
        } else {
            cell.eliteLblBtn.setTitle(categoryList[indexPath.row].tag, for: .normal)
            cell.eliteLblBtn.backgroundColor = UIColor(hexFromString: ColorConstant.BASICCOLOR)
            cell.eliteLblBtn.tintColor = UIColor.white
        }
        
        //specially Image Set
        if categoryList[indexPath.row].availability == "Instantly Baked" {
            cell.speaciallyImg.image = UIImage(named: "instantly")
            cell.speaciallyLbl.textColor = UIColor(hexFromString: ColorConstant.INSTANTLY)
        }
        else if categoryList[indexPath.row].availability.contains("Freshly") {
            cell.speaciallyImg.image = UIImage(named: "freshlybaked")
            cell.speaciallyLbl.textColor = UIColor(hexFromString: ColorConstant.FREASHLY)
        }
        else {
            cell.speaciallyImg.image = UIImage(named: "speciallybaked")
            cell.speaciallyLbl.textColor = UIColor(hexFromString: ColorConstant.SPECIALLY)
        }
        
        //Add or remove favorite
        if categoryList[indexPath.row].foodFavorite == true {
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
        
        if categoryList[indexPath.row].dishAvailability != "Available" {
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
        
        cell.infoBtn.tag = indexPath.row
        cell.infoBtn.addTarget(self, action: #selector(infoBtnAction(_:)), for: .touchUpInside)
        
        cell.addView.tag = indexPath.row
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didAddTapView))
        cell.addView.addGestureRecognizer(tapGesture)
        
        cell.context = self
        
        cell.plusBtn.tag = indexPath.row
        cell.plusBtn.addTarget(self, action: #selector(plusBtnAction(_:)), for: .touchUpInside)
        
        cell.minusBtn.tag = indexPath.row
        cell.minusBtn.addTarget(self, action: #selector(minusBtnAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func filledHeart(sender: UIButton, isFavorite: Bool) {
        let imageName = isFavorite ? "heart_fill" : "heart"
        let originalImage = UIImage(named: imageName)
        let tintedImage = originalImage?.withTintColor(.red)
        sender.setImage(tintedImage, for: .normal)
    }
    
    @objc func favBtnAction(_ sender: UIButton) {
        let row = sender.tag
        dish_id = categoryList[row].dishID
        dish_name = categoryList[row].dishName
        
        foodFavotiteCheck = ((categoryList[row].foodFavorite) != false)
        
        if foodFavotiteCheck {
            categoryList[row].foodFavorite = false
            filledHeart(sender: sender, isFavorite: false)
            FavoriteRemoveApi()
            showToast(message: dish_name + "is Remove to My Wishlist")
        } else {
            categoryList[row].foodFavorite = true
            filledHeart(sender: sender, isFavorite: true)
            FavoriteAddApi()
            showToast(message: dish_name + "is Add to My Wishlist")
        }
    }
    
    @objc func infoBtnAction(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = categoryList[row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didAddTapView(_ sender: UITapGestureRecognizer) {
        let row = sender.view?.tag ?? 0
        
        if categoryList[row].dishAvailability == "Available" {
            if ((categoryList[row].dishsizes.count) >= 1) || (categoryList[row].addonDetailsCat.count) >= 1 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
                vc.dish_id = categoryList[row].dishID
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                if let cell = categoryDishCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? CategoryCollectionViewCell {
                    cell.PlusMinusView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.addView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                    
                    cell.countLbl.text = "1"
                }
                
                self.dish_id = categoryList[row].dishID
                self.quantity = "\(1)"
                self.selectedSizeID = categoryList[row].dishsizes[0].sizeDetailsSize.sizeID
                
                AddToCartApi()
            }
        } else {
            print("Add view tapped dish un available")
            showAlert(message: "this dish Currently Unavailbale")
        }
    }
    
    @objc func plusBtnAction(_ sender: UIButton) {
        let row = sender.tag
        if let cell = categoryDishCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? CategoryCollectionViewCell {

        print("plus btn tappeddddddd")
        
            if let count = Int(cell.countLbl.text ?? "1") {
                let newCount = count + 1
                cell.countLbl.text = "\(newCount)"
                
                self.dish_id = categoryList[row].dishID
                self.quantity = "\(newCount)"
                self.selectedSizeID = categoryList[row].dishsizes[0].sizeDetailsSize.sizeID
                                
                AddToCartApi()
            } else {
                print("plus btn tappeddddddd else")
            }
        }
    }
    
    @objc func minusBtnAction(_ sender: UIButton) {
        let row = sender.tag
        if let cell = categoryDishCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? CategoryCollectionViewCell {

        print("plus btn tappeddddddd")
            
            var newCount = 0
            if let count = Int(cell.countLbl.text ?? "1") {
                newCount = max(0, count - 1)
                cell.countLbl.text = "\(newCount)"
                
                self.dish_id = categoryList[row].dishID
                self.quantity = "\(newCount)"
                self.selectedSizeID = categoryList[row].dishsizes[0].sizeDetailsSize.sizeID
                
                if newCount == 0 {
                    cell.addView.visiblity(gone: false, dimension: 100, attribute: .width)
                    cell.PlusMinusView.visiblity(gone: true, dimension: 0.0, attribute: .width)
                }
                
                AddToCartApi()

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = categoryList[indexPath.row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width-10)/2
        return CGSize(width: size, height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItemIndex = collectionView.numberOfItems(inSection: 0) - 1
        
        print("last index Code working")
        print("last index Code working \(lastItemIndex)")
        print("last index Code working \(indexPath.item)")
        if indexPath.item == lastItemIndex {
            print("last index Code working current page \(current_page)")
            print("last index Code working current page \(total_pages)")
            if total_pages > current_page {
                current_page += 1
                isLoading = true
                ViewbyCategoryScrollApi()
            }
        }
    }
}
