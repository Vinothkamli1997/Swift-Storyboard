//
//  ChangeFlavourTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 20/02/23.
//

import UIKit

class ChangeFlavourTableViewCell: UITableViewCell {

    @IBOutlet weak var changeFlavourTitleLbl: UILabel!
    @IBOutlet weak var changeFlavourCollectionview: UICollectionView!
    
    var changeFlavourDatasDatas: AddonDish? = nil
    
//    var addonDatasList: [AddonDetailsCatAdddon] = []
//
//    var fetchAddon: [AddonDetailsCatAdddon] = []
    
    var addonDatasList: [AddonDetailsCatAdddon] = []
    
    var fetchAddon: [FetchAddon] = []
    
    var fetchCategory: FetchCategory?
    
    var addOnDishList: [String] = []
    var selectedFlavourButton: UIButton?
    var selectedAddonPrice: String = ""
    var selectedFlavourView: UIView?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeFlavourCollectionview.register(ChangeFlavourCollectionViewCell.nib, forCellWithReuseIdentifier: "ChangeFlavourCollectionViewCell")
        changeFlavourCollectionview.dataSource = self
        changeFlavourCollectionview.delegate = self
        
        changeFlavourTitleLbl.text = "Change Flavour"
        changeFlavourTitleLbl.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension ChangeFlavourTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchAddon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChangeFlavourCollectionViewCell", for: indexPath) as? ChangeFlavourCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.flavourName.text = fetchAddon[indexPath.row].addonName
        
        if let encodedImageUrlString = fetchAddon[indexPath.row].addonImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let imageUrl = URL(string: encodedImageUrlString) {
            cell.flavourImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
        } else {
            // Handle error: Invalid image URL
            cell.flavourImage.image = UIImage(named: "no_image")
        }
        
        cell.priceLbl.text = HomeConstant.rupeesSym + fetchAddon[indexPath.row].addonPrice
        
        cell.flavourSelectBtn.tag = indexPath.row
        cell.flavourSelectBtn.addTarget(self, action: #selector(flavourBtnAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ChangeFlavourCollectionViewCell {
            let button = cell.flavourSelectBtn!
            
            flavourBtnAction(button)
        }
    }
    
    @objc func flavourBtnAction(_ sender: UIButton) {
        let row = sender.tag
        
        if fetchCategory?.multipleSelection == "No" {
            // Check if the button is already selected
            
            print("button ststus \(sender.isSelected)")
            
            if sender.isSelected {
                // Deselect the button
                sender.isSelected = false
                sender.tintColor = UIColor.gray
                selectedFlavourButton?.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                selectedFlavourButton = nil
                
                selectedAddonPrice = fetchAddon[row].addonPrice
                
                NotificationCenter.default.post(name: .addOnPriceDisselect, object: nil, userInfo: ["addonPriceDisselect": selectedAddonPrice])
                
            } else {
                // Deselect the previously selected button (if any)
                selectedFlavourButton?.isSelected = false
                selectedFlavourButton?.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                selectedFlavourButton?.tintColor = UIColor.gray
                
                // Select the current button
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                sender.isSelected = true
                sender.tintColor = UIColor(hexFromString: ColorConstant.GREEN)
                selectedFlavourButton = sender
                
                selectedAddonPrice = fetchAddon[row].addonPrice
                
                NotificationCenter.default.post(name: .addOnPrice, object: nil, userInfo: ["addonPrice": selectedAddonPrice])

//                addOnDishList = [fetchAddon[row].addonID] // Assuming fetchAddon[row].addonID is of type String
                
                if let selectedAddonDish = fetchAddon[row].addonID {
                    
                    if !addonDatasList.isEmpty {
                        addonDatasList = []
                    } else {
                        addonDatasList = []
                    }
                    
                    addOnDishList = [selectedAddonDish] // Create an array with a non-optional String
                } else {
                    // Handle the case where fetchAddon[row].addonID is nil (optional is nil)
                    // You can choose to set addOnDishList to an empty array or handle it differently.
                }
                
                NotificationCenter.default.post(name: .selectedAddOnDish, object: nil, userInfo: ["selectedAddOnDish": addOnDishList])
                print("shjdhgshdkgasfgakfdahjfgjj \(addOnDishList)")

            }
        } else {
            
            // Handle multiple selection
            if sender.isSelected {
                // Deselect the button
                sender.isSelected = false
                sender.tintColor = UIColor.gray
                sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                
                // Remove the addonID from the selected list
                let selectedAddonDish = fetchAddon[row].addonID
                if let index = addOnDishList.firstIndex(of: selectedAddonDish!) {
                    addOnDishList.remove(at: index)
                }
                
                selectedAddonPrice = HomeConstant.rupeesSym + fetchAddon[row].addonPrice
                
                NotificationCenter.default.post(name: .multiaddOnPriceDisselect, object: nil, userInfo: ["MultiaddonPriceDisselect": selectedAddonPrice])

            } else {
                // Select the button
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                sender.isSelected = true
                sender.tintColor = UIColor(hexFromString: ColorConstant.GREEN)
                
                // Add the addonID to the selected list
                let selectedAddonDish = fetchAddon[row].addonID
                addOnDishList.append(selectedAddonDish!)
                
                selectedAddonPrice = HomeConstant.rupeesSym + fetchAddon[row].addonPrice
                
                NotificationCenter.default.post(name: .multiaddOnPrice, object: nil, userInfo: ["MultiaddonPrice": selectedAddonPrice])
            }
            
            // Notify observers about the selected addon dishes list
            NotificationCenter.default.post(name: .selectedAddOnDish, object: nil, userInfo: ["selectedAddOnDish": addOnDishList])
            
            print("shjdhgshdkgasfgakfdahjfgjj \(addOnDishList)")
        }
    }
}
