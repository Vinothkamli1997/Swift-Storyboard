//
//  OrderSummaryViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 04/05/23.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    
    @IBOutlet weak var summaryTableView: UITableView! {
        didSet {
            //Register TableView Cells
            summaryTableView.register(HeaderTableViewCell.nib, forCellReuseIdentifier: HeaderTableViewCell.identifier)
            summaryTableView.register(MapTableViewCell.nib, forCellReuseIdentifier: MapTableViewCell.identifier)
            summaryTableView.register(OrderDetailTableViewCell.nib, forCellReuseIdentifier: OrderDetailTableViewCell.identifier)
            summaryTableView.register(UserAddressTableViewCell.nib, forCellReuseIdentifier: UserAddressTableViewCell.identifier)
            summaryTableView.separatorStyle = .none
            summaryTableView.dataSource = self
            summaryTableView.delegate = self
            summaryTableView.backgroundColor = .clear
            summaryTableView.showsVerticalScrollIndicator = false
            summaryTableView.showsHorizontalScrollIndicator = false
            summaryTableView.tableFooterView = UIView()
        }
    }
    
    var order_id: String = ""
    var customerID: String = ""
    var trackOrderDetails: OrderTrackParameters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTrackApi()
    }
    
    
    func orderTrackApi() {
        self.showLoader()
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.ORDER_TRACK_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "order_id" : order_id
        ] as [String : Any]
        
        print("Order Track params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(OrderTrackResponse.self, from: data)
                    print("Order Track Response \(response)")
                    
                    
                    self.trackOrderDetails = response.parameters
                    
                    DispatchQueue.main.async {
                        self.summaryTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Order Track error res \(error)")
                }
            }
        }
    }
}

extension OrderSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = summaryTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            
            cell.context = self
            return cell
        } else if indexPath.section == 1  {
            let cell = summaryTableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath) as! MapTableViewCell
            
            return cell
            
        } else if indexPath.section == 2 {
            let cell = summaryTableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as! OrderDetailTableViewCell
            if trackOrderDetails != nil {
                cell.addressLbl.text = trackOrderDetails!.orderHistory[0].address
                cell.cakeNameLbl.text = trackOrderDetails!.orderHistory[0].orderHasDishDetails[0].dishName
                cell.deliveryTypeLbl.text = trackOrderDetails!.orderHistory[0].currentStatus
            }
            
            return cell
        } else {
            let cell = summaryTableView.dequeueReusableCell(withIdentifier: "UserAddressTableViewCell", for: indexPath) as! UserAddressTableViewCell
            
            if trackOrderDetails != nil {

                cell.nameLbl.text = trackOrderDetails!.orderHistory[0].customerName! + ","
            
                let dropLbl = String(trackOrderDetails!.orderHistory[0].customerMobile!.dropLast(3)) + "XXX"
            
            cell.phoneNumberLbl.text = dropLbl
                cell.addressLbl.text = trackOrderDetails!.orderHistory[0].houseNo! + "," + trackOrderDetails!.orderHistory[0].area!
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else if indexPath.section == 1 {
            return 250
        } else if indexPath.section == 2 {
            return 220
        } else {
            return 150
        }
    }
}
