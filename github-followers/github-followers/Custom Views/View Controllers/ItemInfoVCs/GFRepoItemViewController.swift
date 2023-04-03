//
//  GFRepoItemViewController.swift
//  github-followers
//
//  Created by Sanket Pimple on 4/2/23.
//

import UIKit

class GFRepoItemViewController: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoView2.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")        
    }

}
