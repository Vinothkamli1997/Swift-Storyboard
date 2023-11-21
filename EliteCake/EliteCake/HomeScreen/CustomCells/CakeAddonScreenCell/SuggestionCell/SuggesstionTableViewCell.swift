//
//  SuggesstionTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/02/23.
//

import UIKit
import SDWebImage
import Cosmos

class SuggesstionTableViewCell: UITableViewCell {

    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    var suggestionDatas: [Suggested] = []
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        suggestionCollectionView.register(SuggestionCollectionViewCell.nib, forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.delegate = self
        
        titleLbl.text = "You May Alse Like"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
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


extension SuggesstionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(("sugeestion count \(suggestionDatas.count)"))
        return suggestionDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as? SuggestionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        cell.suggestionCakeImg.sd_setImage(with: URL(string: suggestionDatas[indexPath.row][0].withBackground!), placeholderImage: UIImage(named: "no_image"))
        
        if let withBackground = suggestionDatas[indexPath.row].withBackground,
           let urlString = withBackground.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image")
            cell.suggestionCakeImg.sd_setImage(with: url, placeholderImage: placeholderImage)
        } else {
            cell.suggestionCakeImg.image = UIImage(named: "no_image")
        }
        
        cell.cakeName.text = suggestionDatas[indexPath.row].dishName
        
//        cell.ratingView.rating = Double(suggestionDatas[indexPath.row][0].dishRating)!

        if let dishRating = suggestionDatas[indexPath.row].dishRating,
           let rating = Double(dishRating) {
            cell.ratingView.rating = rating
        } else {
            cell.ratingView.rating = 4.0
        }
        
        cell.priceLbl.text = HomeConstant.rupeesSym + suggestionDatas[indexPath.row].dishPrice!
        
        cell.subTitle.text = HomeConstant.IN + suggestionDatas[indexPath.row].category!.categoryName
        
        cell.landingPriceLbl.text = HomeConstant.rupeesSym + suggestionDatas[indexPath.row].landingPrice!
        
        if suggestionDatas[indexPath.row].dishType == "veg" {
            cell.vegNonvegImg.image = UIImage(named: "vegImage")
        } else {
            cell.vegNonvegImg.image = UIImage(named: "nonVegImage")
        }
        
        cell.orderNowBtn.tag = indexPath.row
        cell.orderNowBtn.addTarget(self, action: #selector(popularOrderBtn(_:)), for: .touchUpInside)
        
        return cell
    }
    
    //ordernowBtn Action
    @objc func popularOrderBtn(_ sender: UIButton) {
        let row = sender.tag
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeAddonScreen") as! CakeAddonScreen
        vc.dish_id = suggestionDatas[row].dishID!
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 370)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CakeDetailScreen") as! CakeDetailScreen
        vc.dish_id = suggestionDatas[indexPath.row].dishID!
        context.navigationController?.pushViewController(vc, animated: true)
        
    }
}
