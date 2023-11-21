//
//  UIView+Extension.swift
//  EliteCakes
//
//  Created by TechnoTackleMac on 02/01/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
