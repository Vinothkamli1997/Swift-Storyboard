//
//  ApplyCouponViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/03/23.
//

import UIKit

class ApplyCouponViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var availableCouponLbl: UILabel!
    
    @IBOutlet weak var availableCouponTableView: UITableView! {
        didSet {
            //Register TableView Cells
            availableCouponTableView.register(ApplyCouponTableViewCell.nib, forCellReuseIdentifier: ApplyCouponTableViewCell.identifier)
            availableCouponTableView.separatorStyle = .none
            availableCouponTableView.dataSource = self
            availableCouponTableView.delegate = self
            availableCouponTableView.backgroundColor = .clear
            availableCouponTableView.showsVerticalScrollIndicator = false
            availableCouponTableView.showsHorizontalScrollIndicator = false
            availableCouponTableView.tableFooterView = UIView()
        }
    }
    
    var voucherList: [VoucherList] = []
    var outletId: String = ""
    var customerID: String = ""
    var oID: String = ""
    var voucher_id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        voucherListApi()
        
        titleLbl.text = "Apply Coupon"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        titleLbl.textColor = UIColor.black
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        availableCouponLbl.text = "AVAILABLE COUPON"
        availableCouponLbl.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    //VoucherListApi Api
    func voucherListApi() {
        self.showLoader()
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.VOUCHER_LIST_API)
        
        let parameters = [
            MobileRegisterConstant.auth_token: hash,
            "outlet_id" : outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            "id" : oID
        ] as [String : Any]
        
        print("voucherList paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(VoucherListResponse.self, from: data)
                    
                    print("voucherList res \(response)")
                    if response.parameters != nil {
                        self.voucherList = response.parameters!.voucher
                    } else {
                        showAlert(message: response.message)
                    }
                    
                    DispatchQueue.main.async {
                        self.availableCouponTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    print("voucherList error \(error)")
                    self.hideLoader()
                }
            }
        }
    }
    
    func voucherApplyApi() {
        self.showLoader()
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        
        let url = URL(string: ApiConstant.VOUCHER_APPLY_API)
        
        let parameters = [
            MobileRegisterConstant.auth_token: hash,
            "outlet_id" : outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            "voucher_id" : voucher_id,
            "customer_id" : customerID
        ] as [String : Any]
        
        print("voucherApply paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(VoucherApplyResponse.self, from: data)
                    
                    print("voucherApply res \(response)")
                    
                    DispatchQueue.main.async {
                        if response.success {
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ApplyCouponAnimationViewController") as! ApplyCouponAnimationViewController
                            vc.voucherMsg = response.message
                            
                            UserDefaults.standard.set(response.message, forKey: "Voucher")
                            
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                                                        
                            let dismissalTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                                vc.dismiss(animated: true, completion: nil)
                                self.navigationController?.popViewController(animated: true)
                            }
                        
                        } else {
                            
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "EmptyPopupViewController") as! EmptyPopupViewController
                            
                            vc.message = response.message
                            
                            vc.modalPresentationStyle = .overCurrentContext
                            self.present(vc, animated: false, completion: nil)
                        }
                    }
                    self.hideLoader()
                } catch {
                    print("voucherApply error \(error)")
                    self.hideLoader()

                }
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ApplyCouponViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voucherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = availableCouponTableView.dequeueReusableCell(withIdentifier: "ApplyCouponTableViewCell", for: indexPath) as! ApplyCouponTableViewCell
        
        cell.flatDiscountLbl.text = self.voucherList[indexPath.row].vouchersCode
        cell.discountcontentLbl.attributedText = self.voucherList[indexPath.row].description.htmlAttributedString
        
        cell.discountApplyBtn.tag = indexPath.row
        cell.discountApplyBtn.addTarget(self, action: #selector(applyBtnAction(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let description = self.voucherList[indexPath.row].description
        let attributedText = description.htmlAttributedString
        let contentHeight = heightForAttributedText(attributedText!, width: tableView.frame.width)
        let cellHeight = contentHeight + 70
        
        return cellHeight
    }
    
    private func heightForAttributedText(_ attributedText: NSAttributedString, width: CGFloat) -> CGFloat {
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        let textRect = attributedText.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        let textHeight = ceil(textRect.height)
        
        return textHeight
    }
    
    @objc func applyBtnAction(_ sender: UIButton) {
        let row = sender.tag
        self.voucher_id = voucherList[row].vouchersID
        voucherApplyApi()
    }
}
