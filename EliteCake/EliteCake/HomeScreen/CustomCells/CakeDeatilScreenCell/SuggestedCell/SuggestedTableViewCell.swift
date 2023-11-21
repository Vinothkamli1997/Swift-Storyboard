//
//  SuggestedTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 07/02/23.
//

import UIKit

class SuggestedTableViewCell: UITableViewCell {

    @IBOutlet weak var suggestedCollectionView: UICollectionView!
    @IBOutlet weak var suggestedLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        suggestedCollectionView.register(SuggestedCollectionViewCell.nib, forCellWithReuseIdentifier: "SuggestedCollectionViewCell")
        suggestedCollectionView.dataSource = self
        suggestedCollectionView.delegate = self
    }
    
    var suggestedDatas: [Dish] = []
    var cakeDetailResponse: Dish!
    var context: UIViewController!

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

extension SuggestedTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if  suggestedDatas.count == 0 {
            return 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestedDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCollectionViewCell", for: indexPath) as? SuggestedCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        if let encodedImageUrlString = suggestedDatas[indexPath.row][0].withBackground!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//           let imageUrl = URL(string: encodedImageUrlString) {
//            cell.suggestedImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
//        } else {
//            cell.suggestedImg.image = UIImage(named: "no_image")
//        }
        
//        if let suggestedData = suggestedDatas[indexPath.row].withBackground.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//           let imageUrl = URL(string: encodedImageUrlString) {
//            cell.suggestedImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
//        } else {
//            cell.suggestedImg.image = UIImage(named: "no_image")
//        }
        
//        if let suggestedData = suggestedDatas[indexPath.row].first {
//            if let encodedImageUrlString = suggestedData.withBackground.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//               let imageUrl = URL(string: encodedImageUrlString) {
//                cell.suggestedImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "no_image"))
//            } else {
//                cell.suggestedImg.image = UIImage(named: "no_image")
//            }
//        } else {
//            cell.suggestedImg.image = UIImage(named: "no_image")
//        }

        cell.cakeNameLbl.text = suggestedDatas[indexPath.row].dishName
        
        if let urlString = suggestedDatas[indexPath.row].withBackground.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image") // Optional placeholder image
            cell.suggestedImg.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
        
        if let dishRating = suggestedDatas[indexPath.row].dishRating, let ratingDouble = Double(dishRating) {
            cell.ratingView.rating = ratingDouble
        } else {
            cell.ratingView.rating = 4.0
        }

        cell.priceLbl.text = HomeConstant.rupeesSym + suggestedDatas[indexPath.row].dishPrice
        cell.subTitleLbl.text = HomeConstant.IN + suggestedDatas[indexPath.row].category.categoryName
        cell.landingPriceLbl.text = HomeConstant.rupeesSym  + suggestedDatas[indexPath.row].landingPrice
        cell.bestPriceLbl.text = "Best Price"

        
        if suggestedDatas[indexPath.row].dishType == "veg" {
            cell.vegorNonvegImg.image = UIImage(named: "vegImage")
        } else {
            cell.vegorNonvegImg.image = UIImage(named: "nonVegImage")
        }
        
        cell.orderNowBtn.tag = indexPath.row
        cell.orderNowBtn.addTarget(self, action: #selector(suggeedOrderBtn(_:)), for: .touchUpInside)
    
        return cell
    }
    
    //ordernowBtn Action
    @objc func suggeedOrderBtn(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
        vc.dish_id = suggestedDatas[row].dishID
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 370)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = suggestedDatas[indexPath.row].dishID
        context.navigationController?.pushViewController(vc, animated: true)
    }
}
