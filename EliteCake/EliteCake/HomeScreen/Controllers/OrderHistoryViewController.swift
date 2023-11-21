//
//  OrderHistoryViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 20/03/23.
//

import UIKit

class OrderHistoryViewController: UIViewController, MyDelegate {
    
    func didGoBack() {
        print("Received 'back = true' from the previous view controller")
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var orderHistoryTableView: UITableView! {
        didSet {
            //Register TableView Cells
            //            orderHistoryTableView.register(OrderHistoryNewTableViewCell.nib, forCellReuseIdentifier: OrderHistoryNewTableViewCell.identifier)
            
            orderHistoryTableView.register(SingleOrderHistoryTableViewCell.nib, forCellReuseIdentifier: SingleOrderHistoryTableViewCell.identifier)
            
            orderHistoryTableView.separatorStyle = .none
            orderHistoryTableView.dataSource = self
            orderHistoryTableView.delegate = self
            orderHistoryTableView.backgroundColor = .clear
            orderHistoryTableView.showsVerticalScrollIndicator = false
            orderHistoryTableView.showsHorizontalScrollIndicator = false
            orderHistoryTableView.tableFooterView = UIView()
        }
    }
        
    @IBOutlet weak var emptyCartImage: UIImageView!
    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var exploreBtn: UIButton!
    @IBOutlet weak var cartEmptyView: UIView!
    
    var onBackButtonTapped: ((String) -> Void)?
    
    var customerID: String = ""
    var dish_id: String = ""
    var outletId: String = ""
    var oID: String = ""
    var selectedSizeID: String = ""
    var quantity: String = ""
    var toast: String = ""
    var outlet_id: String = ""
    var orderHistoryList: [OrderHistorys] = []
    var orderHistoryDishList: [OrderHasDishDetail] = []
    var outletDetails: OutletDetail?
    var addonHistoryList: [TrackAddon] = []
    var showAllCategoryList: [Category] = []
    
    var back: Bool = false
    var backButtonAction: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderHistoryApi()
        
        self.orderHistoryTableView.reloadData()
        
        setUP()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.HomeApi()
                        
            self.orderHistoryTableView.reloadData()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            self.orderHistoryTableView.beginUpdates()
            
            self.orderHistoryTableView.reloadData()
            
            self.orderHistoryTableView.endUpdates()
        }
    }
    
    func setUP() {
        titleLbl.text = "Order History"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.tintColor = UIColor.black
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        emptyCartImage.image = UIImage(named: "online_shop")
        
        exploreBtn.setTitle("Explore", for: .normal)
        exploreBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        exploreBtn.layer.borderWidth = 1.0
        exploreBtn.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        exploreBtn.layer.cornerRadius = 10
        
        emptyLbl.text = "Your Order History is Empty"
        emptyLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        contentLbl.text = "Looks like you haven't made your choice yet"
        contentLbl.font = UIFont.boldSystemFont(ofSize: 16)
        contentLbl.textColor = UIColor.lightGray
        contentLbl.numberOfLines = 2
        
        NotificationCenter.default.addObserver(forName: .backAction, object: nil, queue: .main) { notification in
            if let time = notification.object as? Bool {
                self.back = time
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        if backButtonAction {
            self.navigationController?.popViewController(animated: true)
        } else {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            vc.backButton = "backButton"
            vc.backBtnScreenType = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func exploreBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
        vc.category_ID = showAllCategoryList[0].categoryID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func orderHistoryApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.ORDER_HISTORY_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "outlet_id": outlet_id
        ] as [String : Any]
        
        print("Orderhistory params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.hideLoader()
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(OrderHistoryResponse.self, from: data)
                    print("Orderhistory Response \(response)")
                    
                    DispatchQueue.main.async {
                        if response.parameters.orderHistory?.count != 0 {
                            self.orderHistoryTableView.isHidden = false
                            self.cartEmptyView.isHidden = true
                            
                            self.orderHistoryList = response.parameters.orderHistory!
                            
                            self.outletDetails = response.parameters.outletDetails
                        } else {
                            self.orderHistoryTableView.isHidden = true
                            self.cartEmptyView.isHidden = false
                        }
                    }
                                        
                    DispatchQueue.main.async {
                        if !response.parameters.orderHistory!.isEmpty {
                            let firstOrder = response.parameters.orderHistory![0]
                            if !firstOrder.orderHasDishDetails.isEmpty {
                                let firstOrderDetail = firstOrder.orderHasDishDetails[0]
                                if let firstOrderAddon = firstOrderDetail.addon {
                                    self.orderHistoryTableView.isHidden = false
                                    self.cartEmptyView.isHidden = true

                                    // Use the firstOrderAddon array here
                                    self.addonHistoryList = firstOrderAddon
                                } else {
                                    // Handle case where addon is nil
                                }
                            } else {
                                // Handle case where orderHasDishDetails is empty
                            }
                        } else {
                            self.orderHistoryTableView.isHidden = true
                            self.cartEmptyView.isHidden = false
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.orderHistoryTableView.reloadData()
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Orderhistory error res \(error)")
                }
            }
        }
    }
    
    //Add to cart API
    func AddToCartApi() {
        
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
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                            vc.backBtnScreenType = true
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            self.orderHistoryTableView.reloadData()
                        }
                    }
                } catch {
                    print("Addtocart error res localize \(error)")
                }
            }
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
                        self.orderHistoryTableView.reloadData()
                    }
                    
                } catch {
                    print("home error res \(error)")
                }
            }
        }
    }
}

extension OrderHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = orderHistoryTableView.dequeueReusableCell(withIdentifier: "SingleOrderHistoryTableViewCell", for: indexPath) as! SingleOrderHistoryTableViewCell
        
        
        cell.selectionStyle = .none
        
        if self.orderHistoryList[indexPath.row].orderHasDishDetails.count > 0 {
            cell.dishListName.text = self.orderHistoryList[indexPath.row].orderHasDishDetails[0].dishName
            
            if let outletLogoURLString = self.orderHistoryList[indexPath.row].orderHasDishDetails[0].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
                cell.dishListCakeImage.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
            } else {
                cell.dishListCakeImage.image = UIImage(named: "no_image")
            }
            
            if self.orderHistoryList[indexPath.row].orderHasDishDetails[0].dishType == "veg" {
                cell.dishListCakeVagImage.image = UIImage(named: "vegImage")
            } else {
                cell.dishListCakeVagImage.image = UIImage(named: "nonVegImage")
            }
        }
        
        if self.orderHistoryList[indexPath.row].orderHasDishDetails[0].addon!.count > 0 {
            
            cell.addonDishListView.visiblity(gone: false, dimension: 20, attribute: .height)
            cell.addonDishListView.isHidden = false
            
            cell.addonDishName.text = "\(self.orderHistoryList[indexPath.row].orderHasDishDetails[0].addon!.count)" + " Add-Ons Added"
            cell.addonDishName.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            
            cell.addonDishPrice.text = "Show"
            cell.addonDishPrice.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
            
        } else {
            cell.addonDishListView.visiblity(gone: true, dimension: 0.0, attribute: .height)
        }
        
        if orderHistoryList.count > 0 {
            cell.dateTimeLbl.text = orderHistoryList[indexPath.row].orderTime
            cell.dateLbl.text = orderHistoryList[indexPath.row].orderTime
            cell.statusLbl.text = orderHistoryList[indexPath.row].status
            cell.dishPriceLbl.text = HomeConstant.rupeesSym + self.orderHistoryList[indexPath.row].amountPayable!
        }
        
        if orderHistoryList[indexPath.row].status == "Delivered" {
            if orderHistoryList[indexPath.row].orderHasDishDetails[0].customerRating == nil {
                cell.ratingBgView.isHidden = false
            } else {
                cell.ratingBgView.isHidden = false
                cell.ratingViewLabel1.text = orderHistoryList[indexPath.row].orderHasDishDetails[0].customerRating?.rating
                cell.ratingViewLabel1.textColor = UIColor.white
                cell.ratingTitleLbl.text = "You Rated"
                cell.ratingViewImage1.tintColor = UIColor.white
                cell.ratingView1.backgroundColor = UIColor(hexFromString: ColorConstant.GREEN)
                cell.ratingView2.isHidden = true
                cell.ratingView3.isHidden = true
                cell.ratingView4.isHidden = true
                cell.ratingView5.isHidden = true
            }
        } else {
            cell.ratingBgView.isHidden = true
        }
        
        cell.addonDishName.tag = indexPath.row
        let addOndishPriceTapGesture = UITapGestureRecognizer(target: self, action: #selector(addOnDishPriceViewTapped(_:)))
        cell.addonDishName.isUserInteractionEnabled = true
        cell.addonDishName.addGestureRecognizer(addOndishPriceTapGesture)
        
        cell.viewMenuLbl.tag = indexPath.row
        let UILabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewMenuLblTapped(_:)))
        cell.viewMenuLbl.isUserInteractionEnabled = true
        cell.viewMenuLbl.addGestureRecognizer(UILabelTapGesture)
        
        cell.ratingBgView.tag = indexPath.row
        let UIViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(ratingBgViewTapped(_:)))
        cell.ratingBgView.addGestureRecognizer(UIViewTapGesture)
        
        cell.reorderBtn.tag = indexPath.row
        cell.reorderBtn.addTarget(self, action: #selector(reorderBtnTapped(_:)), for: .touchUpInside)
        
        let callTapGesture = UITapGestureRecognizer(target: self, action: #selector(callViewTapped))
        cell.callView.isUserInteractionEnabled = true
        cell.callView.addGestureRecognizer(callTapGesture)
        
        cell.dishPriceLbl.tag = indexPath.row
        let dishPriceTapGesture = UITapGestureRecognizer(target: self, action: #selector(dishPriceViewTapped(_:)))
        cell.dishPriceLbl.isUserInteractionEnabled = true
        cell.dishPriceLbl.addGestureRecognizer(dishPriceTapGesture)
        
        cell.trailingBtn.tag = indexPath.row
        cell.trailingBtn.addTarget(self, action: #selector(trailingBtnTapped(_:)), for: .touchUpInside)
        
        cell.viewMenuBtn.tag = indexPath.row
        cell.viewMenuBtn.addTarget(self, action: #selector(trailingBtnTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    @objc func viewMenuLblTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let tappedView = gestureRecognizer.view as? UILabel else {
            return
        }
        
        let rowIndex = tappedView.tag
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderSummaryViewController") as! TrackOrderSummaryViewController
        
        vc.order_id = orderHistoryList[rowIndex].orderID!
        print("track order dish id \(orderHistoryList[rowIndex].orderID!)")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func reorderBtnTapped(_ sender: UIButton) {
        
        let row = sender.tag
        
        if orderHistoryList.count > 0 {
            self.quantity = orderHistoryList[row].orderHasDishDetails[0].quantity!
            self.dish_id = orderHistoryList[row].orderHasDishDetails[0].dishDetailsDishID!
            self.selectedSizeID = orderHistoryList[row].orderHasDishDetails[0].size!
        }
        
        AddToCartApi()
    }
    
    @objc func ratingBgViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        
        print("history rating tapped")
        if let view = gestureRecognizer.view {
            print("history gestureRecognizer View rating tapped")
            // Get the index of the tapped cell from the view's tag
            let rowIndex = view.tag
            
            // Now you can access the order information using the rowIndex
            if orderHistoryList[rowIndex].orderHasDishDetails[0].customerRating == nil {
                if orderHistoryList[rowIndex].orderHasDishDetails.count > 0 {
                    if let orderID = orderHistoryList[rowIndex].orderID,
                       let dishDetails = orderHistoryList[rowIndex].orderHasDishDetails[0].dishID {
                        
                        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
                        
                        vc.orderID = orderID
                        vc.dishID = dishDetails
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        printContent(("order hostory dishID rating nil"))
                    }
                } else {
                    printContent(("order hostory orderHas rating nil"))
                }
            } else {
                printContent(("order hostory customer rating nil"))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderSummaryViewController") as! TrackOrderSummaryViewController
        vc.order_id = orderHistoryList[indexPath.row].orderID!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dishPriceViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let label = gestureRecognizer.view as? UILabel,
           label.tag < orderHistoryList.count {

            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderSummaryViewController") as! TrackOrderSummaryViewController
            vc.order_id = orderHistoryList[label.tag].orderID!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addOnDishPriceViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let label = gestureRecognizer.view as? UILabel,
           label.tag < orderHistoryList.count {

            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderSummaryViewController") as! TrackOrderSummaryViewController
            vc.order_id = orderHistoryList[label.tag].orderID!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func trailingBtnTapped(_ sender: UIButton) {
        
        let row = sender.tag
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderSummaryViewController") as! TrackOrderSummaryViewController
        vc.order_id = orderHistoryList[row].orderID!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func callViewTapped() {
        
        let mobileNumber = self.outletDetails?.mobile
        
        // Remove any non-digit characters from the mobile number
        let cleanedMobileNumber = mobileNumber!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Check if the cleaned mobile number is empty or not
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
}
