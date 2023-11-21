//
//  NewUserWelcomeBonusViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 04/07/23.
//

import UIKit
import Lottie

protocol welcomePopDelegate: AnyObject {
    func okBtnTapped(_ alert: NewUserWelcomeBonusViewController, alertTag: Int)
}

class NewUserWelcomeBonusViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancel: UIButton!

    @IBOutlet var bgview: UIView!
    @IBOutlet var popUpBgview: UIView!
    
    var context: UIViewController!
    weak var delegate: welcomePopDelegate?
    var alertTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgview.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        popUpBgview.backgroundColor = .white
        popUpBgview.cornerRadius = 10
        setShadow(view: popUpBgview)
        
        self.animationView.animation = Animation.named("party-hat")
        self.animationView.loopMode = .playOnce

        animationView.play(fromProgress: 0,
                               toProgress: 1,
                           loopMode: LottieLoopMode.loop,
                               completion: { (finished) in
                                if finished {
                                    print("Animation Completed")
                                } else {
                                  print("Animation cancelled")
                                }
            })
        
        contentLbl.text = "Conguratulation! You have rewarded with 100 Super Coins as a Welcome Bonus.Add a referral Id Of your known Person to get some"
        contentLbl.textColor = UIColor(named: "Dark")
        
        okBtn.setTitle("Ok", for: .normal)
        okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        okBtn.tintColor = .black
        
        cancel.setTitle("Cancel", for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancel.tintColor = .black
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        print("cancel tapped")
    }
    
    @IBAction func okBtnAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
        vc.screenType = "Wallet"
        context.navigationController?.pushViewController(vc, animated: true)
        
        self.dismiss(animated: true)
    }
}
