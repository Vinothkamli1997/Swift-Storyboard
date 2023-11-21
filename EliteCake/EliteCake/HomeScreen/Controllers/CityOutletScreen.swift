//
//  CityOutletScreen.swift
//  EliteCake
//
//  Created by Apple - 1 on 23/01/23.
//

import UIKit
import Cosmos

class CityOutletScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityOutlet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityOutletTableView.dequeueReusableCell(withIdentifier: "CityOutletCell", for: indexPath) as! CityOutletCell
        cell.selectionStyle = .none
        cell.addressLbl.text = cityOutlet[indexPath.row].address
        cell.eliteCakeLbl.text = cityOutlet[indexPath.row].outlet_name
        cell.EliteLogo.loadImage(cityOutlet[indexPath.row].logo)
        cell.EliteLogo.sd_setImage(with: URL(string: cityOutlet[indexPath.row].logo), placeholderImage: UIImage(named: "no_image"))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         outletStrore(response: cityOutlet[indexPath.row])
         let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBOutlet weak var patialaLbl: UILabel!
    @IBOutlet weak var exploreLbl: UILabel!
    @IBOutlet weak var backBtnImg: UIImageView!
    @IBOutlet weak var cityOutletTableView: UITableView! {
        didSet {
            //Register TableView Cells
            cityOutletTableView.register(CityOutletCell.nib, forCellReuseIdentifier: CityOutletCell.identifier)
            cityOutletTableView.separatorStyle = .none
            cityOutletTableView.dataSource = self
            cityOutletTableView.delegate = self
            cityOutletTableView.backgroundColor = .clear
            cityOutletTableView.showsVerticalScrollIndicator = false
            cityOutletTableView.showsHorizontalScrollIndicator = false
        }
    }
    
    
    var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"MapView", bundle: Bundle.main)
    }
    
    var cityName: String = ""
    var cityOutlet: [OutletName] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outletApi()
        initialLoads()
        
        
    }

    @objc private func handleImageSelector() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func outletApi() {
        let hash = md5(string: ApiConstant.salt_key + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.outletlist)
        let parameters = ["city": cityName, MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value, MobileRegisterConstant.auth_token: hash]
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
                    let response = try decoder.decode(CityOutletResponse.self, from: data)
                    self.cityOutlet = response.parameters.outlet_name
                    DispatchQueue.main.async {
                        self.cityOutletTableView.reloadData()
                    }
                } catch {
                    print("error res \(error.localizedDescription)")
                }
            }
        }
    }
    
    func outletStrore(response: OutletName) {
        UserDefaults.standard.set(response.outlet_id, forKey: CityOutletConstant.outlet_id)
        UserDefaults.standard.set(response.id, forKey: CityOutletConstant.id)
    }
}

extension CityOutletScreen {
    private func initialLoads()  {
        backBtnImg.isUserInteractionEnabled = true
        backBtnImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageSelector)))
        patialaLbl.font = UIFont.boldSystemFont(ofSize: 20)
        exploreLbl.font = UIFont.boldSystemFont(ofSize: 20)
    }
}
