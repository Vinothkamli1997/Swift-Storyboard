//
//  RedeemCoinViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/05/23.
//

import UIKit
import Lottie

class RedeemCoinViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var backgroundAnimation: AnimationView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var popupBgView: UIView!
    
    @IBOutlet weak var innerAnimation: AnimationView!
    
    @IBOutlet weak var contentTextLbl: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    var voucherMsg: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bgView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.titleLbl.text = "Hurry!"
        self.titleLbl.textColor = UIColor.white
        
        self.headerView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        self.headerView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        
        self.closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.closeBtn.tintColor = UIColor.white
        
        self.popupBgView.backgroundColor = UIColor.white
        self.popupBgView.cornerRadius = 10
        setShadow(view: self.popupBgView)
        
        self.contentTextLbl.text = voucherMsg
        self.contentTextLbl.font = UIFont.systemFont(ofSize: 14)
        self.contentTextLbl.textAlignment = .center
        
        // Configure innerAnimation
        innerAnimation.animation = Animation.named("TickAnimation")
        innerAnimation.loopMode = .loop

        // Play innerAnimation
        innerAnimation.play(fromProgress: 0,
                            toProgress: 1,
                            loopMode: LottieLoopMode.loop,
                            completion: { (finished) in
            if finished {
                print("Inner animation completed")
            } else {
                print("Inner animation cancelled")
            }
        })

        // Configure backgroundAnimation
        backgroundAnimation.animation = Animation.named("BackgroundParty")
        backgroundAnimation.loopMode = .loop

        // Play backgroundAnimation
        backgroundAnimation.play(fromProgress: 0,
                                 toProgress: 1,
                                 loopMode: LottieLoopMode.playOnce,
                                 completion: { (finished) in
            if finished {
                print("Background animation completed")
            } else {
                print("Background animation cancelled")
            }
        })

    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
