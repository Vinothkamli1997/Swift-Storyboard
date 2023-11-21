//
//  RatingViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 17/08/23.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var cakeNameLbl: UILabel!
    @IBOutlet weak var cakeFlavourLbl: UILabel!
    
    @IBOutlet weak var firstBottomView: UIView!
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var secondBottomView: UIView!

    @IBOutlet weak var reviewLbl: UILabel!
    @IBOutlet weak var reviewContentLbl: UITextView!
    
    @IBOutlet weak var submitBtn: UIButton!

    var outlet_id: String = ""
    var customerID: String = ""
    var dishID: String = ""
    var reviewContent: String = ""
    var orderID: String = ""
    var oID: String = ""
    var ratingCount: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTrackApi()
        
        titleLbl.text = "Rating and Review"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = .black
        
        ratingImage.image = UIImage(named: "no_image")
        setShadow(view: ratingImage)
        
        cakeNameLbl.text = "Baby Shower Cake"
        cakeNameLbl.font = UIFont.systemFont(ofSize: 16)
        cakeNameLbl.textColor = .black
        
        cakeFlavourLbl.text = "InFlower Cakes"
        cakeFlavourLbl.font = UIFont.systemFont(ofSize: 12)
        cakeFlavourLbl.textColor = UIColor.gray
        
        // Customize the text view properties
        reviewContentLbl.text = "Enter your text here..."
        reviewContentLbl.textColor = UIColor.black
        reviewContentLbl.font = UIFont.systemFont(ofSize: 16)
        reviewContentLbl.delegate = self
        reviewContentLbl.layer.borderColor = UIColor.gray.cgColor
        reviewContentLbl.layer.borderWidth = 1
        reviewContentLbl.cornerRadius = 10
        
        headingLbl.text = "Did You Like the Taste?"
        headingLbl.textColor = .black
        headingLbl.font = UIFont.systemFont(ofSize: 16)
        
        reviewLbl.text = "Your Review"
        reviewLbl.textColor = .black
        reviewLbl.font = UIFont.systemFont(ofSize: 14)
        
        submitBtn.setTitle("Submmit", for: .normal)
        submitBtn.tintColor = .white
        submitBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        submitBtn.layer.cornerRadius = 15
        setShadow(view: submitBtn)
        
        ratingView.rating = 0
        ratingView.settings.fillMode = .precise
        
        ratingView.didTouchCosmos = { [weak self] rating in
            guard let self = self else { return }
            var formattedRating = String(format: "%.1f", rating)
            
            // If the formatted rating ends with ".0", remove it
            if formattedRating.hasSuffix(".0") {
                formattedRating = String(formattedRating.dropLast(2))
            }
            ratingCount = formattedRating
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        ratingApi()
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
            "order_id" : orderID,
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
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.cakeNameLbl.text = response.parameters.orderHistory[0].orderHasDishDetails[0].dishName!
                            self.cakeFlavourLbl.text = HomeConstant.IN +  response.parameters.orderHistory[0].orderHasDishDetails[0].category.categoryName!
                            
                            if response.parameters.orderHistory[0].orderHasDishDetails[0].dishImage != nil {
                                self.ratingImage.sd_setImage(with: URL(string: response.parameters.orderHistory[0].orderHasDishDetails[0].dishImage!), placeholderImage: UIImage(named: "no_image"))
                            } else {
                                self.ratingImage.image = UIImage(named: "no_image")
                            }
                        }
                    }

                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Order Track Summary error res \(error)")
                }
            }
        }
    }
    
    func ratingApi() {
        
        self.showLoader()
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.ratingAndReview)
        
        let parameters = [
            "outlet_id": outlet_id,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "dish_id": dishID,
            "review": reviewContent,
            "rating": ratingCount,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            "id": oID,
            "order_id": orderID
        ] as [String : Any]
        
        print("Rating params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(RatingAndReviewResponse.self, from: data)
                    print("Rating Response \(response)")
                    
                    if response.success {
                        func textViewDidBeginEditing(_ textView: UITextView) {
                            if self.reviewContentLbl.text == "Enter your text here..." {
                                self.reviewContentLbl.text = ""
                                self.reviewContentLbl.textColor = UIColor.black
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Rating error res \(error)")
                }
            }
        }
    }
}

extension RatingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reviewContentLbl.text == "Enter your text here..." {
            reviewContentLbl.text = ""
            reviewContentLbl.textColor = UIColor.black
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        reviewContent = reviewContentLbl.text
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if reviewContentLbl.text.isEmpty {
            reviewContentLbl.text = "Enter your text here..."
            reviewContentLbl.textColor = UIColor.lightGray
        }
    }
}
