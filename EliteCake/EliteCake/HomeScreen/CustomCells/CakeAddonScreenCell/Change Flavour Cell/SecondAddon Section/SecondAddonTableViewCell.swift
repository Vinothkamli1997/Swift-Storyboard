//
//  SecondAddonTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 06/10/23.
//

import UIKit

class SecondAddonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var changeFlavourTitleLbl: UILabel!
    @IBOutlet weak var changeFlavourCollectionview: UICollectionView!
    
    var changeFlavourDatasDatas: AddonDish? = nil
    
    var addonDatasList: [AddonDetailsCatAdddon] = []

    var fetchAddon: [AddonDetailsCatAdddon] = []
    
    var fetchCategory: FetchCategory?
    
    var newAddonList: [DishAddonDetailsCat] = []

    
    var addOnDishList: [String] = []
    var selectedFlavourButton: UIButton?
    var selectedAddonPrice: String = ""
    var selectedFlavourView: UIView?
    
    var selectedAddon: [Int] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeFlavourCollectionview.register(SecondAddonCollectionViewCell.nib, forCellWithReuseIdentifier: "SecondAddonCollectionViewCell")
        changeFlavourCollectionview.dataSource = self
        changeFlavourCollectionview.delegate = self
        
        changeFlavourTitleLbl.text = "Second Flavour"
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


extension SecondAddonTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if newAddonList.count == 2 {
            return newAddonList[1].addonDetailsCatAdddon!.count
        } else {
            return newAddonList[0].addonDetailsCatAdddon!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondAddonCollectionViewCell", for: indexPath) as? SecondAddonCollectionViewCell else {
            return UICollectionViewCell()
        }
                
        if newAddonList.count == 2 {
            
            cell.flavourName.text = newAddonList[1].addonDetailsCatAdddon![indexPath.row].addonName
            
            fetchCategory?.multipleSelection = "Yes"
                        
            if let encodedImageUrlString = newAddonList[1].addonDetailsCatAdddon![indexPath.row].addonImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let imageUrl = URL(string: encodedImageUrlString) {
                cell.flavourImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
            } else {
                // Handle error: Invalid image URL
                cell.flavourImage.image = UIImage(named: "no_image")
            }
            
            cell.priceLbl.text = HomeConstant.rupeesSym + newAddonList[1].addonDetailsCatAdddon![indexPath.row].addonPrice!
        } else {
            
            cell.flavourName.text = fetchAddon[indexPath.row].addonName
                        
            cell.priceLbl.text = HomeConstant.rupeesSym + fetchAddon[indexPath.row].addonPrice!
            
            if let encodedImageUrlString = fetchAddon[indexPath.row].addonImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let imageUrl = URL(string: encodedImageUrlString) {
                cell.flavourImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
            } else {
                // Handle error: Invalid image URL
                cell.flavourImage.image = UIImage(named: "no_image")
            }
            
        }
        
        if fetchCategory?.multipleSelection != "No" {
            if selectedAddon.contains(indexPath.row) {
                cell.flavourSelectBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                cell.flavourSelectBtn.tintColor = UIColor(hexFromString: ColorConstant.GREEN)
            } else {
                cell.flavourSelectBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                cell.flavourSelectBtn.tintColor = UIColor.gray
            }
        }
        
        cell.flavourSelectBtn.tag = indexPath.row
        cell.flavourSelectBtn.addTarget(self, action: #selector(flavourBtnAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SecondAddonCollectionViewCell {
            let button = cell.flavourSelectBtn!
            
            flavourBtnAction(button)
        }
    }
    
    @objc func flavourBtnAction(_ sender: UIButton) {
        let row = sender.tag

        if fetchCategory?.multipleSelection == "No" {
            // Check if the button is already selected

            if sender.isSelected {
                // Deselect the button
                sender.isSelected = false
                sender.tintColor = UIColor.gray
                selectedFlavourButton?.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                selectedFlavourButton = nil

//                selectedAddonPrice = fetchAddon[row].addonPrice!


                if newAddonList.count == 2 {
                    selectedAddonPrice = newAddonList[1].addonDetailsCatAdddon![row].addonPrice!
                } else {
                    selectedAddonPrice = fetchAddon[row].addonPrice!
                }

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

                selectedAddonPrice = fetchAddon[row].addonPrice!

                if newAddonList.count == 2 {
                    selectedAddonPrice = newAddonList[1].addonDetailsCatAdddon![row].addonPrice!
                } else {
                    selectedAddonPrice = fetchAddon[row].addonPrice!
                }

                if newAddonList.count == 2 {
                    addOnDishList = [newAddonList[1].addonDetailsCatAdddon![row].addonID]
                } else {
                    addOnDishList = [fetchAddon[row].addonID]
                }

                addOnDishList = [fetchAddon[row].addonID] // Assuming fetchAddon[row].addonID is of type String

                NotificationCenter.default.post(name: .addOnPrice, object: nil, userInfo: ["addonPrice": selectedAddonPrice])

                NotificationCenter.default.post(name: .selectedAddOnDish, object: nil, userInfo: ["selectedAddOnDish": addOnDishList])

            }
        } else {

            // Handle multiple selection
            if sender.isSelected {
                
                print("Button Dis selected ")

                // Deselect the button
                sender.isSelected = false
                sender.tintColor = UIColor.gray
                sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)

                // Remove the addonID from the selected list
                let selectedAddonDish = fetchAddon[row].addonID
                if let index = addOnDishList.firstIndex(of: selectedAddonDish) {
                    addOnDishList.remove(at: index)
                }

                selectedAddonPrice = fetchAddon[row].addonPrice!

                if newAddonList.count == 2 {
                    selectedAddonPrice = newAddonList[1].addonDetailsCatAdddon![row].addonPrice!
                } else {
                    selectedAddonPrice = fetchAddon[row].addonPrice!
                }

                NotificationCenter.default.post(name: .addOnPriceDisselect, object: nil, userInfo: ["addonPriceDisselect": selectedAddonPrice])

            } else {
                
                print("Button selected ")

                
                if selectedAddon.contains(row) {
                    // Deselect the button
                    if let index = selectedAddon.firstIndex(of: row) {
                        selectedAddon.remove(at: index)
                                                
                        selectedAddonPrice = fetchAddon[row].addonPrice!

                        if newAddonList.count == 2 {
                            selectedAddonPrice = newAddonList[1].addonDetailsCatAdddon![row].addonPrice!
                        } else {
                            selectedAddonPrice = fetchAddon[row].addonPrice!
                        }
                        
                        NotificationCenter.default.post(name: .addOnPriceDisselect, object: nil, userInfo: ["addonPriceDisselect": selectedAddonPrice])

                    }
                } else {
                    // Select the button
                    selectedAddon.append(row)
                    
                    selectedAddonPrice = fetchAddon[row].addonPrice!

                    if newAddonList.count == 2 {
                        selectedAddonPrice = newAddonList[1].addonDetailsCatAdddon![row].addonPrice!
                    } else {
                        selectedAddonPrice = fetchAddon[row].addonPrice!
                    }
                    
                    NotificationCenter.default.post(name: .multiaddOnPrice, object: nil, userInfo: ["MultiaddonPrice": selectedAddonPrice])

                }
                
//                // Add the addonID to the selected list
//                let selectedAddonDish = fetchAddon[row].addonID
//                addOnDishList.append(selectedAddonDish)

                if newAddonList.count == 2 {
                    // Add the addonID to the selected list
                    let selectedAddonDish = newAddonList[1].addonDetailsCatAdddon![row].addonID
                    addOnDishList.append(selectedAddonDish)

                } else {
                    // Add the addonID to the selected list
                    let selectedAddonDish = fetchAddon[row].addonID
                    addOnDishList.append(selectedAddonDish)
                }

//                NotificationCenter.default.post(name: .multiaddOnPrice, object: nil, userInfo: ["MultiaddonPrice": selectedAddonPrice])

                NotificationCenter.default.post(name: .selectedMultipleAddOnDish, object: nil, userInfo: ["selectedMultipleAddOnDish": addOnDishList])
                
                
                changeFlavourCollectionview.reloadData()

            }
        }
    }
}
