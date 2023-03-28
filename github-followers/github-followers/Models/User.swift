//
//  User.swift
//  github-followers
//
//  Created by Sanket Pimple on 3/26/23.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var bio: String?
    var location: String?
    let publicRepos: Int
    let publicGists: Int
    let htmpUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
