//
//  MyFavouriteViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 20/03/23.
//

import UIKit
import Cosmos

class MyFavouriteViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var myFavouriteCollectionView: UICollectionView!
    
    @IBOutlet weak var emptyCartImage: UIImageView!
    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var exploreBtn: UIButton!
    @IBOutlet weak var favEmptyView: UIView!
    
    var favouriteList: [MyFavouriteDish] = []
    
    var customerID: String = ""
    var dish_name: String = ""
    var dishID: String = ""
    var selectedDishID: String = ""
    var oID: String = ""
    var outletId: String = ""
    
    var showAllCategoryList: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myFavouriteCollectionView.register(MyFavouriteCollectionViewCell.nib, forCellWithReuseIdentifier: "MyFavouriteCollectionViewCell")
        myFavouriteCollectionView.dataSource = self
        myFavouriteCollectionView.delegate = self
        myFavouriteCollectionView.showsVerticalScrollIndicator = false
            
        titleLbl.text = "My Favourite"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(named: "TextDarkMode")
        
        emptyCartImage.image = UIImage(named: "online_shop")
        
        exploreBtn.setTitle("Explore", for: .normal)
        exploreBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        exploreBtn.layer.borderWidth = 1.0
        exploreBtn.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        exploreBtn.layer.cornerRadius = 10
        
        emptyLbl.text = "Your Favourite List is Empty"
        emptyLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        contentLbl.text = "Looks like you haven't made your choice yet"
        contentLbl.font = UIFont.boldSystemFont(ofSize: 16)
        contentLbl.textColor = UIColor.lightGray
        contentLbl.numberOfLines = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myFavouriteApi()
        HomeApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func exploreBtnAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
        vc.category_ID = showAllCategoryList[0].categoryID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MyFavourite Api Call
    func myFavouriteApi() {
        self.showLoader()
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.FAVORITEAPI)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
        
        print("viewbycategory params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MyFavouriteResponse.self, from: data)
                    
                    if response.success {
                        DispatchQueue.main.async {
                            self.favouriteList = response.parameters.dish
                            if response.parameters.dish.count != 0 {
                                self.myFavouriteCollectionView.isHidden = false
                                self.favEmptyView.isHidden = true
                            } else {
                                self.myFavouriteCollectionView.isHidden = true
                                self.favEmptyView.isHidden = false
                            }
                        }
                    } else {
                        showAlert(message: response.message)
                    }
                    
                    DispatchQueue.main.async {
                        self.myFavouriteCollectionView.reloadData()
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("my fav error res \(error)")
                }
            }
        }
    }
    
    //FavoriteRemove Api Call
    func FavoriteRemoveApi() {
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.REMOVEFAVOURITE)
        
        let parameters = [
            "dish_id": selectedDishID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
        
        print("my Favourite params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CommonResponse.self, from: data)
                    print("removeFav Response \(response)")
                } catch {
                    print("error res \(error)")
                }
            }
        }
    }
    
    func HomeApi() {
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let outlet_id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = outlet_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.homeScreen)
        
        let parameters = [
            "customer_details_id": customerID,
            "outlet_id": outletId,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("home paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    self.showToast(message: "Status Code Error")
                    DispatchQueue.main.async {
                        showAlert(message: "Api Res \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        if response.success {
                            self.showAllCategoryList = response.parameters.category
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.myFavouriteCollectionView.reloadData()
                    }
                    
                } catch {
                    print("home error res \(error)")
                }
            }
        }
    }

}

extension MyFavouriteViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFavouriteCollectionViewCell", for: indexPath) as? MyFavouriteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.context = self
        
        cell.dishNameLbl.tag = indexPath.row
        
        if let encodedImageUrlString = favouriteList[indexPath.row].dishImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let imageUrl = URL(string: encodedImageUrlString) {
            cell.dishImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
        } else {
            cell.dishImage.image = UIImage(named: "no_image")
        }
        
        if favouriteList[indexPath.row].dishRating == "" {
            cell.ratingView.rating = Double(4)
        } else {
            cell.ratingView.rating = Double(favouriteList[indexPath.row].dishRating)!
        }
        
        cell.dishNameLbl.text = favouriteList[indexPath.row].dishName
        cell.dishFlavourNameLbl.text = HomeConstant.IN + favouriteList[indexPath.row].category.categoryName
        
        if favouriteList[indexPath.row].dishPrice != nil {
            cell.realPriceLbl.text = HomeConstant.rupeesSym + favouriteList[indexPath.row].dishDiscounts!
        }
        
        if favouriteList[indexPath.row].dishDiscounts != nil {
            let price = favouriteList[indexPath.row].dishPrice
            let attributedString = formatPriceWithStrikethrough(price!)
            cell.discountPriceLbl.attributedText = attributedString
        }
        
        cell.discountPercentageLbl.text = favouriteList[indexPath.row].discountPercentage + HomeConstant.percentageSym
    
        if favouriteList[indexPath.row].dishType != nil {
            if  favouriteList[indexPath.row].dishType == "veg" {
                cell.vegNonVegImg.image = UIImage(named: "vegImage")
            } else {
                cell.vegNonVegImg.image = UIImage(named: "nonVegImage")
            }
        }

        
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(favbuttonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc private func favbuttonTapped(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyFavouritePopupViewController") as! MyFavouritePopupViewController
  
        vc.selectedDishName = favouriteList[row].dishName
        vc.selectedDishID = favouriteList[row].dishID
        selectedDishID = favouriteList[row].dishID
        
        
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = favouriteList[indexPath.row].dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width-10)/2
        return CGSize(width: size, height: 260)
    }
}

// Implement the delegate method
extension MyFavouriteViewController: MyFavPopUpDelegate {
    func noBtnTapped(_ alert: MyFavouritePopupViewController, favAlertTag: Int) {
        alert.dismiss(animated: true, completion: nil)
    }
    
    func yesBtnTapped(_ alert: MyFavouritePopupViewController, favAlertTag: Int) {
        alert.dismiss(animated: true, completion: nil)
        myFavouriteApi()
    }
}
