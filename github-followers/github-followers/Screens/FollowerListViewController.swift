//
//  FollowerListViewController.swift
//  github-followers
//
//  Created by Sanket Pimple on 3/26/23.
//

import UIKit

class FollowerListViewController: UIViewController {

    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(titile: "Error", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Followers.count=\(followers.count)")
            print(followers)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true) 
    }
}
