//
//  EarnCashViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 27/07/23.
//

import UIKit
import Lottie
import dotLottie
import SafariServices
import WebKit

class EarnCashViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WKNavigationDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return earnCashValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EarnCashCollectionViewCell", for: indexPath) as? EarnCashCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.priceLbl?.text = HomeConstant.rupeesSym + earnCashValues[indexPath.row].amount
        cell.onAddingLbl?.text = "On adding " + earnCashValues[indexPath.row].to + " unique members"

        if earnCashValues[indexPath.row].addMoreShow == 0 {
            cell.addMoreLbl.isHidden = true
        } else {
            cell.addMoreLbl.isHidden = false
            cell.addMoreLbl?.text = "Add " + String(earnCashValues[indexPath.row].addMore) + " more to claim"
        }

        if Int(earnCashValues[indexPath.row].amount)! > 2000 {
            cell.bgImage?.image = UIImage(named: "card1")
            cell.innerImage?.image = UIImage(named: "5star_tabImg")
        } else if Int(earnCashValues[indexPath.row].amount)! > 1000 {
            cell.bgImage?.image = UIImage(named: "card2")
            cell.innerImage?.image = UIImage(named: "tab4star")
        } else if Int(earnCashValues[indexPath.row].rangeID)! > 400 {
            cell.bgImage?.image = UIImage(named: "card3")
            cell.innerImage?.image = UIImage(named: "event_proce")
        } else {
            cell.bgImage?.image = UIImage(named: "card4")
            cell.innerImage?.image = UIImage(named: "tab2")
        }

        if earnCashValues[indexPath.row].claimButton == 0 {
            cell.claimBtnImage.image = UIImage(named: "yellow-btn")
            cell.claimBtnImage.isUserInteractionEnabled = false
        } else {
            cell.claimBtnImage.image = UIImage(named: "green-btn")

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(claimViewTapped(_:)))

            cell.claimBtnImage.tag = indexPath.row

            cell.claimBtnImage.isUserInteractionEnabled = true
            cell.claimBtnImage.addGestureRecognizer(tapGesture)
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsInRow: CGFloat = 2
        let spacingBetweenItems: CGFloat = 10
        
        let totalSpacing = (numberOfItemsInRow - 1) * spacingBetweenItems
        let availableWidth = collectionView.frame.width - totalSpacing
        let cellWidth = availableWidth / numberOfItemsInRow
        
        // If you want to maintain the aspect ratio of 180:240, calculate the cell height accordingly
        let cellHeight = cellWidth * (240.0 / 180.0)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    @objc func claimViewTapped(_ sender: UITapGestureRecognizer) {
        // Retrieve the tag to identify which cell's image view was tapped
        let tappedRowIndex = sender.view?.tag
        
        // Perform any actions you want based on the tappedRowIndex
        if let rowIndex = tappedRowIndex {
            
            let storyBoard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "NewDownlineViewController") as! NewDownlineViewController

            vc.selectValue = earnCashValues[rowIndex].to
            vc.rangeID = earnCashValues[rowIndex].rangeID
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


    
    @IBOutlet weak var earnCashBgImage: UIImageView!
    @IBOutlet weak var earnCashCollectionView: UICollectionView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var emptyBgview: UIView!
    @IBOutlet weak var emptyContentLbl: UILabel!
    @IBOutlet weak var bottomview: UIView!

    @IBOutlet weak var termsConditionsLbl: UILabel!


    var customerID: String = ""
    var earnCashValues: [EarnGetParameter] = []
    var range_ID: String = ""
    var selectAmount: String = ""
    
    
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        earnCashCollectionView.register(EarnCashCollectionViewCell.nib, forCellWithReuseIdentifier: "EarnCashCollectionViewCell")
        earnCashCollectionView.dataSource = self
        earnCashCollectionView.delegate = self
        earnCashCollectionView.showsVerticalScrollIndicator = false
        
        earnCashCollectionView.backgroundColor = nil
        
        emptyBgview.isHidden = true
        
        emptyContentLbl.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Create an attributed string with an underline attribute
        let attributedText = NSMutableAttributedString(string: termsConditionsLbl.text ?? "")
        let range = NSMakeRange(0, attributedText.length)

        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)

        // Assign the attributed text to the label
        termsConditionsLbl.attributedText = attributedText

        
        termsConditionsLbl.text = "Terms and conditions"
        termsConditionsLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        // Optionally, set the text color
        termsConditionsLbl.textColor = UIColor.white
        
        termsConditionsLbl.isUserInteractionEnabled = true
           
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openURL(_:)))
        termsConditionsLbl.addGestureRecognizer(gestureRecognizer)
        termsConditionsLbl.isUserInteractionEnabled = true

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        bottomImageView.addGestureRecognizer(tapGestureRecognizer)
        bottomImageView.isUserInteractionEnabled = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        EarnCashCheckClaimApi()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func imageViewTapped() {
        let storyBoard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DownLineViewController") as! DownLineViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openURL(_ sender: UITapGestureRecognizer) {
        
        let storyBoard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TermsAndConditionViewController") as! TermsAndConditionViewController

        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    
    func EarnCashCheckClaimApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.EarnCash_CheckClaim)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
        
        print("EarnCheckclaim params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EarnCheckClaimResponse.self, from: data)
                    print("EarnCheckclaim Response \(response)")
                    DispatchQueue.main.async {
                        if response.success {
                            self.hideLoader()
                            self.EarnCashGetClaimApi()
                        } else {
                            self.earnCashCollectionView.isHidden = true
                            self.emptyBgview.isHidden = false
                            self.emptyContentLbl.text = "Your Claim has been submitted. You will receive a call within 7 days after verification of Ids added by you"
                        }
                    }
                   
                    DispatchQueue.main.async {
                        self.earnCashCollectionView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("EarnCheckclaim error res \(error)")
                }
            }
        }
    }
    
    func EarnClaimApi() {
        
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.EarnCash_ClaimApi)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
            "range_id": range_ID,
            "amount" : selectAmount
        ] as [String : Any]
        
        print("Earnclaim params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EarnClaimResponse.self, from: data)
                    print("Earnclaim Response \(response)")
                    
                    DispatchQueue.main.async {
                        self.earnCashCollectionView.reloadData()
                    }
                    self.hideLoader()
                } catch {
                    self.hideLoader()
                    print("Earnclaim error res \(error)")
                }
            }
        }
    }
    
    func EarnCashGetClaimApi() {
        self.showLoader()
        
        if let customer_id = UserDefaults.standard.string(forKey: LoginConstant.customer_id){
            customerID = customer_id
        }
        
        let hash = md5(string: ApiConstant.salt_key + customerID + MobileRegisterConstant.merchant_id_value)
        let url = URL(string: ApiConstant.EarnCash_GetClaim)
        
        let parameters = [
            MobileRegisterConstant.merchant_id: MobileRegisterConstant.merchant_id_value,
            MobileRegisterConstant.auth_token: hash,
            "customer_id": customerID,
        ] as [String : Any]
        
        print("EarnGetclaim params \(parameters)")
        
        makeAPICall(url: url!, method: "POST", parameters: parameters) { (data, error, response) in
            if error != nil {
            } else if let data = data, let response = response {
                if response.statusCode != 200 {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EarnGetClaimResponse.self, from: data)
                    print("EarnGetclaim Response \(response)")
                    
                    self.earnCashValues = response.parameters
                    
                    DispatchQueue.main.async {
                        self.earnCashCollectionView.reloadData()
                    }
                    self.hideLoader()
                    
                } catch {
                    self.hideLoader()
                    
                    print("EarnGetclaim error res \(error)")
                }
            }
        }
    }
}
