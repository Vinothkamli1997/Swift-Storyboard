//
//  ApplyCouponAnimationViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/05/23.
//

import UIKit
import Lottie

class ApplyCouponAnimationViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet var bgview: UIView!
    
    @IBOutlet weak var animationBgView: UIView!
    
    @IBOutlet weak var animationHeaderView: UIView!
    
    var voucherMsg: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bgview.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.closeBtn.tintColor = UIColor.white
        
        self.animationBgView.backgroundColor = UIColor.white
        self.animationBgView.layer.cornerRadius = 10
        setShadow(view: self.animationBgView)
        
        
        self.titleLbl.text = "Hurry!"
        self.titleLbl.textColor = UIColor.white
        
        self.contentLbl.text = voucherMsg
        self.contentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.animationHeaderView.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        self.animationView.animation = Animation.named("TickAnimation")
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
        
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
