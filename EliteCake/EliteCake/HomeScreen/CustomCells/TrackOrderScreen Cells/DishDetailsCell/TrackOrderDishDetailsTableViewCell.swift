//
//  TrackOrderDishDetailsTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 15/05/23.
//

import UIKit

class TrackOrderDishDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var vegNonVegImg: UIImageView!
    
    @IBOutlet weak var cakeNameLbl: UILabel!
    
    @IBOutlet weak var cakeNameImg: UIImageView!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var dishCount: UILabel!
    
    @IBOutlet weak var dishCountPrice: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var multiAddOnTableView: UITableView!

    @IBOutlet weak var multiAddOnInnerTableViewHeight: NSLayoutConstraint!

    var addonList: [TrackAddon] = []
    
    var orderDishAddonListDetails: [OrderSummaryOrderHasDishDetail] = []


    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTableView()
        
        multiAddOnTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        vegNonVegImg.image = UIImage(named: "vegImage")
        
        cakeNameLbl.font = UIFont.boldSystemFont(ofSize: 12)
        
        priceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        bottomView.backgroundColor = UIColor.green
        
        bottomView.isHidden = true
                
        let count = addonList.count
        
        self.multiAddOnInnerTableViewHeight.constant = CGFloat(15 * count)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        self.multiAddOnTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func setupTableView() {
        multiAddOnTableView.register(MultiAddOnTableViewCell.nib, forCellReuseIdentifier: MultiAddOnTableViewCell.identifier)
        multiAddOnTableView.separatorStyle = .none
        multiAddOnTableView.dataSource = self
        multiAddOnTableView.delegate = self
        multiAddOnTableView.backgroundColor = .clear
        multiAddOnTableView.showsVerticalScrollIndicator = false
        multiAddOnTableView.showsHorizontalScrollIndicator = false
        multiAddOnTableView.tableFooterView = UIView()
        multiAddOnTableView.isScrollEnabled = false        
    }
    
}

extension TrackOrderDishDetailsTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Addon list Count \(addonList.count)")
        return addonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = multiAddOnTableView.dequeueReusableCell(withIdentifier: "MultiAddOnTableViewCell", for: indexPath) as! MultiAddOnTableViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = .none
        
        cell.cakeNameLbl.text = addonList[indexPath.row].addonCart.addonName
        cell.cakePriceLbl.text = HomeConstant.rupeesSym + addonList[indexPath.row].addonCart.addonPrice!

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

