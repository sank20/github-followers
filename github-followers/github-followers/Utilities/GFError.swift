//
//  GFError.swift
//  github-followers
//
//  Created by Sanket Pimple on 4/1/23.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unabletoComplete = "Unable to complete the request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToFavorite = "There was an error in adding the user to favorites"
    case alreadyInFavorite = "User already added in favorites"
}
