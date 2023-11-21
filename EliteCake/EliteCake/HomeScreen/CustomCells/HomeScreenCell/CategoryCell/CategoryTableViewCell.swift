//
//  CategoryTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 25/01/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return categoryCellDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
//        cell.cakeImg.sd_setImage(with: URL(string: categoryCellDatas[indexPath.row].categoryImage), placeholderImage: UIImage(named: "no_image"))
        
        if let urlString = categoryCellDatas[indexPath.row].categoryImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "no_image") // Optional placeholder image
            cell.cakeImg.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
        
        cell.cakeName.text = categoryCellDatas[indexPath.row].categoryName
        setShadow(view: cell.bgView)
        cell.bgView.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoryDishesViewController") as! CategoryDishesViewController
        vc.category_id = categoryCellDatas[indexPath.row].categoryID
        print("category id \(categoryCellDatas[indexPath.row].categoryID)")
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170 , height: 170)
    }

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var showAllBtn: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryCellDatas:[Category] = []
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryCollectionView.register(CategoryCell.nib, forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryLbl.font = UIFont.boldSystemFont(ofSize: 18)
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
