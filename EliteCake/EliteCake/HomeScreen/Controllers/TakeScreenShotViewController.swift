//
//  TakeScreenShotViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 17/07/23.
//

import UIKit
//import FirebaseCrashlytics

class TakeScreenShotViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var takeScreenShotBtn: UIButton!
    @IBOutlet weak var QrImage: UIImageView!
    @IBOutlet weak var qrBgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeBtn.tintColor = UIColor.black
        
        QrImage.image = UIImage(named: "GpayQr")
        
        takeScreenShotBtn.setTitle("Take Snapshot", for: .normal)
        takeScreenShotBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        takeScreenShotBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        qrBgView.backgroundColor = .white
        qrBgView.layer.cornerRadius = 20
        setShadow(view: qrBgView)
        
    }
    
    @IBAction func takeScreenshotBtnAction(_ sender: UIButton) {
        if let qrImage = UIImage(named: "GpayQr") {
            let activityViewController = UIActivityViewController(activityItems: [qrImage], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = UIImage(named: "GpayQr") else {
            return
        }
        
        // Save the image to the local gallery
        saveImageGallery(image)
    }
    
    func saveImageToGallery(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // Callback function after image is saved (or not)
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Error occurred while saving the image
            print("Error saving image: \(error.localizedDescription)")
        } else {
            // Image saved successfully
            print("Image saved successfully to gallery.")
            showShareSuccessMessage()
            
        }
    }
    
    func saveImageGallery(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Image save failed, handle the error if needed
            print("Image save error: \(error.localizedDescription)")
        } else {
            // Image saved successfully, show the success alert
            print("Image saved successfully.")
            showSaveSuccessAlert()
        }
    }
    
    func showShareSuccessMessage() {
        let alertController = UIAlertController(title: "Success", message: "Image shared successfully!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSaveSuccessAlert() {
        let alertController = UIAlertController(title: "Image Saved", message: "The image has been saved to your photo gallery.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the alert
        if let topViewController = UIApplication.shared.keyWindow?.visibleViewController {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIWindow {
    var visibleViewController: UIViewController? {
        if let rootViewController = self.rootViewController {
            var visibleViewController: UIViewController? = rootViewController
            while let presentedViewController = visibleViewController?.presentedViewController {
                visibleViewController = presentedViewController
                if let navigationController = presentedViewController as? UINavigationController {
                    visibleViewController = navigationController.visibleViewController
                } else if let tabBarController = presentedViewController as? UITabBarController {
                    visibleViewController = tabBarController.selectedViewController
                }
            }
            return visibleViewController
        }
        return nil
    }
}
