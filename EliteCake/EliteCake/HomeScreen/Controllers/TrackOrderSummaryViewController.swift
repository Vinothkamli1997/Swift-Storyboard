//
//  TrackOrderSummaryViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 12/05/23.
//

import UIKit


protocol MyDelegate: AnyObject {
    func didGoBack()
}


class TrackOrderSummaryViewController: UIViewController {

    @IBOutlet weak var trackOrderSummaryTableView: UITableView! {
        didSet {
            //Register TableView Cells
            trackOrderSummaryTableView.register(TrackOrderHeaderTableViewCell.nib, forCellReuseIdentifier: TrackOrderHeaderTableViewCell.identifier)
            
//            trackOrderSummaryTableView.register(TrackOrderDishDetailsTableViewCell.nib, forCellReuseIdentifier: TrackOrderDishDetailsTableViewCell.identifier)
            
//            trackOrderSummaryTableView.register(TrackOrderDishListTableViewCell.nib, forCellReuseIdentifier: TrackOrderDishListTableViewCell.identifier)
            
            trackOrderSummaryTableView.register(NewOrderDishDetailsTableViewCell.nib, forCellReuseIdentifier: NewOrderDishDetailsTableViewCell.identifier)
            
            trackOrderSummaryTableView.register(MultiAddOnTableViewCell.nib, forCellReuseIdentifier: MultiAddOnTableViewCell.identifier)

            trackOrderSummaryTableView.register(OrderStatusTableViewCell.nib, forCellReuseIdentifier: OrderStatusTableViewCell.identifier)
            trackOrderSummaryTableView.register(OrderTotalTableViewCell.nib, forCellReuseIdentifier: OrderTotalTableViewCell.identifier)
            trackOrderSummaryTableView.register(OrderSummaryTableViewCell.nib, forCellReuseIdentifier: OrderSummaryTableViewCell.identifier)
            trackOrderSummaryTableView.separatorStyle = .none
            trackOrderSummaryTableView.dataSource = self
            trackOrderSummaryTableView.delegate = self
            trackOrderSummaryTableView.backgroundColor = .clear
            trackOrderSummaryTableView.showsVerticalScrollIndicator = false
            trackOrderSummaryTableView.showsHorizontalScrollIndicator = false
            trackOrderSummaryTableView.tableFooterView = UIView()
        }
    }
    
    @IBOutlet weak var reOrderView: UIView!
    @IBOutlet weak var repeatOrderLbl: UILabel!
    @IBOutlet weak var viewCartLbl: UILabel!
    
    var order_id: String = ""
    var customerID: String = ""
    var outlet_id: String = ""
    var oID: String = ""
    var dish_id: String = ""
    var selectedSizeID: String = ""
    var quantity: String = ""
    var constantHeight: Int = 0
    
    var trackOrderHistoryDetails: [OrderSummaryOrderHistory] = []
    var trackOrderStatus: [OrderSummaryOrderStatus] = []
    var addressOutlet: OrderSummaryOutletDetails?
    var customerDetails: OrderSummaryCustomerDetails?
    var orderDishDetails: [OrderSummaryOrderHasDishDetail] = []
    var addonList: [TrackAddon] = []
    
    weak var delegate: MyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reOrderView.isHidden = true
        self.reOrderView.visiblity(gone: true, dimension: 0.0, attribute: .height)
        
        repeatOrderLbl.text = "Repeat Order"
        repeatOrderLbl.textColor = .white
        repeatOrderLbl.font = UIFont.systemFont(ofSize: 14)
        
        viewCartLbl.text = "VIEW CART ON NEXT STEP"
        viewCartLbl.textColor = .white
        viewCartLbl.font = UIFont.systemFont(ofSize: 14)
            
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reOrderViewTapped))
        reOrderView.addGestureRecognizer(tapGesture)
        reOrderView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        orderTrackApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.trackOrderSummaryTableView.beginUpdates()
            self.trackOrderSummaryTableView.reloadData()
            self.trackOrderSummaryTableView.endUpdates()
        }
    }
    
    func orderTrackApi() {
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
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.ORDER_SUMMARY_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "order_id" : order_id,
            "outlet_id": outlet_id,
            "id": oID
        ] as [String : Any]
        
        print("Order Track Summary params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(OrderSummaryResponse.self, from: data)
                    print("Order Track Summary Response \(response)")
                    
                    if response.success {
                        self.trackOrderHistoryDetails = response.parameters.orderHistory
                        self.trackOrderStatus = response.parameters.orderStatus
                        self.addressOutlet = response.parameters.outletDetails
                        self.customerDetails = response.parameters.customerDetails
                        self.addonList = response.parameters.orderHistory[0].orderHasDishDetails[0].addon!
                        self.orderDishDetails = response.parameters.orderHistory[0].orderHasDishDetails
                    }
                    
                    DispatchQueue.main.async {
                        self.trackOrderSummaryTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Order Track Summary error res \(error)")
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
                    
                    print("addtocart res cart \(response)")
                    
                    DispatchQueue.main.async {
                        
                        if response.success {
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                            vc.backButton = "backButton"
                            vc.backBtnScreenType = false
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            self.trackOrderSummaryTableView.reloadData()
                        }
                    }
                } catch {
                    print("Addtocart error res localize \(error)")
                }
            }
        }
    }
    
    @objc private func reOrderViewTapped() {
        AddToCartApi()
    }
}

extension TrackOrderSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return orderDishDetails.count
        } else if section == 2 {
            return self.addonList.count
        } else if section == 3 {
            return orderDishDetails.count
        } else if section == 4 {
            return self.addonList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "TrackOrderHeaderTableViewCell", for: indexPath) as! TrackOrderHeaderTableViewCell
            
            cell.context = self
            
            if trackOrderHistoryDetails.count > 0 {
                cell.orderStatusLbl.text = trackOrderHistoryDetails[0].status
                cell.order_id = trackOrderHistoryDetails[0].orderID!
            }
            
            
            cell.addressLbl.text = addressOutlet?.address
            cell.cityLbl.text = addressOutlet?.city
            
            print("checkkkkkkkk \(trackOrderHistoryDetails.count)")
            
            if trackOrderHistoryDetails.count > 0 {
                cell.orderStatusLbl.text = trackOrderHistoryDetails[0].status
                cell.order_id = trackOrderHistoryDetails[0].orderID!
                
                
                self.quantity = trackOrderHistoryDetails[0].orderHasDishDetails[indexPath.row].quantity!
                self.dish_id = trackOrderHistoryDetails[0].orderHasDishDetails[indexPath.row].dishDetailsDishID!
                self.selectedSizeID = trackOrderHistoryDetails[0].orderHasDishDetails[indexPath.row].size!
            }
            
            cell.backBtn.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
            
            return cell
            
        }
        
        else if indexPath.section == 1 {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "NewOrderDishDetailsTableViewCell", for: indexPath) as! NewOrderDishDetailsTableViewCell
            
            cell.backgroundColor = .none
            
            cell.selectionStyle = .none
                        
            if indexPath.row < self.orderDishDetails.count {
                if self.orderDishDetails[0].dishType == "veg" {
                    cell.vegorNonvegImg.image = UIImage(named: "vegImage")
                } else {
                    cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
                }
            } else {
                print("Order history index out of range")
            }
            
            if indexPath.row < self.orderDishDetails.count {
                let quantity = self.orderDishDetails[0].quantity
                let dishName = self.orderDishDetails[0].dishName
                
                cell.cakeNameLbl.text = (quantity ?? "") + "x " + (dishName ?? "")
                cell.cakeQuantityLbl.text = (quantity ?? "") + "x " + self.orderDishDetails[0].orderAmount!
                cell.cakePriceLbl.text = HomeConstant.rupeesSym + self.orderDishDetails[0].orderAmount!
                
                if let outletLogoURLString = self.orderDishDetails[0].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
                    cell.cakeImage.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
                } else {
                    cell.cakeImage.image = UIImage(named: "no_image")
                }
                
            } else {
                cell.cakeNameLbl.text = ""
            }
            
            return cell

        }
        
        else if indexPath.section == 2 {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "MultiAddOnTableViewCell", for: indexPath) as! MultiAddOnTableViewCell
            
            cell.backgroundColor = .none
            
            cell.selectionStyle = .none
            
            cell.cakeNameLbl.text = addonList[indexPath.row].addonCart.addonName
            cell.cakePriceLbl.text = HomeConstant.rupeesSym + addonList[indexPath.row].addonCart.addonPrice!
            
            return cell

        }
        
        else if indexPath.section == 3 {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "NewOrderDishDetailsTableViewCell", for: indexPath) as! NewOrderDishDetailsTableViewCell
            
            cell.backgroundColor = .none
            
            cell.selectionStyle = .none
                        
            if indexPath.row < self.orderDishDetails.count {
                if self.orderDishDetails.count > 0 {
                    if indexPath.row < self.orderDishDetails.count { // Check the index against the array count
                        if self.orderDishDetails[indexPath.row].dishType == "veg" {
                            cell.vegorNonvegImg.image = UIImage(named: "vegImage")
                        } else {
                            cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
                        }
                    } else {
                        print("Order history index out of range")
                    }
                }
            }
            
            if self.orderDishDetails.count > 1 {
                if let quantity = self.orderDishDetails[1].quantity, let dishName = self.orderDishDetails[1].dishName, let orderAmount = self.orderDishDetails[1].orderAmount {
                    cell.cakeNameLbl.text = "\(quantity) x \(dishName)"
                    cell.cakeQuantityLbl.text = "\(quantity) x \(orderAmount)"
                    cell.cakePriceLbl.text = HomeConstant.rupeesSym + orderAmount

                    if let outletLogoURLString = self.orderDishDetails[1].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
                        cell.cakeImage.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
                    } else {
                        cell.cakeImage.image = UIImage(named: "no_image")
                    }
                } else {
                    // Handle the case where required data is missing
                    cell.cakeNameLbl.text = "Missing Data"
                }
            } else {
                // Handle the case where there are not enough items in self.orderDishDetails
                cell.cakeNameLbl.text = "No Data Available"
            }

            return cell

        }
        
        else if indexPath.section == 4 {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "MultiAddOnTableViewCell", for: indexPath) as! MultiAddOnTableViewCell
            
            cell.backgroundColor = .none
            
            cell.selectionStyle = .none
            
            cell.cakeNameLbl.text = addonList[indexPath.row].addonCart.addonName
            cell.cakePriceLbl.text = HomeConstant.rupeesSym + addonList[indexPath.row].addonCart.addonPrice!
            
            return cell

        }
        
        else if indexPath.section == 5 {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "OrderStatusTableViewCell", for: indexPath) as! OrderStatusTableViewCell

            cell.trackOrderStatus = trackOrderStatus
            cell.orderStatusCollectionView.reloadData()
            cell.orderStatusCollectionView.showsHorizontalScrollIndicator = false

            return cell
        }
        
        else if indexPath.section == 6 {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "OrderTotalTableViewCell", for: indexPath) as! OrderTotalTableViewCell
            
            if trackOrderHistoryDetails.count > 0 {
                
                cell.itemTotalValueLbl.text = HomeConstant.rupeesSym + trackOrderHistoryDetails[0].amount!
                cell.grandTotalValueLbl.text = HomeConstant.rupeesSym + trackOrderHistoryDetails[0].amountPayable!
                cell.taxValueLbl.text = HomeConstant.rupeesSym + "00.00"
                cell.deliverychargeValueLbl.text = HomeConstant.rupeesSym + trackOrderHistoryDetails[0].delAmt!
                
                if let voucherDiscount = trackOrderHistoryDetails[0].voucherDiscount {
                    cell.couponValueLbl.text = HomeConstant.rupeesSym + voucherDiscount
                } else {
                    cell.couponValueLbl.text = HomeConstant.rupeesSym + "0"
                }
                
                if let coin = trackOrderHistoryDetails[0].superCoinAmount {
                    cell.coinsValueLbl.text = HomeConstant.rupeesSym + coin
                } else {
                    cell.coinsValueLbl.text = HomeConstant.rupeesSym + "0"
                }
            }
            
            return cell
        }
        
        else {
            let cell = trackOrderSummaryTableView.dequeueReusableCell(withIdentifier: "OrderSummaryTableViewCell", for: indexPath) as! OrderSummaryTableViewCell
            
            if trackOrderHistoryDetails.count > 0 {
                
                cell.orderNumValueLbl.text = trackOrderHistoryDetails[indexPath.row].id
                cell.paymentValueLbl.text = "Using " + trackOrderHistoryDetails[indexPath.row].payMode!
                cell.dateValueLbl.text = trackOrderHistoryDetails[indexPath.row].orderTime
                cell.phoneNumvalueLbl.text = customerDetails?.customerMobile
                cell.callLbl.text = "Call " + addressOutlet!.outletName!
                cell.callNumberLbl.text = addressOutlet?.mobile
                cell.deliveryTypeValueLbl.text = trackOrderHistoryDetails[indexPath.row].delType
                
                if let houseNo = trackOrderHistoryDetails[indexPath.row].houseNo, let area = trackOrderHistoryDetails[indexPath.row].area {
                    cell.deliveryValueLbl.text = houseNo + area
                } else {
                    cell.deliveryValueLbl.text = ""
                }
            }
            
            let calltapGestute = UITapGestureRecognizer(target: self, action: #selector(callLabelTapped))
            cell.callLbl.isUserInteractionEnabled = true
            cell.callLbl.addGestureRecognizer(calltapGestute)
            
            let numtapGestute = UITapGestureRecognizer(target: self, action: #selector(callLabelTapped))
            cell.callNumberLbl.isUserInteractionEnabled = true
            cell.callNumberLbl.addGestureRecognizer(numtapGestute)
            
            return cell
        }
    }
    
    @objc func callLabelTapped() {
        
        let mobileNumber = addressOutlet?.mobile
        
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        } else if indexPath.section == 1 {
            return 60
        } else if indexPath.section == 2 {
            if self.addonList.count == 0 {
                return 0
            } else {
                return 20
            }
        } else if indexPath.section == 3 {
            if orderDishDetails.count == 2 {
                return 60
            } else {
                return 0
            }
        } else if indexPath.section == 4 {
            if orderDishDetails.count > 1 {
                if self.addonList.count == 0 {
                    return 0
                } else {
                    return 20
                }
            } else {
                return 0
            }
            
        } else if indexPath.section == 5 {
            return 80
        }
        
        else if indexPath.section == 6 {
            return 185
        } else {
            return 430
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    @objc func backButtonAction(_ sender: UIButton) {
        delegate?.didGoBack()
        
        NotificationCenter.default.post(name: .backAction, object: true)

        // Pop the current view controller
        self.navigationController?.popViewController(animated: true)
    }
}

extension Notification.Name {
    static let backAction = Notification.Name("backActionNotification")
}

