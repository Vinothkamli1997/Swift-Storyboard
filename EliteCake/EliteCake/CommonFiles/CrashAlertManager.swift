//
//  CrashAlertManager.swift
//  EliteCake
//
//  Created by TechnoTackle on 06/09/23.
//

import Foundation
import UIKit

class CrashAlertManager {
    static func showCrashAlert(from viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Crash Detected",
            message: "The app has encountered a problem and needs to close. We apologize for the inconvenience.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            exit(0) // Terminate the app
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
