//
//  FilterViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/03/23.
//

import UIKit

class FilterViewController: UIViewController, clearFilterDelegate {
    func clearAllFilter() {
        self.dismiss(animated: true, completion: nil)
        
        print("Clear Button Tapped")
        
        UserDefaults.standard.removeObject(forKey: "SelectedTagIDs")
        UserDefaults.standard.removeObject(forKey: "SelectedCatTagIDs")

        selectedTagIDs.removeAll()
        SelectedCatTagIDs.removeAll()

        // Reset counts dictionary to initial values
        counts = [:]

        // Clear the filter counts in UserDefaults
        UserDefaults.standard.removeObject(forKey: "SelectedFilterCounts")

        clearFilter()
    }
    
    // Define the delegate protocol
    weak var delegate: FilterViewControllerDelegate?
    
    @IBOutlet weak var filterTableView: UITableView! {
        didSet {
            //Register TableView Cells
            filterTableView.register(FilterTableViewCell.nib, forCellReuseIdentifier: FilterTableViewCell.identifier)
            filterTableView.separatorStyle = .none
            filterTableView.dataSource = self
            filterTableView.delegate = self
            filterTableView.backgroundColor = .clear
            filterTableView.showsVerticalScrollIndicator = false
            filterTableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var filterValueTableView: UITableView! {
        didSet {
            //Register TableView Cells
            filterValueTableView.register(FilterListTableViewCell.nib, forCellReuseIdentifier: FilterListTableViewCell.identifier)
            filterValueTableView.separatorStyle = .none
            filterValueTableView.dataSource = self
            filterValueTableView.delegate = self
            filterValueTableView.backgroundColor = .clear
            filterValueTableView.showsVerticalScrollIndicator = false
            filterValueTableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    var customer_ID: String = ""
    var oID: String = ""
    var outlet_id: String = ""
    var tags_id: String = ""
    var tag_category_id: String = ""
    var isChecked = false
    var notApply: Bool = true
    var filterCount: String = ""
    
    var selectedIndex: Int = 0
    var selected_filter_Category_id: String = ""
    var isFirstTinme: Bool = true
    var setClearFilter: Bool = false
    
    var filterDatas: [Filter] = []
    var filterList: [TagsActive] = []
    var fetchFilterDatas: FilterFetchParameters?
    
    var flavourCusine: FlavourCusineViewController?
    
    var lastSelectedIndex: IndexPath?
    var counts: [String: Int] = [:]
    var idCounts: [String: Int] = [:] // Property to store the counts
    var filterCounts: [String: Int] = [:]
    var selectedTagsCounts: [String: Int] = [:]
    
    // Arrays to store the initial state of selected tags and category tags
    var initialSelectedTagIDs: [String] = []
    var initialSelectedCatTagIDs: [String] = []
    var categoryFilterCounts: [String: [String: Int]] = [:]

    
    var selectedTagIDs: [String] {
         get {
             return UserDefaults.standard.array(forKey: "SelectedTagIDs") as? [String] ?? []
         }
         set {
             UserDefaults.standard.set(newValue, forKey: "SelectedTagIDs")
             UserDefaults.standard.synchronize()
         }
     }
    
    var SelectedCatTagIDs: [String] {
         get {
             return UserDefaults.standard.array(forKey: "SelectedCatTagIDs") as? [String] ?? []
         }
         set {
             UserDefaults.standard.set(newValue, forKey: "SelectedCatTagIDs")
             UserDefaults.standard.synchronize()
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customer_ID = customer_id
        }
        
        FilterApi()
//        CheckFilterApi()
        
        selectedIndex = 0
        
        backBtn.setImage(UIImage(named: "Chevron_Right"), for: .normal)
        backBtn.tintColor = UIColor.black
        
        okBtn.setTitle("Apply Filter", for: .normal)
        okBtn.tintColor = UIColor.white
        okBtn.backgroundColor = UIColor.black
        okBtn.layer.cornerRadius = 10
        okBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setShadow(view: okBtn)
        
        filterLbl.text = "Filter"
        filterLbl.font = UIFont.boldSystemFont(ofSize: 18)
        filterLbl.textColor = UIColor.black
        
        clearBtn.setTitle("Reset", for: .normal)
        clearBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        clearBtn.tintColor = UIColor.black
        clearBtn.layer.borderColor = UIColor.gray.cgColor
        clearBtn.layer.borderWidth = 1
        clearBtn.layer.cornerRadius = 10
        
        initialSelectedTagIDs = UserDefaults.standard.array(forKey: "SelectedTagIDs") as? [String] ?? []
        initialSelectedCatTagIDs = UserDefaults.standard.array(forKey: "SelectedCatTagIDs") as? [String] ?? []

        // Initialize the selected tags and category tags arrays with the initial state
        selectedTagIDs = initialSelectedTagIDs
        SelectedCatTagIDs = initialSelectedCatTagIDs
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)

         // Calculate counts when entering the view controller
//         calculateTagCounts()
     }
    
    @IBAction func clearBtnAction(_ sender: UIButton) {        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ClearFilterPopUpViewController") as! ClearFilterPopUpViewController
        vc.context = self
        vc.clearDelegate = self
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        notApply = false

        if selectedTagIDs != initialSelectedTagIDs || SelectedCatTagIDs != initialSelectedCatTagIDs {
            // Changes were made, discard them and pop the view controller
            selectedTagIDs = initialSelectedTagIDs
            selectedTagIDs = initialSelectedCatTagIDs
        }
        
        if setClearFilter {
            selectedTagIDs = []
            selectedTagIDs = []
        }

        // Always pop the view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterBtnAction(_ sender: UIButton) {
        
//        filterFetchApi()
        
        notApply = false

        saveSelectedTagIDs(tagIDs: selectedTagIDs, tagCatID: SelectedCatTagIDs)

        if let viewControllers = self.navigationController?.viewControllers {
               for viewController in viewControllers {
                   if let showAllVC = viewController as? ShowAllViewController {
                       showAllVC.isLoading = true
                   }

                   if let anotherVC = viewController as? ShowAllCategoryViewController {
                       anotherVC.isLoading = false
                   }
                   
                   if let categoryVC = viewController as? CategoryDishesViewController {
                       categoryVC.isLoading = true
                   }
                   
                   if let falvourVC = viewController as? FlavourCusineViewController {
                       falvourVC.isLoading = true
                   }
               }
               
               // Pop back to the previous view controller
               self.navigationController?.popViewController(animated: true)
           }
    }
    
    func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    //Filter Api Call
    func FilterApi() {
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.id){
            oID = id
        }
        
        if let id = UserDefaults.standard.string(forKey: CityOutletConstant.outlet_id){
            outlet_id = id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customer_ID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.FILTER_API)
        
        let parameters = [
            "outlet_id": outlet_id,
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customer_ID,
            "id":oID
        ] as [String : Any]
        
        print("FilterScren params \(parameters)")
        
        if isFirstTinme {
            self.showLoader()
        } else {
            self.hideLoader()
        }
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    
                    let response = try decoder.decode(FilterResponse.self, from: data)
                    
                    
                    if response.success {
                        
                        self.filterDatas = response.parameters.filters
                        
                        for (index, value) in self.filterDatas.enumerated().reversed() {
                            if value.lastlySelected == 1 {
                                print("Last selected value is 1 \(value.tagsActive)")
                                print("Index path: Section: 0, Row: \(index)")
                                
                                self.selectedIndex = index
                                break
                            }
                        }

                        
                        if let selectedIndex = self.filterDatas.firstIndex(where: { $0.lastlySelected == 1 }) {
                                self.selectedIndex = selectedIndex
                        } else {
                            // If no category has lastlySelected = 1, set selectedIndex to 0
                            self.selectedIndex = 0
                        }
                    
                    if self.filterDatas.count > 0 {
                        self.selected_filter_Category_id = self.filterDatas[self.selectedIndex].tagCategoryID
                        self.filterList = response.parameters.filters[self.selectedIndex].tagsActive
                    }
                }
                    
                    DispatchQueue.main.async {
                        self.filterTableView.reloadData()
                        self.filterValueTableView.reloadData()
                    }
                    
                    self.hideLoader()
                    
                } catch {
                    
                    self.hideLoader()
                    print("error res \(error)")
                    
                }
            }
        }
    }
    
    //CheckFilter Api Call
    func CheckFilterApi() {
        
        let hash = md5(string: ApiConstant.salt_key + customer_ID)
        let url = URL(string: ApiConstant.CHECKFILTER_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customer_ID,
            "tag_category_id": selected_filter_Category_id,
            "tags_id": tags_id
        ] as [String : Any]
        
        print("checkFIlter params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    
                    let response = try decoder.decode(FilterCheckResponse.self, from: data)
                    
                    print("checkFIlter Res \(response)")
                    
                    DispatchQueue.main.async {
                        self.FilterApi()
                    }
                } catch {
                    print("error res \(error)")
                }
            }
        }
    }
    
    //ClearFilter Api Call
    func clearFilter() {
        
        let hash = md5(string: ApiConstant.salt_key + customer_ID)
        let url = URL(string: ApiConstant.CLEAR_FILTER_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customer_ID
        ] as [String : Any]
        
        print("RemoveFilter params \(parameters)")

        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    
                    let response = try decoder.decode(FilterCheckResponse.self, from: data)
                    
                    print("Clear filter Res \(response)")

//                    self.isFirstTinme = false
//
//                    DispatchQueue.main.async {
//                        self.FilterApi()
//                    }
                    
                    
                    if response.success {
                        self.setClearFilter = true
                    }
                    
                    DispatchQueue.main.async {
                        self.filterTableView.reloadData()
                        self.filterValueTableView.reloadData()
                    }
                    
                } catch {
                    print("error res \(error)")
                }
            }
        }
    }
    
    //RemoveFilter Api Call
    func removeFilter() {
        
        let hash = md5(string: ApiConstant.salt_key + customer_ID)
        let url = URL(string: ApiConstant.REMOVE_FILTER_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customer_ID,
            "tag_category_id": selected_filter_Category_id,
            "tags_id": tags_id
        ] as [String : Any]
        
        print("removeFiter params \(parameters)")

        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    
                    let response = try decoder.decode(FilterCheckResponse.self, from: data)
                    
                    print("clear filter Res \(response)")
                                        
                    DispatchQueue.main.async {
                        self.FilterApi()
                    }
                } catch {
                    print("error res \(error)")
                }
            }
        }
    }
    
    func filterFetchApi() {
        
        let hash = md5(string: ApiConstant.salt_key + customer_ID)
        let url = URL(string: ApiConstant.FILTER_FETCH_API)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customer_ID
        ] as [String : Any]
        
        print("fetchFiter params \(parameters)")

        makeAPICall(url: url!, method: "POST", parameters: parameters) { [self] (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    
                    let response = try decoder.decode(FilterFetchResponse.self, from: data)
                    
                    print("fetchFilter Api res \(response)")
                    
                    
                    var fetchFilter_tag_id: [TagID] = []
                    var fetchFilter_tag_Category_id: [TagCategoryID] = []

                    if response.parameters != nil {
                        fetchFilter_tag_id = response.parameters!.tagID
                        fetchFilter_tag_Category_id = response.parameters!.tagCategoryID
                    }

                    DispatchQueue.main.async {
                        let data = (tagCategoryIDs: fetchFilter_tag_Category_id, tagIDs: fetchFilter_tag_id)
                        self.delegate?.FilterViewControllerDidFinish(with: data)
                        self.navigationController?.popViewController(animated: true)
                    }
                } catch {
                    print("error res \(error)")
                }
            }
        }
    }
    
    func calculateTagCounts() {
            if let storedTagIDs = UserDefaults.standard.array(forKey: "SelectedCatTagIDs") as? [String] {
                // Clear previous counts
                idCounts.removeAll()

                // Loop through the stored IDs and count their occurrences
                for id in storedTagIDs {
                    if let count = idCounts[id] {
                        idCounts[id] = count + 1
                    } else {
                        idCounts[id] = 1
                    }
                }

                // Reload the table view to update the counts in cells
                filterTableView.reloadData()
            }
        }
}


extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == filterTableView {
            return filterDatas.count
        } else {
            return filterList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == filterTableView {
            let cell = filterTableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
            
            cell.filterNameLbl.text = filterDatas[indexPath.row].tagCategoryName
                        
            if indexPath.row == selectedIndex {
                cell.bgView.backgroundColor = UIColor.white
            } else {
                cell.bgView.backgroundColor = UIColor(named: "LightGray")
            }
            
            // get count
            // Assuming filterDatas[indexPath.row].tagCategoryID is the target tagCategoryID
            let targetTagCategoryID = filterDatas[indexPath.row].tagCategoryID

            if let storedTagIDs = UserDefaults.standard.array(forKey: "SelectedCatTagIDs") as? [String] {
                // Create a dictionary to store the counts of each unique ID
                var idCounts: [String: Int] = [:]

                // Loop through the stored IDs and count their occurrences
                for id in storedTagIDs {
                    if let count = idCounts[id] {
                        idCounts[id] = count + 1
                    } else {
                        idCounts[id] = 1
                    }
                }

                // Check if the target tagCategoryID exists in the counts dictionary
                if let count = idCounts[targetTagCategoryID], count > 0 {
                    // Show the filter count label if count is greater than zero
                    cell.filterCountLbl.isHidden = false
                    cell.filterCountLbl.text = "(\(count))"
                } else {
                    // Hide the filter count label if count is zero or if the tagCategoryID is not found
                    cell.filterCountLbl.isHidden = true
                }
            } else {
    
                print("No stored delete Tag IDs found.")
                cell.filterCountLbl.isHidden = true
                
            }
                                
            return cell
            
        } else {
            let filterListCell = filterValueTableView.dequeueReusableCell(withIdentifier: "FilterListTableViewCell", for: indexPath) as! FilterListTableViewCell
            
            filterListCell.filterListLbl.text = filterList[indexPath.row].tagsName
            
                if selectedTagIDs.contains(filterList[indexPath.row].tagsID) {
                    filterListCell.checkBoxBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                    filterList[indexPath.row].isChecked = 1
                } else {
                    filterListCell.checkBoxBtn.setImage(UIImage(systemName: "squareshape"), for: .normal)
                    filterList[indexPath.row].isChecked = 0
                }

            filterListCell.checkBoxBtn.tag = indexPath.row
            filterListCell.checkBoxBtn.addTarget(self, action: #selector(checkBoxAction(sender:)), for: .touchUpInside)
            
            return filterListCell
        }
    }
    
    func filledHeart(sender: UIButton, isFavorite: Int) {
        let systemImageName = isFavorite == 1 ? "checkmark.square.fill" : "squareshape"
        let systemImage = UIImage(systemName: systemImageName)
        let tintedImage = systemImage?.withTintColor(UIColor(hexFromString: ColorConstant.PRIMARYCOLOR))
        sender.setImage(tintedImage, for: .normal)
    }
        
    @objc func checkBoxAction(sender: UIButton) {
        let row = sender.tag
        let cell = filterTableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell") as! FilterTableViewCell
        
        // Get the tag_category_id for the current item
        self.tag_category_id = filterList[row].tagCategoryID
        
        if filterList[row].isChecked == 0 {
            filterList[row].isChecked = 1
            filledHeart(sender: sender, isFavorite: 1)
            self.tags_id = filterList[row].tagsID
            
            if !selectedTagIDs.contains(self.tags_id) {
                selectedTagIDs.append(self.tags_id)
                SelectedCatTagIDs.append(self.tag_category_id)
            }
            
//            saveSelectedTagIDs(tagIDs: selectedTagIDs, tagCatID: SelectedCatTagIDs)
            
            // Increase count
            if var storedCounts = UserDefaults.standard.dictionary(forKey: "SelectedFilterCounts") as? [String: Int] {
                if let count = storedCounts[tag_category_id] {
                    storedCounts[tag_category_id] = count + 1
                } else {
                    storedCounts[tag_category_id] = 1
                }
                
                // Update UserDefaults values
                UserDefaults.standard.set(storedCounts, forKey: "SelectedFilterCounts")
            } else {
                // Initialize counts dictionary if it doesn't exist
                var counts: [String: Int] = [:]
                counts[tag_category_id] = 1
                
                // Update UserDefaults values
                UserDefaults.standard.set(counts, forKey: "SelectedFilterCounts")
            }
        } else {
            // Checkbox is being unchecked
            filterList[row].isChecked = 0
            self.tags_id = filterList[row].tagsID
            filledHeart(sender: sender, isFavorite: 0)
            removeSelectedTagID(tagID: self.tags_id)
            removeSelectedTagCatID(tagCatID: self.tag_category_id)
            
            if var storedCounts = UserDefaults.standard.dictionary(forKey: "SelectedFilterCounts") as? [String: Int] {
                if let count = storedCounts[tag_category_id], count > 0 {
                    storedCounts[tag_category_id] = count - 1
                    
                    // Update UserDefaults values
                    UserDefaults.standard.set(storedCounts, forKey: "SelectedFilterCounts")
                }
            }
        }
        
        // Update filter count label in visible cells
        if let storedCounts = UserDefaults.standard.dictionary(forKey: "SelectedFilterCounts") as? [String: Int] {
            if let visibleIndexPaths = filterTableView.indexPathsForVisibleRows {
                
                if visibleIndexPaths.count > 0 {
                    for indexPath in visibleIndexPaths {
                        let row = indexPath.row
                        let filterFetch = filterDatas[row]
                        let tagCatID = filterFetch.tagCategoryID
                        
                        guard let cell = filterTableView.cellForRow(at: indexPath) as? FilterTableViewCell else {
                            continue
                        }
                        
                        if let count = storedCounts[tagCatID], count > 0 {
                            cell.filterCountLbl.isHidden = false
                            cell.filterCountLbl.text = "(\(count))"
                        } else {
                            cell.filterCountLbl.isHidden = true
                        }
                    }
                } else {
                    cell.filterCountLbl.text = "Default"
                }
            }
        } else {
            cell.filterCountLbl.isHidden = true
        }
        
        isFirstTinme = false
    }
    
    func saveSelectedTagIDs(tagIDs: [String], tagCatID: [String]) {
        UserDefaults.standard.set(tagIDs, forKey: "SelectedTagIDs")
        UserDefaults.standard.synchronize()
    }

    func saveSelectedTagIDs(tagIDs: [String]) {
        UserDefaults.standard.set(tagIDs, forKey: "SelectedTagIDs")
        UserDefaults.standard.synchronize()
    }

    func removeSelectedTagID(tagID: String) {
        if var selectedTagIDs = UserDefaults.standard.array(forKey: "SelectedTagIDs") as? [String] {
            if let index = selectedTagIDs.firstIndex(of: tagID) {
                selectedTagIDs.remove(at: index)
                UserDefaults.standard.set(selectedTagIDs, forKey: "SelectedTagIDs")
                UserDefaults.standard.synchronize()
            }
        }
    }

    func removeSelectedTagCatID(tagCatID: String) {
        if var selectedCatTagIDs = UserDefaults.standard.array(forKey: "SelectedCatTagIDs") as? [String] {
            if let index = selectedCatTagIDs.firstIndex(of: tagCatID) {
                selectedCatTagIDs.remove(at: index)
                UserDefaults.standard.set(selectedCatTagIDs, forKey: "SelectedCatTagIDs")
                UserDefaults.standard.synchronize()
            }
        }
    }

    
    @objc func handleFilterCountUpdate(_ notification: Notification) {
        if let counts = notification.object as? [String: Int] {
            // Update the filter count labels in visible cells
            if let visibleIndexPaths = filterTableView.indexPathsForVisibleRows {
                for indexPath in visibleIndexPaths {
                    let row = indexPath.row
                    let filterFetch = filterDatas[row]
                    let tagCatID = filterFetch.tagCategoryID

                    guard let cell = filterTableView.cellForRow(at: indexPath) as? FilterTableViewCell else {
                        continue
                    }

                    if let count = counts[tagCatID], count > 0 {
                        
                        print("Categroy ID \(tagCatID), tagCatCOunt \(count)")

                        cell.filterCountLbl.isHidden = false
                        cell.filterCountLbl.text = "(\(count))"
                    } else {
                        cell.filterCountLbl.isHidden = true
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == filterTableView {
            guard let cell = filterTableView.cellForRow(at: indexPath) as? FilterTableViewCell else {
                return
            }

            selectedIndex = indexPath.row
            self.selected_filter_Category_id = filterDatas[indexPath.row].tagCategoryID
            self.filterList = filterDatas[selectedIndex].tagsActive

            isFirstTinme = false
            
//            FilterApi()
            
            self.filterValueTableView.reloadData()
            self.filterTableView.reloadData()

        } else {
            print("")
        }
    }


    func updateFilterCount() {
        var counts: [String: Int] = [:]

        for tagCatID in SelectedCatTagIDs {
            if let count = counts[tagCatID] {
                counts[tagCatID] = count + 1
            } else {
                counts[tagCatID] = 1
            }
        }

        if let visibleIndexPaths = filterTableView.indexPathsForVisibleRows {
            for indexPath in visibleIndexPaths {
                let row = indexPath.row
                let filterFetch = filterDatas[row]
                let tagCatID = filterFetch.tagCategoryID

                guard let cell = filterTableView.cellForRow(at: indexPath) as? FilterTableViewCell else {
                    continue
                }

                if let count = counts[tagCatID], count > 0 {
                    cell.filterCountLbl.isHidden = false
                    cell.filterCountLbl.text = "(\(count))"
                } else {
                    cell.filterCountLbl.isHidden = true
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == filterTableView {
            return 50
        } else {
            return 50
        }
    }
}

// Define the delegate protocol
protocol FilterViewControllerDelegate: AnyObject {
    func FilterViewControllerDidFinish(with data: (tagCategoryIDs: [TagCategoryID], tagIDs: [TagID]))
}

extension Notification.Name {
    static let filterCountUpdated = Notification.Name("FilterCountUpdated")
}

