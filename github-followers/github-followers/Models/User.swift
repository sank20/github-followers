//
//  User.swift
//  github-followers
//
//  Created by Sanket Pimple on 3/26/23.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var bio: String?
    var location: String?
    var publicRepos: Int
    var publicGists: Int
    var htmpUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}