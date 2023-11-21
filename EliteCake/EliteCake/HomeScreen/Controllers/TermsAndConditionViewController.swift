//
//  TermsAndConditionViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 05/09/23.
//

import UIKit
import WebKit

class TermsAndConditionViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
        
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var mainView: UIView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the corner radius for the bgView
        bgView.layer.cornerRadius = 10 // Adjust the value as needed
        bgView.layer.masksToBounds = true // This is necessary to clip subviews to the rounded corners
        
        mainView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        // Create a UIButton for the top-leading corner
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        bgView.addSubview(backButton)
        
        // Create a centered UILabel
        let titleLabel = UILabel()
        titleLabel.text = "Terms and Conditions"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bgView.addSubview(titleLabel)
        
        // Create a WKWebView and add it as a subview
        webView = WKWebView()
        webView.navigationDelegate = self
        bgView.addSubview(webView)
        
        // Add Auto Layout constraints for the UIButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: bgView.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
        
        // Add Auto Layout constraints for the UILabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
        ])
        
        // Add Auto Layout constraints to position and size the webView
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            webView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            webView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor)
        ])
        
        openURL()
    }

    func openURL() {
        if let url = URL(string: "https://yumbox.in/terms.php") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func crashButtonTapped(_ sender: UIButton) {

        let numbers = [0]
        let _ = numbers[1]
    }
}
