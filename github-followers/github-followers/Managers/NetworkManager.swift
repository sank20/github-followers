//
//  NetworkManager.swift
//  github-followers
//
//  Created by Sanket Pimple on 3/26/23.
//

import UIKit

// better to abstract out in a protocol
class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    private func loadData<T: Codable>(url: String, type: T.Type, completionHandler: @escaping (Result<T, GFError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unabletoComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(type, from: data)
                completionHandler(.success(data))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        task.resume()

    }
    
    func getFollowers(for username: String, page: Int, completionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        loadData(url: endpoint, type: [Follower].self, completionHandler: completionHandler)
    }
    
    func getUserInfo(for username: String, completionHandler: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "\(username)"
        loadData(url: endpoint, type: User.self, completionHandler: completionHandler)
    }
}
