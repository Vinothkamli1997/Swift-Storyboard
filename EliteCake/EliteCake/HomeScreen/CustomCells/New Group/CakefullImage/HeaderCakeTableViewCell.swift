//
//  HeaderCakeTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 30/01/23.
//

import UIKit

class HeaderCakeTableViewCell: UITableViewCell {

    @IBOutlet weak var cakeDetailCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backBtnView: UIView!

    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var favoriteBtnVIew: UIView!

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareBtnVIew: UIView!
    
    var context: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cakeDetailCollectionView.register(HeaderCakeImageCell.nib, forCellWithReuseIdentifier: "HeaderCakeImageCell")
        backBtn.tintColor = UIColor.black
        
        favoriteBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        backBtnView.cornerRadius = 15
        setShadow(view: backBtnView)
        
        favoriteBtnVIew.cornerRadius = 15
        setShadow(view: favoriteBtnVIew)
        
        shareBtnVIew.cornerRadius = 15
        setShadow(view: shareBtnVIew)

    }
    
    var cakeDetailCellResponse: Dish?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        context.navigationController?.popViewController(animated: true)
//        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
//        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func sharBtnAction(_ sender: Any) {
        let referralCode = "Eliet Cakes"
        let appStoreURLString = "https://play.google.com/store/apps/details?id=com.tt.yumbox.elitecake"
        
        guard let encodedAppStoreURLString = appStoreURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let appToShare = "\(referralCode)\n\(encodedAppStoreURLString)"
        
        let itemsToShare: [Any] = [appToShare]
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        // Customize the activity view controller if needed
        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            // Handle completion or dismissal of the activity view controller if needed
        }
        
        // Get the parent view controller that contains the table view
        if let parentViewController = self.context {
            parentViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: nil)
       }
       
       static var identifier: String {
           return String(describing: self)
       }

}



