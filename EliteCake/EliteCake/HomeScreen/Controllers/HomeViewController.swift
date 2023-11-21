//
//  HomeViewController.swift
//  EliteCake
//
//  Created by apple on 09/01/23.
//

import UIKit
import Cosmos
import SDWebImage

class HomeViewController: UIViewController, VideoTableViewCellDelegate  {

    func addToCartButtonTapped(for row: Int) {
        self.dismiss(animated: true)
        
        
        let selectedVideo = videoSectinList[row]

        self.videoDishID = selectedVideo.dishID
        self.videoSize = selectedVideo.sizeID
        
        AddToCartApi(videoDishID: videoDishID, videoSize: videoSize)
    }
    
    @IBOutlet var menuTableView: UITableView! {
        didSet {
            //Register TableView Cells
            menuTableView.register(TopHomeHeaderTablecell.nib, forCellReuseIdentifier: TopHomeHeaderTablecell.identifier)
            menuTableView.register(WelcomeCoinTablecell.nib, forCellReuseIdentifier: WelcomeCoinTablecell.identifier)
            menuTableView.register(BannerTableViewCell.nib, forCellReuseIdentifier: BannerTableViewCell.identifier)
            menuTableView.register(FlavourTableviewCell.nib, forCellReuseIdentifier: FlavourTableviewCell.identifier)
            menuTableView.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
            menuTableView.register(NewArrivalTableViewCell.nib, forCellReuseIdentifier: NewArrivalTableViewCell.identifier)
            menuTableView.register(PopularHeaderTableViewCell.nib, forCellReuseIdentifier: PopularHeaderTableViewCell.identifier)
            menuTableView.register(PopularSectionTableViewCell.nib, forCellReuseIdentifier: PopularSectionTableViewCell.identifier)
            menuTableView.register(VideoSectionTableViewCell.nib, forCellReuseIdentifier: VideoSectionTableViewCell.identifier)
            menuTableView.separatorStyle = .none
            menuTableView.dataSource = self
            menuTableView.delegate = self
            menuTableView.backgroundColor = .clear
            menuTableView.showsVerticalScrollIndicator = false
            menuTableView.showsHorizontalScrollIndicator = false
            menuTableView.tableFooterView = UIView()
        }
    }
    
    var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"MapView", bundle: Bundle.main)
    }
    
    //Banner View Sliding Image
    var imageArray = [] as [String]
    var currentPageIndex = 0
    var isScrollingForward = true
    var index = 0
    
    //Get parameter value
    var customerID: String = ""
    var outletId: String = ""
    var oID: String = ""
    var cityName: String = ""
    var videoDishID: String = ""
    var videoSize: String = ""
    var gcmToken: String = ""
    var mobileNumber: String = ""
    
    var checkNewUser: Int?
    var welcomeValues: WelcomeParameters?
    
    var cityList: [City] = []
    var homeResponse: HomeScreenParameters? = nil
    var bannerViewcell: BannerTableViewCell?
    var flavourList: [Cusine] = []
    var categoryList: [Category] = []
    var newArrivalList: [NewArrival] = []
    var popularList: [Popularofweek] = []
    var cusineList: [Cusine] = []
    var showAllCusineList: [Cusine] = []
    var showAllCategoryList: [Category] = []
    var videoSectinList: [Video] = []
    var bannerList: [Banner] = []
    var filterDatas: [Filter] = []
    var filterList: [TagsActive] = []
    
    var scrollTimer: Timer?
    var isUserScrolling = false
    
    var currentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.backgroundColor = .white
        
        if let gcmtoken = UserDefaults.standard.string(forKey: "userID") {
            print("home new user \(gcmtoken)")
            if let intValue = Int(gcmtoken) {
                checkNewUser = intValue
            } else {
                print("Failed to convert '\(gcmtoken)' to an integer")
            }
        }

        if checkNewUser == 1 {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let profilePopupVC = storyboard.instantiateViewController(withIdentifier: "NewUserWelcomeBonusViewController") as! NewUserWelcomeBonusViewController
            
            profilePopupVC.context = self

            profilePopupVC.modalPresentationStyle = .overCurrentContext
            self.present(profilePopupVC, animated: false) {
                UserDefaults.standard.removeObject(forKey: "userID")
            }
        } else {
            print("Home Else part new user")
        }
        
//        forceUpdateApi()
        welcomeApi()
        FilterApi()
        
        if let outlet_id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = outlet_id
            HomeApi()
        }
        else {
            cityApi()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func scrollinsetup() {
        if !isUserScrolling {
            if index < imageArray.count - 1 {
                index = index + 1
            } else {
                index = 0
            }

            // Add a delay of 0.3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.bannerViewcell!.pageControl.numberOfPages = self.imageArray.count
                self.bannerViewcell!.pageControl.currentPage = self.index
                self.bannerViewcell!.bannerCollectionView.isPagingEnabled = false
                self.bannerViewcell!.bannerCollectionView.scrollToItem(at: IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: true)
                self.bannerViewcell!.bannerCollectionView.isPagingEnabled = true
            }

            startBannerAutoScroll()
        }
    }

    
    //DownArrow Naviagte City Outlet Screen
    @objc private func handleImageSelector() {
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "CityListScreen") as! CityListScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func forceUpdateApi() {
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value + MobileRegisterConstant.osType)
        let url = URL(string: ApiConstant.forceUpdate)
        
        // Get app version
        let appVersion = UIApplication.version
        print("App Version \(appVersion)")
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "os_type" : "IOS",
            "current_version" : appVersion
        ]
        
        print("Force Update params \(parameters)")
        
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
                    let response = try decoder.decode(ForceUpdateResponse.self, from: data)
                    print("Force Update \(response)")
                    
                    if response.success {
                        if response.parameters.appVersion.currentVersion > appVersion {
                            DispatchQueue.main.async {
                                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                                let forcePopupVC = storyboard.instantiateViewController(withIdentifier: "ForceUpdateViewController") as! ForceUpdateViewController
                                
                                
                                forcePopupVC.modalPresentationStyle = .overCurrentContext
                                self.present(forcePopupVC, animated: false, completion: nil)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.menuTableView.reloadData()
                    }
                } catch {
                    print("Force Update error res localization \(error.localizedDescription)")
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
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CityResponse.self, from: data)
                    
                    if response.success {
                        self.cityList = response.parameters.city
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.menuTableView.reloadData()
                        
                        if self.cityList.count == 1 {
                            UserDefaults.standard.set(self.cityList[0].outletID, forKey: CityOutletConstant.outlet_id)
                            UserDefaults.standard.set(self.cityList[0].address, forKey: CityOutletConstant.cityName)
                            UserDefaults.standard.set(self.cityList[0].id, forKey: CityOutletConstant.id)
                            self.HomeApi()
                        }
                    }
                } catch {
                    print("city error res localization \(error.localizedDescription)")
                }
            }
        }
    }

    //WelcomeAPI Call
    func welcomeApi() {
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let outlet_id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = outlet_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        let url = URL(string: ApiConstant.welcomeApi)
        
        let parameters = [
            "customer_id": customerID,
            "outlet_id": outletId,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("welcome paramsI/P \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(WelcomeResponse.self, from: data)
                    
                    print("welcome res \(response)")
                    
                    self.welcomeValues = response.parameters
                    
                    DispatchQueue.main.async {
                        self.menuTableView.reloadData()
                    }
                } catch {
                    print("welcomeerror res \(error)")
                }
            }
        }
    }
    
    //HomeAPI Call
    func HomeApi() {
        self.showLoader()
        
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
                    DispatchQueue.main.async {
                        showAlert(message: "Api Status Res \(response.statusCode)")
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(HomeScreenResponse.self, from: data)
                    
                    print("home response \(response)")
                    
                    if response.success {
                        
                    self.homeResponse = response.parameters
                        
                    self.bannerList = response.parameters.banner
                        
                    self.setBannerImag()
                        
                    var flavourList = response.parameters.cusine
                        _ = flavourList.removeFirst()
                    self.flavourList = flavourList
                    
                    //Category Array 0 index remove
                    var categoryList = response.parameters.category
                        _ = categoryList.removeFirst()
                    self.categoryList = categoryList
                    
                    self.showAllCategoryList = response.parameters.category
                    
                    //Cusine Array 0 index remove
                    var cusineList = response.parameters.cusine
                        _ = cusineList.remove(at:0)
                    self.cusineList = cusineList
                    
                    self.showAllCusineList = response.parameters.cusine
                    
                        self.newArrivalList = response.parameters.newArrival!
                        self.popularList = response.parameters.popularofweek!
                        self.videoSectinList = response.parameters.video!
                        
                        for (index, value) in self.newArrivalList.enumerated().reversed() {
                            print("index \(index)")
                            if value.dishes.dishName == "Best Mom" {
                                let welcomeCake = value.dishes.dishID
                                UserDefaults.standard.setValue(welcomeCake, forKey: "WelcomeCake")
                                break
                            } else {
                                print("Banner Else execute")
                            }
                        }
                        
                        print("video count api \(response.parameters.video!.count)")
                        print("video \(String(describing: response.parameters.video))")
                        
                    } else {
                        self.showToast(message: "Api Success False")
                    }
                    
                    DispatchQueue.main.async {
                        self.menuTableView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("home error res \(error)")
                }
            }
        }
    }
    
    //Addtocart Api
    func AddToCartApi(videoDishID: String, videoSize: String) {

        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID)
        
        let url = URL(string: ApiConstant.ADDTOCART)
        
        let parameters = [
            "dish_id": videoDishID,
            "outlet_id": outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID,
            "size" : videoSize,
            "quantity": "1"
        ] as [String : Any]
        print("addtocart params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(AddToCartResponse.self, from: data)
                    
                    print("addtocart response \(response)")
                    
                    if response.success {
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
                            vc.dish_id = self.videoDishID
                            vc.videoScreen = "Video"
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.menuTableView.reloadData()
                    }
                } catch {
                    print("Addtocart error res localize \(error)")
                }
            }
        }
    }
    
    func FilterApi() {
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outletId = id
        }
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.FILTER_API)
        
        let parameters = [
            "outlet_id": outletId,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "id":oID
        ] as [String : Any]
        
        print("FilterScren params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FilterResponse.self, from: data)
                    
                    self.filterDatas = response.parameters.filters
                    
                    DispatchQueue.main.async {
                        self.menuTableView.reloadData()
                    }
                    
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("error res \(error)")
                }
            }
        }
    }
    
    func setBannerImag() {
        homeResponse?.banner.forEach {
            imageArray.append($0.images)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 7 {
            return popularList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "TopHomeHeaderTablecell", for: indexPath) as! TopHomeHeaderTablecell
            
            cell.downArrow.isUserInteractionEnabled = true
            
            cell.downArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageSelector)))
            cell.selectionStyle = .none
            
            cell.eliteCakeLbl.text = homeResponse?.slogan
            cell.forEliteLbl.text = homeResponse?.outletName
            
            //Logo Image Null Check
            if let logoUrl = homeResponse?.logo, let url = URL(string: logoUrl) {
                cell.profileImg.sd_setImage(with: url, placeholderImage: UIImage(named: "no_image"))
                cell.profileImg.layer.cornerRadius = 35
                cell.profileImg.clipsToBounds = true
            }
            
            if let city_Name = UserDefaults.standard.string(forKey: CityOutletConstant.cityName){
                cell.locationLbl.text = city_Name
                cell.cityOutletStack.isHidden = true
                cell.locationLbl.isHidden = true
                cell.locationImg.isHidden = true
                cell.downArrow.isHidden = true
            } else {
                if cityList.count == 1 {
                    cell.cityOutletStack.isHidden = true
                    cell.locationLbl.isHidden = true
                    cell.locationImg.isHidden = true
                } else {
                    cell.locationLbl.text = "Please Select Outlet"
                }
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectCity))
            cell.locationLbl.addGestureRecognizer(tapGesture)
            
            let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(headerImageTapped))
            cell.profileImg.isUserInteractionEnabled = true
            cell.profileImg.addGestureRecognizer(imageTapGesture)
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "WelcomeCoinTablecell", for: indexPath) as! WelcomeCoinTablecell
            cell.selectionStyle = .none
            
            if let welcomeValues = welcomeValues,
               let balanceCoin = welcomeValues.balanceCoin?.stringValue {
                cell.welcomeCoinsLbl.text = "You Have " + balanceCoin + " SUPER COINS"
            }
            
            return cell
            
        } else if indexPath.section == 2 {
            bannerViewcell = (menuTableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell)
            
            bannerViewcell!.bannerCollectionView.showsHorizontalScrollIndicator = false
            bannerViewcell?.bannerCollectionView.isPagingEnabled = true
            bannerViewcell!.selectionStyle = .none
            
            if imageArray.count > 0 {
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollinsetup), userInfo: nil, repeats: true)
                bannerViewcell!.bannerCollectionView.dataSource = self
                bannerViewcell!.bannerCollectionView.delegate = self
                bannerViewcell!.pageControl.numberOfPages = imageArray.count
                bannerViewcell!.pageControl.currentPage = index
            }
            
            return bannerViewcell!
            
        } else if indexPath.section == 3 {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "FlavourTableviewCell", for: indexPath) as! FlavourTableviewCell
            cell.categoryLbl.text = HomeConstant.viewbyFlavour
            cell.flavourCellDatas = flavourList
            cell.showAllBtn.addTarget(self, action: #selector(showAllBtnAction(_:)), for: .touchUpInside)
            cell.flavourCollectionView.reloadData()
            cell.context = self
            cell.flavourCollectionView.showsHorizontalScrollIndicator = false
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 4  {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            cell.categoryLbl.text = HomeConstant.viewbyCategory
            cell.categoryCellDatas = categoryList
            cell.showAllBtn.addTarget(self, action: #selector(categoryShowAllBtnAction(_:)), for: .touchUpInside)
            cell.categoryCollectionView.reloadData()
            cell.context = self
            cell.categoryCollectionView.showsHorizontalScrollIndicator = false
            cell.showAllBtn.isHidden = false
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 5 {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "NewArrivalTableViewCell", for: indexPath) as! NewArrivalTableViewCell
            cell.newArrivalDatas = newArrivalList
            cell.context = self
            cell.arrivalCollectionView.reloadData()
            cell.arrivalCollectionView.showsHorizontalScrollIndicator = false
            cell.selectionStyle = .none
            return cell
            
        } else if indexPath.section == 6 {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "PopularHeaderTableViewCell", for: indexPath) as! PopularHeaderTableViewCell
            
            if popularList.count == 0 {
                cell.visiblity(gone: true, dimension: 0.0, attribute: .height)
                cell.popularLbl.isHidden = true
            } else {
                cell.popularLbl.isHidden = false
            }
            
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.section == 7 {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "PopularSectionTableViewCell", for: indexPath) as! PopularSectionTableViewCell
            
            cell.selectionStyle = .none
            cell.trendingLbl.text = popularList[indexPath.row].dishes.message
            cell.cakeNameLbl.text = popularList[indexPath.row].dishes.dishName
            cell.subNameLbl.text = HomeConstant.IN + popularList[indexPath.row].dishes.category.categoryName
            cell.offerPrice.text = HomeConstant.rupeesSym + popularList[indexPath.row].dishes.dishDiscounts
                        
            let priceString = HomeConstant.rupeesSym + popularList[indexPath.row].dishes.dishPrice
            let attributedString = NSAttributedString(string: priceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.realPrice.attributedText = attributedString
            
            cell.discountLbl.text = popularList[indexPath.row].dishes.discountPercentage + HomeConstant.percentageSym
            cell.ratingView.rating = Double(popularList[indexPath.row].dishes.dishRating)!
            cell.poundLbl.text = "(" + popularList[indexPath.row].dishes.dishsizes[0].sizeDetailsSize.sizeName + popularList[indexPath.row].dishes.dishsizes[0].sizeDetailsSize.unit!.unitName + ")"
            
            cell.landingPriceLbl.text = HomeConstant.rupeesSym + popularList[indexPath.row].dishes.landingPrice
            
            if popularList[indexPath.row].dishes.dishType == "veg" {
                cell.vegornonvegImg.image = UIImage(named: "vegImage")
            } else {
                cell.vegornonvegImg.image = UIImage(named: "nonVegImage")
            }
            
            if indexPath.row % 2 == 0 {
                //Right Side Image Hide
                let viewWidth:CGFloat = 0
                let viewWidth2:CGFloat = 80
                cell.rightimgView?.visiblity(gone: true, dimension: viewWidth, attribute: .width)
                cell.leftimgView?.visiblity(gone: false, dimension: viewWidth2, attribute: .width)
                cell.leftImage.sd_setImage(with: URL(string: popularList[indexPath.row].dishes.dishImage), placeholderImage: UIImage(named: "no_image"))
            } else {
                //Left Side Image Hide
                let viewWidth:CGFloat = 0
                let viewWidth1:CGFloat = 80
                cell.leftimgView?.visiblity(gone: true, dimension: viewWidth, attribute: .width)
                cell.rightimgView?.visiblity(gone: false, dimension: viewWidth1, attribute: .width)
                cell.rigntImage.sd_setImage(with: URL(string: popularList[indexPath.row].dishes.dishImage), placeholderImage: UIImage(named: "no_image"))
            }
            
            cell.orderBtn.tag = indexPath.row
            cell.orderBtn.addTarget(self, action: #selector(popularOrderBtn(_:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "VideoSectionTableViewCell", for: indexPath) as! VideoSectionTableViewCell
            
            cell.videoList = self.videoSectinList
            cell.context = self
            cell.delegate = self
            cell.videoSectionCollectionView.reloadData()
            return cell
        }
    }
    
    //ordernowBtn Action
    @objc func selectCity(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CityListScreen") as! CityListScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //ordernowBtn Action
    @objc func popularOrderBtn(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
        vc.dish_id = popularList[row].dishes.dishID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //ordernowBtn Action
    @objc func showAllBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllViewController") as! ShowAllViewController
        vc.cusine_id = showAllCusineList[0].cuisineID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func categoryShowAllBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
        vc.category_ID = showAllCategoryList[0].categoryID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func headerImageTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        
        // Push the target view controller onto the navigation stack
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //popular cell navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
            vc.screenType = "Wallet"
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 7 {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
            vc.dish_id = popularList[indexPath.row].dishes.dishID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //Cell Heights
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else if indexPath.section == 1 {
            return 90
        } else if indexPath.section == 2 {
            return 120
        } else if indexPath.section == 3 {
            
            if flavourList.count == 0 {
                return 0
            } else {
                return 210
            }
        } else if indexPath.section == 4 {
            if categoryList.count == 0 {
                return 0
            } else {
                return 210
            }
        } else if indexPath.section == 5 {
            if newArrivalList.count == 0 {
                return 0
            } else {
                return 400
            }
        } else if indexPath.section == 6 {
            return 40
        } else if indexPath.section == 7 {
            if popularList.count == 0 {
                return 0
            } else {
                return 200
            }
        } else {
            return 390
            
        }
    }
}

//BannerTableView Cell
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let urlString = imageArray[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image")
            cell.sliderImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
        
        cell.sliderImage.tag = indexPath.row
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.sliderImage.isUserInteractionEnabled = true
        cell.sliderImage.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height))
    }
    
    @objc func imageTapped(_ tapgesture: UITapGestureRecognizer) {
        if let imageView = tapgesture.view as? UIImageView {
            // Get the tag of the tapped UIImageView, which corresponds to the item index
            let itemIndex = imageView.tag
            
            // Create an indexPath with the item index and section 0 (or the relevant section)
            let indexPath = IndexPath(item: itemIndex, section: 0)
            
            if bannerList[itemIndex].bannerTitle == "Welcome" {

                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
                
                if let cake = UserDefaults.standard.string(forKey: "WelcomeCake") {
                    vc.dish_id = cake
                } else {
                    print("Banner Else execute")
                }
                self.navigationController?.pushViewController(vc, animated: true)
            } else if bannerList[itemIndex].bannerTitle == "Add Events" {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if bannerList[itemIndex].bannerTitle == "Premium" {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
                
                UserDefaults.standard.removeObject(forKey: "SelectedTagIDs")
                
                let tagIDsToStore = ["1613"]
                
                UserDefaults.standard.set(tagIDsToStore, forKey: "SelectedTagIDs")
                
                let tagCatIDsToStore = ["665"]

                UserDefaults.standard.set(tagCatIDsToStore, forKey: "SelectedCatTagIDs")

                // Synchronize UserDefaults
                UserDefaults.standard.synchronize()
                
                vc.category_ID = showAllCategoryList[0].categoryID

                self.navigationController?.pushViewController(vc, animated: true)
            } else if bannerList[itemIndex].bannerTitle == "Basic" {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
                
                UserDefaults.standard.removeObject(forKey: "SelectedTagIDs")

                let tagIDsToStore = ["1612"]
                UserDefaults.standard.set(tagIDsToStore, forKey: "SelectedTagIDs")
                
                let tagCatIDsToStore = ["665"]

                UserDefaults.standard.set(tagCatIDsToStore, forKey: "SelectedCatTagIDs")

                // Synchronize UserDefaults
                UserDefaults.standard.synchronize()
                
                vc.category_ID = showAllCategoryList[0].categoryID

                self.navigationController?.pushViewController(vc, animated: true)
            } else if bannerList[itemIndex].bannerTitle == "Elite" {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ShowAllCategoryViewController") as! ShowAllCategoryViewController
                
                UserDefaults.standard.removeObject(forKey: "SelectedTagIDs")

                let tagIDsToStore = ["1614"]
                UserDefaults.standard.set(tagIDsToStore, forKey: "SelectedTagIDs")
                
                let tagCatIDsToStore = ["665"]

                UserDefaults.standard.set(tagCatIDsToStore, forKey: "SelectedCatTagIDs")

                // Synchronize UserDefaults
                UserDefaults.standard.synchronize()
                
                vc.category_ID = showAllCategoryList[0].categoryID

                self.navigationController?.pushViewController(vc, animated: true)
            } else if bannerList[itemIndex].bannerTitle == "Wallet" {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if bannerList[itemIndex].bannerTitle == "referal" {
                let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ReferalViewController") as! ReferalViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func startBannerAutoScroll() {
        // Invalidate the existing timer to avoid multiple timers running simultaneously
        scrollTimer?.invalidate()
        
        // Schedule a new timer with a delay of 3 seconds (adjust as needed)
        scrollTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollinsetup), userInfo: nil, repeats: true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // User-initiated scrolling
        isUserScrolling = true
        
        // Invalidate the timer when the user starts dragging
        scrollTimer?.invalidate()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Restart the timer when the user stops dragging (if not decelerating)
//        if !decelerate {
            isUserScrolling = false
            startBannerAutoScroll()
//        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Restart the timer when deceleration ends (if not dragging)
        if !scrollView.isDragging {
            isUserScrolling = false
            startBannerAutoScroll()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerViewcell?.bannerCollectionView {
            // Ensure that bannerViewcell and its bannerCollectionView are not nil
            guard let bannerViewcell = bannerViewcell, let bannerCollectionView = bannerViewcell.bannerCollectionView else {
                return
            }
            
            // Calculate the current page based on the content offset
            let pageWidth = bannerCollectionView.frame.size.width
            
            let currentPage = Int((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
            
            if currentPage != index && !isUserScrolling {
                // Update the index and page control when the current page changes
                index = currentPage
                bannerViewcell.pageControl.currentPage = index
            }
        }
    }
}


