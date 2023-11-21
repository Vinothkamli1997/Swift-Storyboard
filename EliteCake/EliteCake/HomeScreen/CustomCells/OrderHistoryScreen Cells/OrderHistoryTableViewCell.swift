//
//  OrderHistoryTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 08/05/23.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var cakeImage: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var viewMenuLbl: UILabel!
    
    @IBOutlet weak var viewMenuBtn: UIButton!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var orderDishListTableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reorderBtn: UIButton!
    
    @IBOutlet weak var ratingBgView: UIView!
    @IBOutlet weak var ratingTitleLbl: UILabel!
    
    @IBOutlet weak var ratingView1: UIView!
    @IBOutlet weak var ratingViewLabel1: UILabel!
    @IBOutlet weak var ratingViewImage1: UIImageView!
    
    @IBOutlet weak var ratingView2: UIView!
    @IBOutlet weak var ratingViewLabel2: UILabel!
    @IBOutlet weak var ratingViewImage2: UIImageView!
    
    @IBOutlet weak var ratingView3: UIView!
    @IBOutlet weak var ratingViewLabel3: UILabel!
    @IBOutlet weak var ratingViewImage3: UIImageView!
    
    @IBOutlet weak var ratingView4: UIView!
    @IBOutlet weak var ratingViewLabel4: UILabel!
    @IBOutlet weak var ratingViewImage4: UIImageView!
    
    @IBOutlet weak var ratingView5: UIView!
    @IBOutlet weak var ratingViewLabel5: UILabel!
    @IBOutlet weak var ratingViewImage5: UIImageView!
    
    @IBOutlet weak var innerTableViewHeight: NSLayoutConstraint!
    
    var orderHistoryDishList: [OrderHasDishDetail] = []
//    var orderHistoryAddonList: [OrderHistorys] = []
    var orderHistoryAddonList: [TrackAddon] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
        setupTableView()
        
        
        orderDishListTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 20
        setShadow(view: bgView)
        
        titleLbl.text = "Elite Cakes"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        setShadow(view: cakeImage)
        
        dateTimeLbl.font = UIFont.systemFont(ofSize: 14)
        dateTimeLbl.textColor = UIColor.gray
        
        statusLbl.font = UIFont.boldSystemFont(ofSize: 14)
        statusLbl.textColor = .black
        
        statusView.backgroundColor = UIColor(hexFromString: ColorConstant.STATUS_BG)
        statusView.layer.cornerRadius = 10
        setShadow(view: statusView)
        
        viewMenuLbl.text = "View menu"
        viewMenuLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        viewMenuLbl.font = UIFont.systemFont(ofSize: 14)
        
        viewMenuBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        viewMenuBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        firstView.backgroundColor = UIColor(hexFromString: ColorConstant.FIRST_OFF_BG)
        firstView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        
        secondView.backgroundColor = UIColor.white
        secondView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        
        reorderBtn.setTitle("Reorder", for: .normal)
        reorderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        reorderBtn.layer.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        reorderBtn.tintColor = UIColor.white
        reorderBtn.layer.cornerRadius = 10
        setLightShadow(view: reorderBtn)
        
        ratingTitleLbl.text = "Rating"
        ratingTitleLbl.textColor = UIColor.black
        ratingTitleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        ratingViewLabel1.text = "1"
        ratingViewLabel1.textColor = .black
        ratingViewImage1.image = UIImage(systemName: "star.fill")
        ratingViewImage1.tintColor = .lightGray
        
        ratingView1.layer.borderWidth = 1
        ratingView1.layer.borderColor = UIColor.gray.cgColor
        ratingView1.layer.cornerRadius = 10
        ratingView1.backgroundColor = .clear
        
        ratingViewLabel2.text = "2"
        ratingViewLabel2.textColor = .black
        ratingViewImage2.image = UIImage(systemName: "star.fill")
        ratingViewImage2.tintColor = .lightGray

        ratingView2.layer.borderWidth = 1
        ratingView2.layer.borderColor = UIColor.gray.cgColor
        ratingView2.layer.cornerRadius = 10
        ratingView2.backgroundColor = .clear

        ratingViewLabel3.text = "3"
        ratingViewLabel3.textColor = .black
        ratingViewImage3.image = UIImage(systemName: "star.fill")
        ratingViewImage3.tintColor = .lightGray

        ratingView3.layer.borderWidth = 1
        ratingView3.layer.borderColor = UIColor.gray.cgColor
        ratingView3.layer.cornerRadius = 10
        ratingView3.backgroundColor = .clear

        ratingViewLabel4.text = "4"
        ratingViewLabel4.textColor = .black
        ratingViewImage4.image = UIImage(systemName: "star.fill")
        ratingViewImage4.tintColor = .lightGray

        ratingView4.layer.borderWidth = 1
        ratingView4.layer.borderColor = UIColor.gray.cgColor
        ratingView4.layer.cornerRadius = 10
        ratingView4.backgroundColor = .clear

        ratingViewLabel5.text = "5"
        ratingViewLabel5.textColor = .black
        ratingViewImage5.image = UIImage(systemName: "star.fill")
        ratingViewImage5.tintColor = .lightGray

        ratingView5.layer.borderWidth = 1
        ratingView5.layer.borderColor = UIColor.gray.cgColor
        ratingView5.layer.cornerRadius = 10
        ratingView5.backgroundColor = .clear

        let count = orderHistoryDishList.count
        
        self.innerTableViewHeight.constant = CGFloat(80 * count)

        orderDishListTableView.reloadData()

    }
    
    func setupTableView() {
        orderDishListTableView.register(OrderDishListTableViewCell.nib, forCellReuseIdentifier: OrderDishListTableViewCell.identifier)
        orderDishListTableView.separatorStyle = .none
        orderDishListTableView.dataSource = self
        orderDishListTableView.delegate = self
        orderDishListTableView.backgroundColor = .clear
        orderDishListTableView.showsVerticalScrollIndicator = false
        orderDishListTableView.showsHorizontalScrollIndicator = false
        orderDishListTableView.tableFooterView = UIView()
        orderDishListTableView.isScrollEnabled = false
        
        orderDishListTableView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        
        if let tableView = object as? UITableView, tableView == orderDishListTableView {
            if keyPath == "contentSize", let newvalue = change?[.newKey] as? CGSize {
                self.tableViewHeight.constant = newvalue.height
            }
        }
    }
    
    deinit {
        self.orderDishListTableView.removeObserver(self, forKeyPath: "contentSize")
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension OrderHistoryTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryDishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderDishListTableView.dequeueReusableCell(withIdentifier: "OrderDishListTableViewCell", for: indexPath) as! OrderDishListTableViewCell
        
        if indexPath.row < orderHistoryDishList.count {
            if orderHistoryDishList[indexPath.row].dishType == "veg" {
                cell.vegorNonvegImg.image = UIImage(named: "vegImage")
            } else {
                cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
            }
        } else {
            print("Order history index out of range")
        }
        
        if indexPath.row < orderHistoryDishList.count {
            let quantity = orderHistoryDishList[indexPath.row].quantity
            let dishName = orderHistoryDishList[indexPath.row].dishName
            
            cell.cakeNameLbl.text = (quantity ?? "") + "x " + (dishName ?? "")
            
            if let outletLogoURLString = orderHistoryDishList[indexPath.row].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
                cell.cakeImage.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
            } else {
                cell.cakeImage.image = UIImage(named: "no_image")
            }
            
        } else {
            cell.cakeNameLbl.text = ""
        }
        
//        if orderHistoryAddonList.count != 0 {
//            cell.addOnDish.isHidden = false
//            cell.addonCount.isHidden = false
//            cell.addonCountStack.isHidden = false
//            cell.addonCountStack.visiblity(gone: true, dimension: 20, attribute: .height)
//            cell.addOnDish.text = orderHistoryAddonList[0].addonCart.addonName!
//            cell.addonCount.text = HomeConstant.rupeesSym + orderHistoryAddonList[0].addonCart.addonPrice!
//        } else {
//            cell.addOnDish.isHidden = true
//            cell.addonCount.isHidden = true
//            cell.addonCountStack.isHidden = true
//            cell.addonCountStack.visiblity(gone: true, dimension: 0.0, attribute: .height)
//        }
        
        if indexPath.row == orderHistoryDishList.count - 1 {
            // This is the last row, show the bottomView
            cell.bottomView.isHidden = false
        } else {
            // Hide the bottomView for all other rows
            cell.bottomView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
