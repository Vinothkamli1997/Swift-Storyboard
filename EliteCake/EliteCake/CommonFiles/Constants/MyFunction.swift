//
//  MyFunction.swift
//  EliteCake
//
//  Created by Apple - 1 on 06/01/23.
//

import UIKit
import CommonCrypto
import SystemConfiguration
import Lottie

func showSimpleAlert(view: UIViewController, message: String, title: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    // show the alert
    view.present(alert, animated: true, completion: nil)
}


func setShadow(view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    view.layer.shadowRadius = 3.0
    view.layer.masksToBounds = false
}

func setLightShadow(view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.4
    view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    view.layer.shadowRadius = 1.0
    view.layer.masksToBounds = false
}


//Set Custom Cornerradius
extension UIView {
    
    enum RoundCornersAt{
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }
    
    //multiple corners using CACornerMask
    func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [
            corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
            corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
            corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
            corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
        ]
    }
}

//Getting Image Url
extension UIImageView {
    func loadImage(_ url: String) {
        DispatchQueue.global(qos: .background) .async {
            DispatchQueue.main.async {
                guard let url = URL(string: url) else {
                    return
                }
                
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                self.image = UIImage(data: data)
            }
        }
    }
}

//Md5 Generate Auth Token
func md5(string: String) -> String {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    let messageData = string.data(using:.utf8)!
    var digestData = Data(count: length)
    
    _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
        messageData.withUnsafeBytes { messageBytes -> UInt8 in
            if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                let messageLength = CC_LONG(messageData.count)
                CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
            }
            return 0
        }
    }
    let hashString = digestData.map { String(format: "%02hhx", $0) }.joined()
    return hashString
}
//TextStrikeThroug String
extension String {

  /// Apply strike font on text
  func strikeThrough() -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    attributeString.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: 1,
      range: NSRange(location: 0, length: attributeString.length))

      return attributeString
     }
   }

func formatPriceWithStrikethrough(_ price: String) -> NSAttributedString {
    let priceString = HomeConstant.rupeesSym + price
    let attributedString = NSAttributedString(string: priceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    return attributedString
}


extension UIView {

    var x: CGFloat {
        get {
            self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    var height: CGFloat {
        get {
            self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }

    var width: CGFloat {
        get {
            self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
}


//Html COntent Parsing
extension String {
    var htmlAttributedString : NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html,.characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch{
           return nil
        }
    }
}


//View Wifth Hide
extension UIView {
    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutConstraint.Attribute = .height) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
}


//Toast Message Func
//extension UIViewController {
//    func showToast(message: String) {
//        let toastLabel = UILabel()
//        toastLabel.text = message
//        toastLabel.font = UIFont.boldSystemFont(ofSize: 16)
//        toastLabel.textColor = UIColor.white
//        toastLabel.textAlignment = .center
//        toastLabel.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10
//        toastLabel.clipsToBounds = true
//        toastLabel.numberOfLines = 0 // Allow multiple lines
//
//        let toastMaxWidth: CGFloat = self.view.frame.width - 40 // Maximum width of the toast
//        let toastMaxHeight: CGFloat = self.view.frame.height - 100 // Maximum height of the toast
//        let toastMaxSize = CGSize(width: toastMaxWidth, height: toastMaxHeight)
//        let toastTextSize = (message as NSString).boundingRect(with: toastMaxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: toastLabel.font!], context: nil)
//
//        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastTextSize.width / 2),
//                                  y: self.view.frame.height - 100 - toastTextSize.height,
//                                  width: min(toastTextSize.width + 20, toastMaxWidth),
//                                  height: min(toastTextSize.height + 10, toastMaxHeight))
//
//        self.view.addSubview(toastLabel)
//
//        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveLinear, animations: {
//            toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    }
//}


extension UIViewController {
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = UIFont.boldSystemFont(ofSize: 16)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0 // Allow multiple lines
        
        let toastMaxWidth: CGFloat = self.view.frame.width - 40 // Maximum width of the toast
        let toastMaxHeight: CGFloat = self.view.frame.height - 100 // Maximum height of the toast
        let toastMaxSize = CGSize(width: toastMaxWidth, height: toastMaxHeight)
        let toastTextSize = (message as NSString).boundingRect(with: toastMaxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: toastLabel.font!], context: nil)
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastTextSize.width / 2),
                                  y: self.view.frame.height - 100 - toastTextSize.height,
                                  width: min(toastTextSize.width + 20, toastMaxWidth),
                                  height: min(toastTextSize.height + 10, toastMaxHeight))
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveLinear, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}

extension UIViewController {
    func showToast1(message: String) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = UIFont.boldSystemFont(ofSize: 16)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.gray
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0 // Allow multiple lines
        
        let toastMaxWidth: CGFloat = self.view.frame.width - 40 // Maximum width of the toast
        let toastMaxHeight: CGFloat = self.view.frame.height - 100 // Maximum height of the toast
        let toastMaxSize = CGSize(width: toastMaxWidth, height: toastMaxHeight)
        let toastTextSize = (message as NSString).boundingRect(with: toastMaxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: toastLabel.font!], context: nil)
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastTextSize.width / 2),
                                  y: self.view.frame.height - 50 - toastTextSize.height,
                                  width: min(toastTextSize.width + 20, toastMaxWidth),
                                  height: min(toastTextSize.height + 10, toastMaxHeight))

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveLinear, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


//extension UIView {
//    func addDashedBorder() {
//        let color = UIColor.black.cgColor
//
//        let shapeLayer:CAShapeLayer = CAShapeLayer()
//        let frameSize = self.frame.size
//        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
//
//        shapeLayer.bounds = shapeRect
//        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = color
//        shapeLayer.lineWidth = 2
//        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
//        shapeLayer.lineDashPattern = [6,3]
//        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
//
//        self.layer.addSublayer(shapeLayer)
//    }
//}

//extension UIView {
//    func addDottedBorder() {
//        let color = UIColor.black.cgColor
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = color
//        shapeLayer.lineWidth = 1
//        shapeLayer.lineDashPattern = [4, 4]
//        shapeLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width + 30, height: self.frame.height)
//        shapeLayer.fillColor = nil
//
//        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width + 30, height: self.frame.height))
//        shapeLayer.path = path.cgPath
//
//        let borderView = UIView(frame: CGRect(x: -1, y: -1, width: self.frame.width + 2, height: self.frame.height + 2))
//        borderView.layer.insertSublayer(shapeLayer, at: 0)
//        borderView.layer.masksToBounds = true
//        self.addSubview(borderView)
//    }
//}

extension UIView {
    @discardableResult
    func addDashedBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat) -> CALayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [8, 8]
        shapeLayer.frame = CGRect(x: 0, y: 0, width: bounds.width + 30, height: bounds.height + 30)
        shapeLayer.fillColor = nil
        shapeLayer.lineCap = .round
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.addSublayer(shapeLayer)
        return shapeLayer
    }

}

extension UITextField {
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(self.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}


func checkInternetConnectivity() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)

    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }

    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }

    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)

    return (isReachable && !needsConnection)
}

func showAlert(message: String) {
    let alertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
    // Present the alert
    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
}

//Get App Version
extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    static var version: String {
        return "\(release).\(build)"
    }
}

func openSocialMediaURL(urlString: String) {
    guard let url = URL(string: urlString) else {
        return // Invalid URL
    }

    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        // Handle the case where the social media app is not installed
        // You can display an alert or fallback to a web view within your app
        print("Social media app not installed.")
    }
}

var loaderAnimationView: AnimationView?

func showCustomLoader(on view: UIView) {
    let animationView = AnimationView(name: "LottieLoader")
    animationView.loopMode = .loop
    animationView.contentMode = .scaleAspectFit
    animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    animationView.center = view.center
    
    view.addSubview(animationView)
    animationView.play()
    
    loaderAnimationView = animationView
}

func hideCustomLoader() {
    loaderAnimationView?.stop()
    loaderAnimationView?.removeFromSuperview()
    loaderAnimationView = nil
}
