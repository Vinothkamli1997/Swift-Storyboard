//
//  MyFavouritePopupViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/03/23.
//

import UIKit

protocol MyFavPopUpDelegate: AnyObject {
    func noBtnTapped(_ alert: MyFavouritePopupViewController, favAlertTag: Int)
    func yesBtnTapped(_ alert: MyFavouritePopupViewController, favAlertTag: Int)
}

class MyFavouritePopupViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var removeLbl: UILabel!
    
    @IBOutlet weak var firstContentLbl: UILabel!
    @IBOutlet weak var dishNameLabel: UILabel!

    
    @IBOutlet weak var lastContentLbl: UILabel!
    
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var yesBtn: UIButton!
    
    var customerID: String = ""
    weak var delegate: MyFavPopUpDelegate?
    var favAlertTag = 0
    var selectedDishName: String?
    var selectedDishID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }

        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        popupView.backgroundColor = UIColor.white
        popupView.layer.cornerRadius = 20
        setShadow(view: popupView)
        
        trashImageView.image = UIImage(systemName: "trash.fill")
        trashImageView.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        removeLbl.text = "Remove"
        removeLbl.font = UIFont.boldSystemFont(ofSize: 18)
        removeLbl.textAlignment = .center
        removeLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        
        firstContentLbl.text = "Do you want to remove"
        firstContentLbl.font = UIFont.systemFont(ofSize: 14)
        firstContentLbl.textAlignment = .center
        firstContentLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        lastContentLbl.text = "from favourites?"
        lastContentLbl.font = UIFont.systemFont(ofSize: 14)
        lastContentLbl.textAlignment = .center
        lastContentLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        if let dishName = selectedDishName {
            dishNameLabel.text = "'" + dishName + "'"
        } else {
            dishNameLabel.text = ""
        }
        
        dishNameLabel.font = UIFont.systemFont(ofSize: 14)
        dishNameLabel.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        noBtn.setTitle("No", for: .normal)
        noBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        yesBtn.setTitle("Yes", for: .normal)
        yesBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
    }
    
    //FavoriteRemove Api Call
    func FavoriteRemoveApi() {
        self.showLoader()

        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.REMOVEFAVOURITE)
        
        let parameters = [
            "dish_id": selectedDishID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
        
        print("category FavouriteRem params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(CommonResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        self.delegate?.yesBtnTapped(self, favAlertTag: self.favAlertTag)
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("error res \(error)")
                }
            }
        }
    }
    
    @IBAction func noBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.noBtnTapped(self, favAlertTag: favAlertTag)
    }
    
    @IBAction func yesBtnAction(_ sender: UIButton) {
        FavoriteRemoveApi()
    }
}
