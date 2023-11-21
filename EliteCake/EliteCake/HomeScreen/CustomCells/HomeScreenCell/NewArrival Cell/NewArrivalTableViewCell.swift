//
//  NewArrivalTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 19/01/23.
//

import UIKit
import Cosmos

class NewArrivalTableViewCell: UITableViewCell {


    @IBOutlet weak var arrivalLbl: UILabel!
    @IBOutlet weak var arrivalCollectionView: UICollectionView!
    var newArrivalDatas: [NewArrival] = []
    var context: UIViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        arrivalLbl.text = HomeConstant.newArrival
        arrivalCollectionView.register(NewArrivalCell.nib, forCellWithReuseIdentifier: "NewArrivalCell")
        arrivalCollectionView.dataSource = self
        arrivalCollectionView.delegate = self
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

extension NewArrivalTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if newArrivalDatas.isEmpty {
            collectionView.isHidden = true
            return 0
        } else {
            collectionView.isHidden = false
            return newArrivalDatas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewArrivalCell", for: indexPath) as? NewArrivalCell else {
            return UICollectionViewCell()
        }
      //  cell.newArrivalImg.loadImage((newArrivalDatas[indexPath.row].dishes.withBackground))
        
//        cell.newArrivalImg.sd_setImage(with: URL(string: newArrivalDatas[indexPath.row].dishes.withBackground), placeholderImage: UIImage(named: "no_image"))
        
        if let encodedImageUrlString = newArrivalDatas[indexPath.row].dishes.withBackground.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let imageUrl = URL(string: encodedImageUrlString) {
            cell.newArrivalImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
        } else {
            // Handle error: Invalid image URL
            cell.newArrivalImg.image = UIImage(named: "no_image")
        }

        cell.cakeNameLbl.text = newArrivalDatas[indexPath.row].dishes.dishName
        cell.subTitleLbl.text = HomeConstant.IN + newArrivalDatas[indexPath.row].dishes.category.categoryName
        cell.priceLbl.text = HomeConstant.rupeesSym + newArrivalDatas[indexPath.row].dishes.dishDiscounts
        cell.ratingView.rating = Double(newArrivalDatas[indexPath.row].dishes.dishRating)!
        
        cell.landingPriceLbl.text = HomeConstant.rupeesSym + newArrivalDatas[indexPath.row].dishes.landingPrice

        if newArrivalDatas[indexPath.row].dishes.dishType == "veg" {
            cell.vegorNonvegImg.image = UIImage(named: "vegImage")
        } else {
            cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
        }
        
        cell.orderNowBtn.tag = indexPath.row
        cell.orderNowBtn.addTarget(self, action: #selector(newArrivalOrderBtn(_:)), for: .touchUpInside)

        return cell
    }
    
    
    //ordernowBtn Action
    @objc func newArrivalOrderBtn(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
        vc.dish_id = newArrivalDatas[row].dishes.dishID
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 370)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = newArrivalDatas[indexPath.row].dishes.dishID
        context.navigationController?.pushViewController(vc, animated: true)
    }
}
