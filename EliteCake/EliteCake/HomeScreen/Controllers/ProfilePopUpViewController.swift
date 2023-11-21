//
//  ProfilePopUpViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 05/06/23.
//

import UIKit
import Lottie

protocol profilePopDelegate: AnyObject {
    func okBtnTapped(_ alert: ProfilePopUpViewController, alertTag: Int)
}

class ProfilePopUpViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancel: UIButton!

    @IBOutlet var bgview: UIView!
    @IBOutlet var popUpBgview: UIView!
    
    var popUpmessage: String = ""
    
    var context: UIViewController!
    weak var delegate: profilePopDelegate?
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
        
        contentLbl.text = popUpmessage
        contentLbl.textColor = UIColor(named: "Dark")
        
        okBtn.setTitle("Ok", for: .normal)
        okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        okBtn.tintColor = .black
        
        cancel.setTitle("Cancel", for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancel.tintColor = .black
    }
    
    @IBAction func okBtnAction(_ sender: UIButton) {
        delegate?.okBtnTapped(self, alertTag: 0)
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
