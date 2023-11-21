//
//  OrderHistoryNewTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 09/10/23.
//

import UIKit

class OrderHistoryNewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView1: UIView!
    
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
    
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var callBtn: UIView!
    @IBOutlet weak var callUsLbl: UILabel!

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dishPriceLbl: UILabel!
    @IBOutlet weak var trailingBtn: UIButton!
    
    var orderHistoryDishList: [OrderHasDishDetail] = []
    var orderHistoryAddonList: [TrackAddon] = []
    var orderHistoryDetails: [OrderHistorys] = []
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
        DispatchQueue.main.async {
            self.setupTableView()
        }
        
        designSetUp()
        
        self.orderDishListTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

        let count = orderHistoryDishList.count
              
        self.innerTableViewHeight.constant = CGFloat(80 * count)
        
        DispatchQueue.main.async {
            self.orderDishListTableView.reloadData()
        }
    }
        
    func designSetUp() {
        
        bgView1.backgroundColor = UIColor.white
        bgView1.layer.cornerRadius = 20
        setShadow(view: bgView1)
        
        titleLbl.text = "Elite Cakes"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        setShadow(view: cakeImage)
        
        dateTimeLbl.font = UIFont.systemFont(ofSize: 12)
        dateTimeLbl.textColor = UIColor.gray
        
        dateLbl.font = UIFont.systemFont(ofSize: 12)
        dateLbl.textColor = UIColor.black
        
        statusLbl.font = UIFont.boldSystemFont(ofSize: 14)
        statusLbl.textColor = .black
        statusLbl.textAlignment = .center
        
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
        
        callView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        callView.layer.cornerRadius = 10
        setLightShadow(view: callView)
        
        callBtn.tintColor = UIColor.white
        
        callUsLbl.text = "Call us"
        callUsLbl.textColor = UIColor.white
        callUsLbl.font = UIFont.systemFont(ofSize: 14)
        
        dishPriceLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        trailingBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }
    
    func setupTableView() {
//        orderDishListTableView.register(OrderHistoryHeaderCell.nib, forHeaderFooterViewReuseIdentifier: OrderHistoryHeaderCell.identifier)
//        orderDishListTableView.register(MultiAddOnTableViewCell.nib, forCellReuseIdentifier: MultiAddOnTableViewCell.identifier)
        
        //        orderDishListTableView.register(OrderDishListTableViewCell.nib, forCellReuseIdentifier: OrderDishListTableViewCell.identifier)
                
        orderDishListTableView.register(NewCartDishListDetailsTableViewCell.nib, forCellReuseIdentifier: NewCartDishListDetailsTableViewCell.identifier)
        
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let tableView = object as? UITableView, tableView == orderDishListTableView {
            if keyPath == "contentSize", let newvalue = change?[.newKey] as? CGSize {
                self.innerTableViewHeight.constant = newvalue.height
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

extension OrderHistoryNewTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("orderHistoryDishList.count \(orderHistoryDishList.count)")
        return orderHistoryDishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderDishListTableView.dequeueReusableCell(withIdentifier: "NewCartDishListDetailsTableViewCell", for: indexPath) as! NewCartDishListDetailsTableViewCell
        
        cell.selectionStyle = .none
        
        print("orderHistoryDishList.count1111 \(orderHistoryDishList.count)")

        if orderHistoryDishList.count > 0 {
            if orderHistoryDishList[indexPath.row].dishType == "veg" {
                cell.vegorNonvegImg.image = UIImage(named: "vegImage")
            } else {
                cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
            }
        } else {
            print("Order history index out of range")
        }
        
        if orderHistoryDishList.count > 0 {
            let quantity = orderHistoryDishList[indexPath.row].quantity
            let dishName = orderHistoryDishList[indexPath.row].dishName
            
            print("orderHistoryDishList.dishName \(orderHistoryDishList.count)")

            
            cell.cakeNameLbl.text = (quantity ?? "") + "x " + (dishName ?? "")
            
            if let outletLogoURLString = orderHistoryDishList[indexPath.row].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
                cell.cakeImage.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
            } else {
                cell.cakeImage.image = UIImage(named: "no_image")
            }
            
        } else {
            print("Execute Else ")
            cell.cakeNameLbl.text = ""
        }

        if orderHistoryDishList[0].addon!.count > 0 {
            cell.addOnCount.text = "\(orderHistoryDishList[0].addon!.count)" + "Add-ons Added"
            cell.showLbl.text = "Show"
        } else {
            cell.addOnCount.text = ""
            cell.showLbl.text = ""
        }
        
        cell.showLbl.tag = indexPath.row
        let addOndishPriceTapGesture = UITapGestureRecognizer(target: self, action: #selector(addOnDishPriceViewTapped(_:)))
        cell.showLbl.isUserInteractionEnabled = true
        cell.showLbl.addGestureRecognizer(addOndishPriceTapGesture)
        
        DispatchQueue.main.async {
            self.orderDishListTableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OrderHistoryHeaderCell.identifier) as? OrderHistoryHeaderCell else {
    //            return UIView()
    //        }
    //
    //        cell.backgroundColor = .clear
    //
//            if section < orderHistoryDishList.count {
//                if orderHistoryDishList[section].dishType == "veg" {
//                    cell.vegorNonvegImg.image = UIImage(named: "vegImage")
//                } else {
//                    cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
//                }
//            } else {
//                print("Order history index out of range")
//            }
    //
//            if section < orderHistoryDishList.count {
//                let quantity = orderHistoryDishList[section].quantity
//                let dishName = orderHistoryDishList[section].dishName
//    
//                cell.cakeNameLbl.text = (quantity ?? "") + "x " + (dishName ?? "")
//    
//                if let outletLogoURLString = orderHistoryDishList[section].dishImage, let outletLogoURL = URL(string: outletLogoURLString) {
//                    cell.cakeImage.sd_setImage(with: outletLogoURL, placeholderImage: UIImage(named: "no_image"))
//                } else {
//                    cell.cakeImage.image = UIImage(named: "no_image")
//                }
//    
//            } else {
//                cell.cakeNameLbl.text = ""
//            }
    //
    //        return cell
    //    }
    
    
    @objc func addOnDishPriceViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let label = gestureRecognizer.view as? UILabel,
           label.tag < orderHistoryDetails.count {

            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderSummaryViewController") as! TrackOrderSummaryViewController
            vc.order_id = orderHistoryDetails[label.tag].orderID!
            context?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


