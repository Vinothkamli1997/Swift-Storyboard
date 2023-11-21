//
//  ToggleLoader.swift
//  EliteCake
//
//  Created by TechnoTackle on 02/08/23.
//

import Foundation
import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func toggleLoader(isLoading: Bool) {
        if !isLoading {
            DispatchQueue.main.async {
            aView = UIView(frame: self.view.bounds)
            aView?.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
            let ai = UIActivityIndicatorView(style: .whiteLarge)
            ai.center = aView!.center
            ai.startAnimating()
            aView?.addSubview(ai)
            self.view.addSubview(aView!)
            }
        }
    }
    
    func hideToggleLoader() {
        DispatchQueue.main.async {
            aView?.removeFromSuperview()
            aView = nil
        }
    }
}
