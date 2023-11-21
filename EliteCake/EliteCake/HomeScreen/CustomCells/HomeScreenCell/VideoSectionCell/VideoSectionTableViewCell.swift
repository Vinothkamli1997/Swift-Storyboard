//
//  VideoSectionTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 10/07/23.
//

import UIKit
import AVKit

protocol VideoTableViewCellDelegate: AnyObject {
    func addToCartButtonTapped(for row: Int)
}

class VideoSectionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var videoSectionCollectionView: UICollectionView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var subHesdingLbl: UILabel!

    weak var delegate: VideoTableViewCellDelegate?
     var row: Int = 0
    
    var videoList: [Video] = []
    var context: UIViewController?
    let addToCartButton = UIButton(type: .system)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        headingLbl.text = "Unbox Sweetness"
        headingLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        subHesdingLbl.text = "A cakes a day, make the day"
        subHesdingLbl.font = UIFont.boldSystemFont(ofSize: 18)
        subHesdingLbl.textColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        videoSectionCollectionView.register(VideoSectionCollectionViewCell.nib, forCellWithReuseIdentifier: "VideoSectionCollectionViewCell")
        videoSectionCollectionView.dataSource = self
        videoSectionCollectionView.delegate = self
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}


extension VideoSectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("videooooooo count \(videoList.count)")
        return videoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoSectionCollectionViewCell", for: indexPath) as? VideoSectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.thumbnailImage.sd_setImage(with: URL(string: videoList[indexPath.row].thumbnailImage), placeholderImage: UIImage(named: "no_image"))
        
        print("video thum image \(videoList[indexPath.row].thumbnailImage)")
        cell.cakeNameLbl.text = videoList[indexPath.row].dishName
        print("video cake name \(videoList[indexPath.row].dishName)")

        addToCartButton.tag = indexPath.row

        cell.playBtn.tag = indexPath.row
        cell.playBtn.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)

        return cell
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        let row = sender.tag
        print("selected row video \(row)")
        
        self.row = row
        
        guard row < videoList.count else {
            print("Invalid row")
            return
        }
        
        let videoURLString = videoList[row].video

        // Create a video player view controller
        let playerViewController = AVPlayerViewController()
        if let videoURL = URL(string: videoURLString) {
            let player = AVPlayer(url: videoURL)
            playerViewController.player = player
            
            // Add "Add to Cart" button
            addToCartButton.setTitle("CLICK TO ORDER", for: .normal)
            addToCartButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            addToCartButton.backgroundColor = UIColor.red
            addToCartButton.tintColor = UIColor.white
            addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
            
            playerViewController.contentOverlayView?.addSubview(addToCartButton)
            addToCartButton.translatesAutoresizingMaskIntoConstraints = false
            addToCartButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
            addToCartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            addToCartButton.trailingAnchor.constraint(equalTo: playerViewController.contentOverlayView!.trailingAnchor, constant: -10).isActive = true
            addToCartButton.trailingAnchor.constraint(equalTo: playerViewController.contentOverlayView!.trailingAnchor, constant: 0).isActive = true
            addToCartButton.bottomAnchor.constraint(equalTo: playerViewController.contentOverlayView!.bottomAnchor, constant: -140).isActive = true

            // Present the video player view controller
            if let topViewController = UIApplication.shared.keyWindow?.rootViewController?.topMostViewController() {
                topViewController.present(playerViewController, animated: true, completion: nil)
                player.play()
            } else {
                print("Unable to find top view controller")
            }
        } else {
            print("Invalid video URL")
        }
    }

    @objc func addToCartButtonTapped(_ sender: UIButton) {
        
        print("add to cart button tapped")
        guard let delegate = delegate else { return }
        delegate.addToCartButtonTapped(for: row)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 350)
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController? {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topMostViewController()
        }
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController?.topMostViewController()
        }
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topMostViewController()
        }
        return self
    }
}
