//
//  WalletAndLikeTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 14/03/23.
//

import UIKit

class WalletAndLikeTableViewCell: UITableViewCell {

    @IBOutlet weak var walletBgView: UIView!
    @IBOutlet weak var walletBtn: UIButton!
    @IBOutlet weak var walletNameLbl: UILabel!
    
    @IBOutlet weak var likeBgView: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likeNameLbl: UILabel!
    
    @IBOutlet weak var profileBgView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var profileLbl: UILabel!
    
    @IBOutlet weak var notificationBgView: UIView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var notificationLbl: UILabel!
    
    var context: UIViewController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        walletNameLbl.text = "Wallet"
        walletNameLbl.font = UIFont.boldSystemFont(ofSize: 10)
                
        walletBtn.setImage(UIImage(systemName: "wallet.pass.fill"), for: .normal)
        walletBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        walletBgView.backgroundColor = UIColor(named: "ViewDarkMode")
        walletBgView.layer.cornerRadius = 10
        setShadow(view: walletBgView)
        
        likeNameLbl.text = "Like"
        likeNameLbl.font = UIFont.boldSystemFont(ofSize: 10)

        likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        likeBgView.backgroundColor = UIColor(named: "ViewDarkMode")
        likeBgView.layer.cornerRadius = 10
        setShadow(view: likeBgView)
        
        profileLbl.text = "Profile"
        profileLbl.font = UIFont.boldSystemFont(ofSize: 10)

        profileBtn.setImage(UIImage(systemName: "person.fill"), for: .normal)
        profileBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        profileBgView.backgroundColor = UIColor(named: "ViewDarkMode")
        profileBgView.layer.cornerRadius = 10
        setShadow(view: profileBgView)
        
        notificationLbl.text = "Notification"
        notificationLbl.font = UIFont.boldSystemFont(ofSize: 10)

        notificationBtn.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        notificationBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        notificationBgView.backgroundColor = UIColor(named: "ViewDarkMode")
        notificationBgView.layer.cornerRadius = 10
        setShadow(view: notificationBgView)
        
        
        let walletAction = UITapGestureRecognizer(target: self, action: #selector(walletviewTapped))
        walletBgView.addGestureRecognizer(walletAction)
        
        let profileAction = UITapGestureRecognizer(target: self, action: #selector(profileviewTapped))
        profileBgView.addGestureRecognizer(profileAction)
        
        let likeAction = UITapGestureRecognizer(target: self, action: #selector(likeviewTapped))
        likeBgView.addGestureRecognizer(likeAction)
        
        let notificationAction = UITapGestureRecognizer(target: self, action: #selector(notificationviewTapped))
        notificationBgView.addGestureRecognizer(notificationAction)
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
    
    @objc func walletviewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        vc.screenType = "Wallet"
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func likeviewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyFavouriteViewController") as! MyFavouriteViewController
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func profileviewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        UserDefaults.standard.set("Account", forKey: "AccountScreen")
        vc.accountScreen = "Account"
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func notificationviewTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        context.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func walletBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        vc.screenType = "Wallet"
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func likeBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyFavouriteViewController") as! MyFavouriteViewController
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func profileBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.accountScreen = "Account"
        UserDefaults.standard.set("Account", forKey: "AccountScreen")
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func notificationBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        context.navigationController?.pushViewController(vc, animated: true)
    }
}
