//
//  TrackOrderDishListTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 18/10/23.
//

import UIKit

class TrackOrderDishListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var trackOrderDishListTableView: UITableView!

    @IBOutlet weak var trackOrderDishListTableViewHeight: NSLayoutConstraint!
    
    var orderDishListDetails: [OrderSummaryOrderHasDishDetail] = []
    var orderHistoryAddonList: [TrackAddon] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupTableView()
        
        trackOrderDishListTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        let count = orderHistoryAddonList.count
        
        print("COunttttttttttttt \(count)")
        
        self.trackOrderDishListTableViewHeight.constant = CGFloat(20 * count)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        
        if let tableView = object as? UITableView, tableView == trackOrderDishListTableView {
            if keyPath == "contentSize", let newvalue = change?[.newKey] as? CGSize {
                self.trackOrderDishListTableViewHeight.constant = newvalue.height
            }
        }
    }
    
    deinit {
        self.trackOrderDishListTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func setupTableView() {
//        trackOrderDishListTableView.register(TrackOrderDishDetailsTableViewCell.nib, forCellReuseIdentifier: TrackOrderDishDetailsTableViewCell.identifier)
        
        trackOrderDishListTableView.register(OrderHistoryHeaderCell.nib, forHeaderFooterViewReuseIdentifier: OrderHistoryHeaderCell.identifier)
        trackOrderDishListTableView.register(MultiAddOnTableViewCell.nib, forCellReuseIdentifier: MultiAddOnTableViewCell.identifier)
        
        trackOrderDishListTableView.separatorStyle = .none
        trackOrderDishListTableView.dataSource = self
        trackOrderDishListTableView.delegate = self
        trackOrderDishListTableView.backgroundColor = .clear
        trackOrderDishListTableView.showsVerticalScrollIndicator = false
        trackOrderDishListTableView.showsHorizontalScrollIndicator = false
        trackOrderDishListTableView.tableFooterView = UIView()
        trackOrderDishListTableView.isScrollEnabled = false
        
        trackOrderDishListTableView.reloadData()
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}


extension TrackOrderDishListTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return orderDishListDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orderDishListDetails.count
        return orderHistoryAddonList.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = trackOrderDishListTableView.dequeueReusableCell(withIdentifier: "TrackOrderDishDetailsTableViewCell", for: indexPath) as! TrackOrderDishDetailsTableViewCell
//        
//        cell.selectionStyle = .none
//        
//        cell.addonList = orderDishListDetails[indexPath.row].addon!
//                
//        cell.cakeNameLbl.text = orderDishListDetails[indexPath.row].dishName
//        cell.priceLbl.text = HomeConstant.rupeesSym + orderDishListDetails[indexPath.row].orderAmount!
//        cell.dishCount.text = orderDishListDetails[indexPath.row].quantity! + "x"
//        cell.dishCountPrice.text = orderDishListDetails[indexPath.row].orderAmount
//        
//        if let outletLogoURLString = orderDishListDetails[indexPath.row].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
//            cell.cakeNameImg.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
//        } else {
//            cell.cakeNameImg.image = UIImage(named: "no_image")
//        }
//        
//        cell.multiAddOnTableView.reloadData()
//        
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trackOrderDishListTableView.dequeueReusableCell(withIdentifier: "MultiAddOnTableViewCell", for: indexPath) as! MultiAddOnTableViewCell
        
        cell.selectionStyle = .none
        
        if orderDishListDetails.count > 0 {
            if orderHistoryAddonList.count > 0 {
                cell.cakeNameLbl.text = orderHistoryAddonList[indexPath.row].addonCart.addonName
                cell.cakePriceLbl.text = HomeConstant.rupeesSym + orderHistoryAddonList[indexPath.row].addonCart.addonPrice!
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OrderHistoryHeaderCell.identifier) as? OrderHistoryHeaderCell else {
            return UIView()
        }
        
        cell.backgroundColor = .clear
        
        if section < orderDishListDetails.count {
            if orderDishListDetails[section].dishType == "veg" {
                cell.vegorNonvegImg.image = UIImage(named: "vegImage")
            } else {
                cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
            }
        } else {
            print("Order history index out of range")
        }
        
        if section < orderDishListDetails.count {
            let quantity = orderDishListDetails[section].quantity
            let dishName = orderDishListDetails[section].dishName
            let orderAmount = orderDishListDetails[section].orderAmount
                        
            cell.cakeNameLbl.text = (quantity ?? "") + "x " + (dishName ?? "")
            cell.cakeQuantityLbl.text = (quantity ?? "") + "x " + (orderAmount ?? "")
            cell.cakePriceLbl.text = HomeConstant.rupeesSym + orderDishListDetails[section].orderAmount!
            
            if let outletLogoURLString = orderDishListDetails[section].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
                cell.cakeImage.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
            } else {
                cell.cakeImage.image = UIImage(named: "no_image")
            }
            
        } else {
            cell.cakeNameLbl.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
}
