//
//  BottomViewController.swift
//  EliteCake
//
//  Created by apple on 09/01/23.
//

import UIKit

class BottomViewController: UITabBarController {
    
    var customerID: String = ""
    var oID: String = ""
    var outletId: String = ""
    var totalItemCount: Int = 0
    var newUser: Int = 0
    var cityList: [City] = []
    
    var showAllCategoryList: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(badgeCountAdded(_:)),
                                               name: .badgeCountUpdate,
                                               object: nil)
        
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartShowingApi()
        HomeApi()
        
//        if let outlet_id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
//            outletId = outlet_id
//            HomeApi()
//            cartShowingApi()
//        }
//        else {
//            cityApi()
//        }
    }
    
    deinit {
        // Remove observer on deinit
        NotificationCenter.default.removeObserver(self, name: .badgeCountUpdate, object: nil)
    }
    
    // Cake Detail API
    func cartShowingApi() {
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.CARTSHOWING)
        
        let parameters = [
            "outlet_id": outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID
        ] as [String : Any]
        
        print("CartShowing params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
//                    DispatchQueue.main.async {
//                        showAlert(message: "Api Status Res \(response.statusCode)")
//                    }
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CartShowingResponse.self, from: data)

                    if response.parameters.totalItems != 0 {
                        self.totalItemCount = response.parameters.totalItems
                        print("cart TotalItem \(response.parameters.totalItems)")
                        print("cart TotalItem self \(self.totalItemCount)")
                        
                        DispatchQueue.main.async {
                            self.updateBadgeValue(badge: self.totalItemCount)
                        }
                    }
                } catch {
                    print("cart Showing error res localize \(error)")
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
//                    DispatchQueue.main.async {
//                        showAlert(message: "Api Status Res \(response.statusCode)")
//                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    print("home response \(response)")
                    
                    if response.success {
                        self.showAllCategoryList = response.parameters.category
                    } else {
                        self.showToast(message: "Api Success False")
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("home error res \(error)")
                }
            }
        }
    }
    
    //CityApi
    func cityApi() {
        
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.city)
        
        let parameters = [MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value, MobileRegisterConstant.auth_token: hash]
        
        print("city params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if let error = error {
                print("if error \(error.localizedDescription)")
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    print("Error: \(response.statusCode)")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CityResponse.self, from: data)
                    
                    if response.success {
                        self.cityList = response.parameters.city
                    } else {
                        showAlert(message: response.message)
                    }
                    
                    DispatchQueue.main.async {
                                                
                        if self.cityList.count == 1 {
                            UserDefaults.standard.set(self.cityList[0].outletID, forKey: CityOutletConstant.outlet_id)
                            UserDefaults.standard.set(self.cityList[0].address, forKey: CityOutletConstant.cityName)
                            UserDefaults.standard.set(self.cityList[0].id, forKey: CityOutletConstant.id)
                            self.HomeApi()
                            self.cartShowingApi()
                        }
                    }
                } catch {
                    print("city error res localization \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc private func badgeCountAdded(_ notification: Notification) {
        if let count = notification.userInfo?["count"] as? Int {
            self.totalItemCount = count
            print("badge Count \(self.totalItemCount)")
            updateBadgeValue(badge: self.totalItemCount)
        }
    }

    func updateBadgeValue(badge: Int) {
        DispatchQueue.main.async {
            if let items = self.tabBar.items, items.count >= 4 {
                if badge != 0 {
                    items[3].badgeValue = String(badge)
                } else {
                    items[3].badgeValue = nil
                }
            }
        }
    }
}

extension BottomViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            print("Selected tab index:", selectedIndex)
            
            
            if selectedIndex == 1 {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
                
                if showAllCategoryList.count > 0 {
                    vc.category_ID = showAllCategoryList[0].categoryID
                } else {
                    vc.category_ID = "-1"
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

