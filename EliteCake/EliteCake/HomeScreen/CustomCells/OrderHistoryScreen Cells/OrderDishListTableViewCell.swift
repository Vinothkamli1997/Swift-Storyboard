//
//  OrderDishListTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 22/05/23.
//

import UIKit

class OrderDishListTableViewCell: UITableViewCell {
    
    @IBOutlet var vegorNonvegImg: UIImageView!
    
    @IBOutlet var cakeNameLbl: UILabel!
    
    @IBOutlet var cakeImage: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var addOnTableView: UITableView!
    
    @IBOutlet weak var innerTableViewHeight: NSLayoutConstraint!
    
    var addonList: [TrackAddon] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTableView()
        
        addOnTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        cakeNameLbl.font = UIFont.systemFont(ofSize: 14)
        
//        let count = addonList.count
        let count = 5
        
        self.innerTableViewHeight.constant = CGFloat(20 * count) + 40
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        
        if let tableView = object as? UITableView, tableView == addOnTableView {
            if keyPath == "contentSize", let newvalue = change?[.newKey] as? CGSize {
                self.innerTableViewHeight.constant = newvalue.height
            }
        }
    }
    
    deinit {
        self.addOnTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setupTableView() {
        addOnTableView.register(MultiAddOnTableViewCell.nib, forCellReuseIdentifier: MultiAddOnTableViewCell.identifier)
        addOnTableView.separatorStyle = .none
        addOnTableView.dataSource = self
        addOnTableView.delegate = self
        addOnTableView.backgroundColor = .clear
        addOnTableView.showsVerticalScrollIndicator = false
        addOnTableView.showsHorizontalScrollIndicator = false
        addOnTableView.tableFooterView = UIView()
        addOnTableView.isScrollEnabled = false
        
//        addOnTableView.reloadData()
    }
    
}

extension OrderDishListTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("order history Addon Count \(addonList.count)")
//        return addonList.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addOnTableView.dequeueReusableCell(withIdentifier: "MultiAddOnTableViewCell", for: indexPath) as! MultiAddOnTableViewCell
        
//        cell.selectionStyle = .none
//        
//        cell.backgroundColor = .yellow
//
//        
//        cell.cakeNameLbl.text = addonList[indexPath.row].addonCart.addonName
//        cell.cakePriceLbl.text = HomeConstant.rupeesSym + addonList[indexPath.row].addonCart.addonPrice!

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
