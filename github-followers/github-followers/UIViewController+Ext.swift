//
//  UIViewController+Ext.swift
//  github-followers
//
//  Created by Sanket Pimple on 3/26/23.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertOnMainThread(titile: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(alertTitle: titile, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
