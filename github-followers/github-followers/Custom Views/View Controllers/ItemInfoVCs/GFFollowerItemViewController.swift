//
//  GFFollowerItemViewController.swift
//  github-followers
//
//  Created by Sanket Pimple on 4/2/23.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .followers, with: user.followers)
        itemInfoView2.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

}
