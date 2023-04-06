//
//  PersistenceManager.swift
//  github-followers
//
//  Created by Sanket Pimple on 4/2/23.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

/**
 John 8 months ago
  "Enumerations with no cases are sometimes referred to as `uninhabited types` or
 `bottom types`. Benefit of using enum is that it can't accidentally be instantiated and works as a pure namespace. Although you could make the initializer of struct private to prevent initialization from it."
 */
enum PersistenceManager {

    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    retrievedFavorites.append(favorite)
                
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: retrievedFavorites))
            
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    // Instead of [Follower] we can return a Set of followers because a person cannot be in favorites twice
    static func retrieveFavorites(completed: @escaping (Result<[Follower],GFError>) -> Void) {
        guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoriteData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavs = try encoder.encode(favorites)
            defaults.set(encodedFavs, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
