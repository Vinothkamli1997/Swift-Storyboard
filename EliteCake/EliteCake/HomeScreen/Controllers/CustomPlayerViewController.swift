//
//  CustomPlayerViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 17/07/23.
//

import UIKit
import AVKit

class CustomVideoPlayerViewController: UIViewController {
    
    private var playerLayer: AVPlayerLayer!
    
    @IBOutlet weak var player: AVPlayer!
    @IBOutlet weak var playButton: UIButton!
    
    private var playerViewController: AVPlayerViewController?

    var videoURLString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let videoURLString = videoURLString else {
            return
        }
        
        if let videoURL = URL(string: videoURLString) {
            player = AVPlayer(url: videoURL)
            
            playerViewController = AVPlayerViewController()
            playerViewController?.player = player
            
            if let playerViewController = playerViewController {
                present(playerViewController, animated: true) {
                    self.player?.play()
                }
            }
        } else {
            print("Invalid video URL")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player?.pause()
    }

    @objc func createOrderButtonTapped() {
        // Logic to create an order
        // ...
    }
}
