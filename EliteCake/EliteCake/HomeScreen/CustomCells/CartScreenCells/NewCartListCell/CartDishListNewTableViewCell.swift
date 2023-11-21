//
//  CartDishListNewTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 21/10/23.
//

import UIKit

class CartDishListNewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var trackOrderDishListTableView: UITableView!

    @IBOutlet weak var trackOrderDishListTableViewHeight: NSLayoutConstraint!
    
    var orderDishListDetails: [CartHasDishDetail] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTableView()
        
        trackOrderDishListTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        let count = orderDishListDetails.count
        
        self.trackOrderDishListTableViewHeight.constant = CGFloat(8 * count)
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
        trackOrderDishListTableView.register(SeletedDishListTableViewCell.nib, forCellReuseIdentifier: SeletedDishListTableViewCell.identifier)
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

extension CartDishListNewTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("orderDishListDetails.count \(orderDishListDetails.count)")
        return orderDishListDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trackOrderDishListTableView.dequeueReusableCell(withIdentifier: "SeletedDishListTableViewCell", for: indexPath) as! SeletedDishListTableViewCell
        
        cell.selectionStyle = .none
        
        cell.addonList = orderDishListDetails[indexPath.row].addon!
                
        cell.cakeNameLbl.text = orderDishListDetails[indexPath.row].dishName
        
        print("Cart dissslist name \(String(describing: orderDishListDetails[indexPath.row].dishName))")
        
        cell.priceLbl.text = HomeConstant.rupeesSym + orderDishListDetails[indexPath.row].orderAmount!
        cell.dishCount.text = orderDishListDetails[indexPath.row].quantity! + "x"
        cell.dishCountPrice.text = orderDishListDetails[indexPath.row].orderAmount
        
        if let outletLogoURLString = orderDishListDetails[indexPath.row].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
            cell.cakeNameImg.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
        } else {
            cell.cakeNameImg.image = UIImage(named: "no_image")
        }
        
        cell.multiAddOnTableView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
