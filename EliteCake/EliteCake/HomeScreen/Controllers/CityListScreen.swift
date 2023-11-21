//
//  EliteMapViewController.swift
//  EliteCake
//
//  Created by apple on 21/01/23.
//

import UIKit

class CityListScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: "CityListTableViewCell", for: indexPath) as! CityListTableViewCell
        cell.selectionStyle = .none
        cell.cityLbl.text = cityList[indexPath.row].city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let cell = cityList[indexPath.row]
        let storyboard = UIStoryboard(name: "CityOutletScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CityOutletScreen") as! CityOutletScreen
        vc.cityName = cityList[indexPath.row].city!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var cityList: [City] = []
    
    @IBOutlet weak var searchFiel: UITextField!
    @IBOutlet weak var currentLocBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var cityTableView: UITableView! {
        didSet {
            //Register TableView Cells
            cityTableView.register(CityListTableViewCell.nib, forCellReuseIdentifier: CityListTableViewCell.identifier)
            cityTableView.separatorStyle = .none
            cityTableView.dataSource = self
            cityTableView.delegate = self
            cityTableView.backgroundColor = .clear
            cityTableView.showsVerticalScrollIndicator = false
            cityTableView.showsHorizontalScrollIndicator = false
            cityTableView.tableFooterView = UIView()
        }
    }
    
    var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"HomeScreen", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityApi()
        initialLoads()
    }

    func cityApi() {
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.city)
        let parameters = [MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value, MobileRegisterConstant.auth_token: hash]
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let response = try decoder.decode(CityResponse.self, from: data)
                    self.cityList = response.parameters.city
                    DispatchQueue.main.async {
                        self.cityTableView.reloadData()
                    }
                } catch {
                    print("error res localization \(error.localizedDescription)")
                }
            }
        }
    }

    @objc private func handleImageSelector() {
        self.navigationController?.popViewController(animated: true)

    }
}

extension CityListScreen {
    
    private func initialLoads()  {
        
        searchFiel.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search")
        imageView.image = image
        searchFiel.leftView = imageView
        currentLocBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        currentLocBtn.setTitle("Use Current Loction",
                               for: .normal)
        
        currentLocBtn.setImage(UIImage(systemName: "scope"),
                               
                               for: .normal)
        currentLocBtn.cornerRadius = 20
        backImg.isUserInteractionEnabled = true
        backImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageSelector)))
    }
}

extension CityListScreen {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Loading", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
