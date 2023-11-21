//
//  CakeDetailScreen.swift
//  EliteCake
//
//  Created by Apple - 1 on 30/01/23.
//

import UIKit
import Cosmos

class CakeDetailScreen: UIViewController {
        
    @IBOutlet weak var cakeDetailTableView: UITableView! {
        didSet {
            //Register TableView Cells
            cakeDetailTableView.register(HeaderCakeTableViewCell.nib, forCellReuseIdentifier: HeaderCakeTableViewCell.identifier)
            cakeDetailTableView.register(CakePriceTableViewCell.nib, forCellReuseIdentifier: CakePriceTableViewCell.identifier)
            cakeDetailTableView.register(OffersTableViewCell.nib
                                         , forCellReuseIdentifier: OffersTableViewCell.identifier)
            cakeDetailTableView.register(CakeDescriptionCell.nib, forCellReuseIdentifier: CakeDescriptionCell.identifier)
            cakeDetailTableView.register(SuggestedTableViewCell.nib
                                         , forCellReuseIdentifier: SuggestedTableViewCell.identifier)
            cakeDetailTableView.separatorStyle = .none
            cakeDetailTableView.dataSource = self
            cakeDetailTableView.delegate = self
            cakeDetailTableView.backgroundColor = .clear
            cakeDetailTableView.showsVerticalScrollIndicator = false
            cakeDetailTableView.showsHorizontalScrollIndicator = false
            cakeDetailTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var discountVoucherView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var bottomViewHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var dishCountLbl: UILabel!
    @IBOutlet weak var cartPriceLbl: UILabel!
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextLbl: UILabel!
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var viewCartLbl: UILabel!
    
    var imagerHeaderCell: HeaderCakeTableViewCell?
    var cakeDetailsResponse: CakeDetailParameters? = nil
    var suggestedList: [Dish] = []
    var voucherResponse: [CakeVoucher] = []
    
    var foodFavotiteCheck: Bool = false
    
    var bgImageArray = [] as [String]
    var index = 0
    
    var customerID: String = ""
    var oID: String = ""
    var dish_id: String = ""
    var outlet_id: String = ""
    var dish_name: String = ""
    var cartID: String = ""

    var isBottomSheetShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()

        cakeDetailApi()
        vouchersApi()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextViewTapped))
        nextView.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleOkButtonPressed), name: Notification.Name("OkButtonPressed"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartShowingApi()
    }
    
    @objc func nextViewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.backButton = "backButton"
        vc.backBtnScreenType = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUp() {
        self.discountVoucherView.backgroundColor = UIColor(named: "PureWhite")
        self.bottomViewHeightContraint.constant = 0
        self.view.layoutIfNeeded()
        
        self.discountVoucherView.layer.cornerRadius = 20
        self.discountVoucherView.clipsToBounds = true
        
        dishCountLbl.textColor = UIColor.white
        dishCountLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        cartPriceLbl.textColor = UIColor.white
        cartPriceLbl.font = UIFont.boldSystemFont(ofSize: 12)
                
        nextView.backgroundColor = .white
        nextView.layer.cornerRadius = 10
        
        nextLbl.font = UIFont.systemFont(ofSize: 12)
        nextLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        viewCartLbl.text = "View Cart"
        viewCartLbl.font = UIFont.systemFont(ofSize: 12)
        viewCartLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        NextBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        NextBtn.tintColor = .white
        
        cartPriceLbl.text = "In Cart"
        cartPriceLbl.textColor = .white
        cartPriceLbl.font = UIFont.systemFont(ofSize: 12)
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        // hide the bottom sheet
        UIView.animate(withDuration: 0.1, animations: {
            
            self.bottomViewHeightContraint.constant = 180
            self.view.layoutIfNeeded()
        }) { (status) in
            self.isBottomSheetShow = false
            
            UIView.animate(withDuration: 0.1, animations: {
                self.bottomViewHeightContraint.constant = 0
                self.view.layoutIfNeeded()
            }) { (status) in
                // not to be used
            }
            // completion code
        }
    }
    
    @IBAction func dishCloseAction(_ sender: UITextField) {
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
    
    //Cake Detail API
    func cakeDetailApi() {
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
        let url = URL(string: ApiConstant.CAKEDETAILSCREEN)
        
        let parameters = [
            "dish_id": dish_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID
        ] as [String : Any]
        
        print("cakedetail params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    print("Dish Details Data \(data)")

                    let response = try decoder.decode(CakeDetailsResponse.self, from: data)
                    
                    print("Dish Details Data \(data)")
                    
                    print("cakedetail response \(response)")

                    self.cakeDetailsResponse = response.parameters
                    self.suggestedList = response.parameters.dish.suggested!
                    self.addImage()
                    
                    DispatchQueue.main.async {
                        self.cakeDetailTableView.reloadData()
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("cakedetail error res localize \(error)")
                }
            }
        }
    }
    
    //OfferVoucher Api
    func vouchersApi() {
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
        let url = URL(string: ApiConstant.DISCARTVOUCHER)
        
        let parameters = [
            "dish_id": dish_id,
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID
        ] as [String : Any]
        
        print("voucher params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(OffersVoucheresponse.self, from: data)
                    
                    print("Voucher response \(response)")
                    
                    self.voucherResponse = response.parameters.voucher
                    
                    DispatchQueue.main.async {
                        self.cakeDetailTableView.reloadData()
                    }
                } catch {
                    print("voucher error res localize \(error)")
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
                    
                    
//                    DispatchQueue.main.async {
//                        self.flavouCusineTableView.reloadData()
//                    }
//                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("error res \(error)")
                }
            }
        }
    }
    
    //FavoriteRemove Api Call
    func FavoriteRemoveApi() {
//        self.showLoader()
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
//
//                    DispatchQueue.main.async {
//                        self.flavouCusineTableView.reloadData()
//                    }
//                    self.hideLoader()
                } catch {
//                    self.hideLoader()
                    print("Remove fav error res \(error)")
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
                        self.hideLoader()
                        self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CartShowingResponse.self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        if response.success {
                            
                            if response.parameters.cart!.count > 0 {
                                self.cartID = response.parameters.cart![0].cartID!
                            }
                            
                            if response.parameters.totalItems == 0 {
                                self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                            } else {
                                self.addView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
                                self.addView.layer.cornerRadius = 10
                                self.addView.visiblity(gone: false, dimension: 60, attribute: .height)
                            }
                            
                            if response.parameters.cart!.count > 0 {
                                self.nextLbl.text = HomeConstant.rupeesSym + response.parameters.cart![0].amountPayable!
                                print("order details amount \(response.parameters.cart![0].amountPayable!)")
                            }
                            
                            //                        self.nextLbl.text = String(response.parameters.totalItems) + " Item"
                            
                            self.cakeDetailTableView.reloadData()
                        } else {
                            self.addView.visiblity(gone: true, dimension: 0.0, attribute: .height)
                            self.hideLoader()
                        }
                    }
                } catch {
                    print("cart Showing error res localize \(error)")
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
    
    //Banner View Sliding Image
    @objc func scrollinsetup() {
        if index < bgImageArray.count - 1 {
            index = index + 1
        } else {
            index = 0
        }

        imagerHeaderCell!.pageControl.numberOfPages = bgImageArray.count
        imagerHeaderCell!.pageControl.currentPage = index
        imagerHeaderCell!.cakeDetailCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: true)
    }
}

extension CakeDetailScreen: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if voucherResponse.count != 0 {
            print("self.voucherResponse count \(voucherResponse.count)")
            return 5
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if voucherResponse.count != 0 {
                if section == 2 {
                    return self.voucherResponse.count
                } else {
                    return 1
                }
            }
            
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("total inexpath \(indexPath)")
        if voucherResponse.count != 0 {
            if indexPath.section == 0 {
                imagerHeaderCell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "HeaderCakeTableViewCell", for: indexPath) as! HeaderCakeTableViewCell?
                
                imagerHeaderCell!.context = self
                imagerHeaderCell!.cakeDetailCollectionView.showsHorizontalScrollIndicator = false
                imagerHeaderCell!.selectionStyle = .none
                
                imagerHeaderCell!.favoriteBtn.tag = indexPath.row
                imagerHeaderCell!.favoriteBtn.addTarget(self, action: #selector(favBtnAction(_:)), for: .touchUpInside)

                if bgImageArray.count > 0 {
                    Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollinsetup), userInfo: nil, repeats: true)
                    imagerHeaderCell!.cakeDetailCollectionView.dataSource = self
                    imagerHeaderCell!.cakeDetailCollectionView.delegate = self
                    imagerHeaderCell!.pageControl.numberOfPages = bgImageArray.count
                    imagerHeaderCell!.pageControl.currentPage = index
                    imagerHeaderCell!.pageControl.size(forNumberOfPages: bgImageArray.count)
                }
            
                //Add or remove favorite
                if cakeDetailsResponse?.dish.foodFavorite == true {
                    // Load the original image
                    let originalImage = UIImage(named: "heart_fill")
                    // Create a new image with the desired color
                    let tintedImage = originalImage?.withTintColor(.red)
                    // Set the tinted image as the button's image
                    imagerHeaderCell!.favoriteBtn.setImage(tintedImage, for: .normal)
                } else {
                    // Load the original image
                    let originalImage = UIImage(named: "heart")
                    // Create a new image with the desired color
                    let tintedImage = originalImage?.withTintColor(.red)
                    // Set the tinted image as the button's image
                    imagerHeaderCell!.favoriteBtn.setImage(tintedImage, for: .normal)
                }

                
                return imagerHeaderCell!
                
            } else if indexPath.section == 1 {
                let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "CakePriceTableViewCell", for: indexPath) as! CakePriceTableViewCell
                
                cell.selectionStyle = .none
                cell.context = self
                cell.cakeDetailDishId = cakeDetailsResponse
                cell.cakeName.text = cakeDetailsResponse?.dish.dishName
                if cakeDetailsResponse?.dish.discountPercentage != nil {
                    cell.discountLbl.text = (cakeDetailsResponse?.dish.discountPercentage)! + HomeConstant.percentageSym
                }
                
                if cakeDetailsResponse?.dish.category.categoryName != nil {
                    cell.cakeSubtitle.text = (cakeDetailsResponse?.dish.category.categoryName)!
                }
                
                if cakeDetailsResponse?.dish.landingPrice != nil {
                    cell.getitPriceLbl.text = HomeConstant.rupeesSym + (cakeDetailsResponse?.dish.landingPrice)!
                }
                
                if let sizeName = cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.sizeName, let unitName = cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.unit?.unitName {
                    cell.poundSizeLbl.text = "(" + (cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.sizeName)! + (cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.unit!.unitName)! + ")"
                } else {
                    cell.poundSizeLbl.text = ""
                }

               
                if let price = cakeDetailsResponse?.dish.dishPrice {
                    let priceString = HomeConstant.rupeesSym + price
                    let attributedString = NSAttributedString(string: priceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                    cell.realPrice.attributedText = attributedString
                }

                            
                if cakeDetailsResponse?.dish.dishDiscounts != nil {
                    cell.discountPrice.text = HomeConstant.rupeesSym + (cakeDetailsResponse?.dish.dishDiscounts)!
                }
                
                if let dishRating = cakeDetailsResponse?.dish.dishRating, let rating = Double(dishRating) {
                    cell.ratingView.rating = rating
                } else {
                    // Handle the case where cakeDetailsResponse?.dish.dishRating is nil
                    print("Rating information is not available.")
                    cell.ratingView.rating = 4.0
                }

                if cakeDetailsResponse?.dish.dishType == "veg" {
                    cell.vegorNonvegImg.image = UIImage(named: "vegImage")
                } else {
                    cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
                }
                
                return cell
                
            } else if indexPath.section == 2 {
                
                let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell", for: indexPath) as! OffersTableViewCell
                
                if voucherResponse.count != 0 {

                    cell.isHidden = true
                    
                } else {
                    
                    let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "CakePriceTableViewCell", for: indexPath) as! CakePriceTableViewCell

                    cell.isHidden = false
                    
                    cell.offersLbl.isHidden = false
                    cell.offerLogoImg.isHidden = false
                    
                    cell.offersLbl.text = "Offers Available"
                    cell.offersLbl.font = UIFont.boldSystemFont(ofSize: 18)
                    cell.offersLbl.textColor = UIColor(hexFromString: ColorConstant.BLACK)
                    
                    cell.offerLogoImg.image = UIImage(named: "tag")
                    cell.offerLogoImg.tintColor = UIColor.green
                }

                cell.context = self
                cell.selectionStyle = .none
                
                if !voucherResponse[indexPath.row].vouchersName.isEmpty {
                    cell.FlatDisCounLbl.text = voucherResponse[indexPath.row].vouchersName
                    cell.useCodeLbl.text = "use code " + voucherResponse[indexPath.row].vouchersCode
                    cell.isHidden = false
                } else {
                    cell.isHidden = true
                }

                cell.discountBtn.tag = indexPath.row
                cell.discountBtn.addTarget(self, action: #selector(discountBtnaction(_:)), for: .touchUpInside)

                return cell
            } else if indexPath.section == 3 {
                let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "CakeDescriptionCell", for: indexPath) as! CakeDescriptionCell
                cell.selectionStyle = .none
//                cell.desccriptionLbl.attributedText = cakeDetailsResponse?.dish.description.htmlAttributedString
//                cell.desccriptionLbl.numberOfLines = 0
//                cell.desccriptionLbl.lineBreakMode = .byWordWrapping
                
                if let htmlAttributedString = cakeDetailsResponse?.dish.description.htmlAttributedString {
                    let attributedString = NSMutableAttributedString(attributedString: htmlAttributedString)
                    
                    // Create a font with the desired name and size
                    if let avenirBlackFont = UIFont(name: "Avenir-Medium", size: 14) {
                        attributedString.addAttribute(.font, value: avenirBlackFont, range: NSRange(location: 0, length: attributedString.length))
                    }
                    
                    cell.desccriptionLbl.attributedText = attributedString
                    cell.desccriptionLbl.numberOfLines = 0
                    cell.desccriptionLbl.lineBreakMode = .byWordWrapping
                }

                return cell
                
            } else {
                let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "SuggestedTableViewCell", for: indexPath) as! SuggestedTableViewCell
                
                cell.suggestedDatas = suggestedList
                cell.suggestedCollectionView.reloadData()
                cell.context = self
                cell.suggestedCollectionView.showsHorizontalScrollIndicator = false
                cell.selectionStyle = .none
                cell.cakeDetailResponse = cakeDetailsResponse?.dish
                return cell
            }
        } else {
            if indexPath.section == 0 {
                imagerHeaderCell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "HeaderCakeTableViewCell", for: indexPath) as! HeaderCakeTableViewCell?
                
                imagerHeaderCell!.context = self
                imagerHeaderCell!.cakeDetailCollectionView.showsHorizontalScrollIndicator = false
                imagerHeaderCell!.selectionStyle = .none
                
                imagerHeaderCell!.favoriteBtn.tag = indexPath.row
                imagerHeaderCell!.favoriteBtn.addTarget(self, action: #selector(favBtnAction(_:)), for: .touchUpInside)

                if bgImageArray.count > 0 {
                    Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollinsetup), userInfo: nil, repeats: true)
                    imagerHeaderCell!.cakeDetailCollectionView.dataSource = self
                    imagerHeaderCell!.cakeDetailCollectionView.delegate = self
                    imagerHeaderCell!.pageControl.numberOfPages = bgImageArray.count
                    imagerHeaderCell!.pageControl.currentPage = index
                    imagerHeaderCell!.pageControl.size(forNumberOfPages: bgImageArray.count)
                }
            
                //Add or remove favorite
                if cakeDetailsResponse?.dish.foodFavorite == true {
                    // Load the original image
                    let originalImage = UIImage(named: "heart_fill")
                    // Create a new image with the desired color
                    let tintedImage = originalImage?.withTintColor(.red)
                    // Set the tinted image as the button's image
                    imagerHeaderCell!.favoriteBtn.setImage(tintedImage, for: .normal)
                } else {
                    // Load the original image
                    let originalImage = UIImage(named: "heart")
                    // Create a new image with the desired color
                    let tintedImage = originalImage?.withTintColor(.red)
                    // Set the tinted image as the button's image
                    imagerHeaderCell!.favoriteBtn.setImage(tintedImage, for: .normal)
                }

                
                return imagerHeaderCell!
                
            } else if indexPath.section == 1 {
                let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "CakePriceTableViewCell", for: indexPath) as! CakePriceTableViewCell
                cell.selectionStyle = .none
                cell.context = self
                cell.cakeDetailDishId = cakeDetailsResponse
                cell.cakeName.text = cakeDetailsResponse?.dish.dishName
                
                if cakeDetailsResponse?.dish.discountPercentage != nil {
                    cell.discountLbl.text = (cakeDetailsResponse?.dish.discountPercentage)! + HomeConstant.percentageSym
                }
                
                if cakeDetailsResponse?.dish.category.categoryName != nil {
                    cell.cakeSubtitle.text = (cakeDetailsResponse?.dish.category.categoryName)!
                }
                
                if cakeDetailsResponse?.dish.landingPrice != nil {
                    cell.getitPriceLbl.text = HomeConstant.rupeesSym + (cakeDetailsResponse?.dish.landingPrice)!
                }
                
                if let sizeName = cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.sizeName, let unitName = cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.unit?.unitName {
                    cell.poundSizeLbl.text = "(" + (cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.sizeName)! + (cakeDetailsResponse?.dish.dishsizes[0].sizeDetailsSize.unit!.unitName)! + ")"
                } else {
                    cell.poundSizeLbl.text = ""
                }

               
                if let price = cakeDetailsResponse?.dish.dishPrice {
                    let priceString = HomeConstant.rupeesSym + price
                    let attributedString = NSAttributedString(string: priceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                    cell.realPrice.attributedText = attributedString
                }

                            
                if cakeDetailsResponse?.dish.dishDiscounts != nil {
                    cell.discountPrice.text = HomeConstant.rupeesSym + (cakeDetailsResponse?.dish.dishDiscounts)!
                }

                if let dishRating = cakeDetailsResponse?.dish.dishRating, let ratingDouble = Double(dishRating) {
                    cell.ratingView.rating = ratingDouble
                } else {
                    cell.ratingView.rating = 4.0
                }


                if cakeDetailsResponse?.dish.dishType == "veg" {
                    cell.vegorNonvegImg.image = UIImage(named: "vegImage")
                } else {
                    cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
                }
                return cell
                
            } else if indexPath.section == 2 {
                let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "CakeDescriptionCell", for: indexPath) as! CakeDescriptionCell
                cell.selectionStyle = .none
                cell.desccriptionLbl.attributedText = cakeDetailsResponse?.dish.description.htmlAttributedString
                cell.desccriptionLbl.numberOfLines = 0
                cell.desccriptionLbl.lineBreakMode = .byWordWrapping
                return cell
                
            } else {
                let cell = cakeDetailTableView.dequeueReusableCell(withIdentifier: "SuggestedTableViewCell", for: indexPath) as! SuggestedTableViewCell
                
                cell.suggestedDatas = suggestedList
                cell.suggestedCollectionView.reloadData()
                cell.context = self
                cell.suggestedCollectionView.showsHorizontalScrollIndicator = false
                cell.selectionStyle = .none
                cell.cakeDetailResponse = cakeDetailsResponse?.dish
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
        dish_id = (cakeDetailsResponse?.dish.dishID)!
        dish_name = (cakeDetailsResponse?.dish.dishName)!

        foodFavotiteCheck = ((cakeDetailsResponse?.dish.foodFavorite) != false)
        
        if foodFavotiteCheck {
            print("fav btn add")
            cakeDetailsResponse?.dish.foodFavorite = false
            filledHeart(sender: sender, isFavorite: false)
            FavoriteRemoveApi()
            showToast(message: dish_name + "is Remove to My Wishlist")
        } else {
            print("fav btn remove")
            cakeDetailsResponse?.dish.foodFavorite = true
            filledHeart(sender: sender, isFavorite: true)
            FavoriteAddApi()
            showToast(message: dish_name + "is Add to My Wishlist")
        }
    }
    
    @objc func discountBtnaction(_ sender: UIButton) {

        let row = sender.tag

        if (isBottomSheetShow)
        {
            // hide the bottom sheet
            UIView.animate(withDuration: 0.1, animations: {
                
                self.bottomViewHeightContraint.constant = 180
                self.view.layoutIfNeeded()
            }) { (status) in
                self.isBottomSheetShow = false
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.bottomViewHeightContraint.constant = 0
                    self.view.layoutIfNeeded()
                }) { (status) in
                    // not to be used
                }
                // completion code
            }
        }
        else {
            // show the bottom sheet
            self.discountVoucherView.layer.cornerRadius = 20
            self.discountVoucherView.clipsToBounds = true
            
            self.descriptionLbl.numberOfLines = 0
            self.descriptionLbl.lineBreakMode = .byWordWrapping
            
            titleLbl.text = "Terms & Conditions"
            
            descriptionLbl.attributedText = voucherResponse[row].description.htmlAttributedString
            
//            descriptionLbl.attributedText = voucherResponse.description.htmlAttributedString
                        
            UIView.animate(withDuration: 0.3, animations: {
                self.bottomViewHeightContraint.constant = 240
                self.view.layoutIfNeeded()
            }) { (status) in
                // completion code
                self.isBottomSheetShow = true
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.bottomViewHeightContraint.constant = 220
                    
                    self.view.layoutIfNeeded()
                }) { (status) in
                    
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if voucherResponse.count != 0 {
            if indexPath.section == 0 {
                return 400
            } else if indexPath.section == 1 {
                return 180
            }  else if indexPath.section == 2 {
                if voucherResponse.count != 0 {
                    return 80
                } else {
                    return 0
                }
            }
            else if indexPath.section == 3 {
                return UITableView.automaticDimension
            } else  {
                return 400
            }
        } else {
            if indexPath.section == 0 {
                return 400
            } else if indexPath.section == 1 {
                return 180
            } else if indexPath.section == 2 {
                return UITableView.automaticDimension
            } else  {
                if suggestedList.count == 0 {
                    return 0
                } else {
                    return 400
                }
            }
        }
    }
    
    //Banner Sliding Image Append
    func addImage() {
        
        if cakeDetailsResponse?.dish.withBackground != nil {
            bgImageArray.append((cakeDetailsResponse?.dish.withBackground)!)
        }
        
        if cakeDetailsResponse?.dish.additionalImage != nil {
            bgImageArray.append((cakeDetailsResponse?.dish.additionalImage)!)
        }
        
        if cakeDetailsResponse?.dish.additionalImage2 != nil {
            bgImageArray.append((cakeDetailsResponse?.dish.additionalImage2)!)
        }
    }
}

extension CakeDetailScreen: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bgImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCakeImageCell", for: indexPath) as? HeaderCakeImageCell else {
            return UICollectionViewCell()
        }
        
        cell.bgImage.layer.cornerRadius = 10
        cell.bgImage.layer.masksToBounds = true
        
        if let urlString = bgImageArray[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image")
            cell.bgImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
                
        cell.context = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height))
    }
}
