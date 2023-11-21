//
//  CartDishListTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/03/23.
//

import UIKit

class CartDishListTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var dishNameLbl: UILabel!
    
    @IBOutlet weak var dishTypeLbl: UILabel!

    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var dishCountLbl: UILabel!
    
    @IBOutlet weak var dishImage: UIImageView!

    @IBOutlet weak var minusBtn: UIButton!
        
    @IBOutlet weak var plusBtn: UIButton!
    
    @IBOutlet weak var multiAddOnTableView: UITableView!

    @IBOutlet weak var multiAddOnInnerTableViewHeight: NSLayoutConstraint!

    var addonList: [Addon] = []
    
    var orderDishAddonListDetails: [CartHasDishDetail] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTableView()
                
        multiAddOnTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        bgView.backgroundColor = UIColor(hexFromString: ColorConstant.DISH_ITEM_BG_COLOR)
        bottomView.isHidden = false
        addView.layer.cornerRadius = 10
        
        dishNameLbl.font = UIFont.boldSystemFont(ofSize: 12)
        dishTypeLbl.font = UIFont.systemFont(ofSize: 12)
        
        priceLbl.font = UIFont.boldSystemFont(ofSize: 14)
    
        
        let count = addonList.count
        
        self.multiAddOnInnerTableViewHeight.constant = CGFloat(15 * count)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        
        if let tableView = object as? UITableView, tableView == multiAddOnTableView {
            if keyPath == "contentSize", let newvalue = change?[.newKey] as? CGSize {
                self.multiAddOnInnerTableViewHeight.constant = newvalue.height
            }
        }
    }
    
    deinit {
        self.multiAddOnTableView.removeObserver(self, forKeyPath: " contentSize")
    }
    
    func setupTableView() {
//        multiAddOnTableView.register(MultiAddOnTableViewCell.nib, forCellReuseIdentifier: MultiAddOnTableViewCell.identifier)
        multiAddOnTableView.register(CartMultiAddOnTableViewCell.nib, forCellReuseIdentifier: CartMultiAddOnTableViewCell.identifier)
        
        multiAddOnTableView.separatorStyle = .none
        multiAddOnTableView.dataSource = self
        multiAddOnTableView.delegate = self
        multiAddOnTableView.backgroundColor = UIColor(hexFromString: ColorConstant.DISH_ITEM_BG_COLOR)
        multiAddOnTableView.showsVerticalScrollIndicator = false
        multiAddOnTableView.showsHorizontalScrollIndicator = false
        multiAddOnTableView.tableFooterView = UIView()
        multiAddOnTableView.isScrollEnabled = false
        
        multiAddOnTableView.reloadData()
    }
}

extension CartDishListTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = multiAddOnTableView.dequeueReusableCell(withIdentifier: "CartMultiAddOnTableViewCell", for: indexPath) as! CartMultiAddOnTableViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(hexFromString: ColorConstant.DISH_ITEM_BG_COLOR)
        
        cell.cakeNameLbl.text = addonList[indexPath.row].addonCart?.addonName
        cell.cakePriceLbl.text = HomeConstant.rupeesSym + (addonList[indexPath.row].addonCart?.addonPrice!)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
