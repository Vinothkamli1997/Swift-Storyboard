//
//  NewAddEventViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 06/06/23.
//

import UIKit

class NewAddEventViewController: UIViewController, FirstSectionCollectionCollectionViewCellDelegate {
    
    func eventImageTapped(_ alert: FirstSectionCollectionCollectionViewCell, alertTag: Int) {
        self.isEnable = false
        
        self.addEventTableView.reloadData()
    }
    
    @IBOutlet weak var addEventTableView: UITableView! {
        didSet {
            //Register TableView Cells
//            addEventTableView.register(AddEventHeaderTableViewCell.nib, forCellReuseIdentifier: AddEventHeaderTableViewCell.identifier)
            addEventTableView.register(FirstSectionTableViewCell.nib, forCellReuseIdentifier: FirstSectionTableViewCell.identifier)
            addEventTableView.register(BrowseSectionTableViewCell.nib, forCellReuseIdentifier: BrowseSectionTableViewCell.identifier)
            addEventTableView.register(ThirdSectionTableViewCell.nib, forCellReuseIdentifier: ThirdSectionTableViewCell.identifier)
            addEventTableView.separatorStyle = .none
            addEventTableView.dataSource = self
            addEventTableView.delegate = self
            addEventTableView.backgroundColor = .clear
            addEventTableView.showsVerticalScrollIndicator = false
            addEventTableView.showsHorizontalScrollIndicator = false
            addEventTableView.tableFooterView = UIView()
        }
    }
    
    
    var customerID: String = ""
    var oID: String = ""
    var outletId: String = ""
    var birthdayEventCount: Int = 0
    var anniversaryEventCount: Int = 0
    var eventBirthdayList: [Anniversary] = []
    var eventanniversaryList: [Anniversary] = []
    
    var isEnable = true


    override func viewDidLoad() {
        super.viewDidLoad()
        addEventApi()
    }
    
    func addEventApi() {
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
        let url = URL(string: ApiConstant.ADD_EVENT_API)
        
        let parameters = [
            "customer_id": customerID,
            "outlet_id": outletId,
            "id": oID,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash]
        
        print("AddeEvnt params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(AddEventResponse.self, from: data)
                    
                    print("AddeEvnt welcome res \(response)")
                    
                    self.eventBirthdayList = response.parameters.birthday
                    self.eventanniversaryList = response.parameters.anniversary
                    
                    self.birthdayEventCount = self.eventBirthdayList.count
                    self.anniversaryEventCount = self.eventanniversaryList.count
                    
                    DispatchQueue.main.async {
                        self.addEventTableView.reloadData()
                    }
    
                    self.hideLoader()
                } catch {
                    print("AddeEvnt error res \(error)")
                    self.hideLoader()
                }
            }
        }
    }
}

extension NewAddEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isEnable {
            return 3
        } else {
            return 5
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "FirstSectionTableViewCell", for: indexPath) as! FirstSectionTableViewCell
            
            cell.firstSectionCollectionView.showsHorizontalScrollIndicator = false
            cell.firstSectionCollectionView.layoutIfNeeded()

            cell.context = self
            cell.delegate = self
            cell.selectionStyle = .none
            
            cell.birthdayList = self.eventBirthdayList
            cell.firstSectionCollectionView.reloadData()
            
            cell.eventType = "Birthday"
            cell.headingLbl.text = "Birthday"
                        
            return cell
        } else if indexPath.section == 1 {
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "FirstSectionTableViewCell", for: indexPath) as! FirstSectionTableViewCell
            
            cell.firstSectionCollectionView.showsHorizontalScrollIndicator = false
            cell.firstSectionCollectionView.layoutIfNeeded()

            cell.context = self
            cell.selectionStyle = .none
            cell.anniversaryList = self.eventanniversaryList

            
            cell.firstSectionCollectionView.reloadData()

            cell.headingLbl.text = "Anniversary"
            
            return cell
        } else if indexPath.section == 2 {
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "BrowseSectionTableViewCell", for: indexPath) as! BrowseSectionTableViewCell
            
            return cell
        } else {
            let cell = addEventTableView.dequeueReusableCell(withIdentifier: "ThirdSectionTableViewCell", for: indexPath) as! ThirdSectionTableViewCell
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
          if birthdayEventCount < 4 {
              return 115
          } else {
              return 230
          }
      } else if indexPath.section == 1 {
          if anniversaryEventCount < 4 {
              return 115
          } else {
              return 230
          }
      } else if indexPath.section == 2 {
          if isEnable {
              return 0
          } else {
              return 160
          }
      } else {
          if isEnable {
              return 0
          } else {
              return 270
          }

      }
    }
}
