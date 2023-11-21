//
//  FlavourTableviewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 19/01/23.
//

import UIKit

class FlavourTableviewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flavourCellDatas.count
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlavourCell", for: indexPath) as? FlavourCell else {
            return UICollectionViewCell()
        }
//        cell.bgView.backgroundColor = .white
       // cell.cakeImg.loadImage((flavourCellDatas[indexPath.row].cuisineImage))
//        cell.cakeImg.sd_setImage(with: URL(string: flavourCellDatas[indexPath.row].cuisineImage), placeholderImage: UIImage(named: "no_image"))
        
        if let urlString = flavourCellDatas[indexPath.row].cuisineImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image") // Optional placeholder image
            cell.cakeImg.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
        
        cell.cakeNameLbl.text = flavourCellDatas[indexPath.row].cuisineName
        cell.bgView.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FlavourCusineViewController") as! FlavourCusineViewController
        vc.cusine_id = flavourCellDatas[indexPath.row].cuisineID
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170 , height: 170)
    }
    
    @IBOutlet weak var showAllBtn: UIButton!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var flavourCollectionView: UICollectionView!
    
    var flavourCellDatas: [Cusine] = []
    var flavourDishID: HomeScreenParameters? = nil
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        flavourCollectionView.register(FlavourCell.nib, forCellWithReuseIdentifier: "FlavourCell")
        flavourCollectionView.dataSource = self
        flavourCollectionView.delegate = self
        showAllBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
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
