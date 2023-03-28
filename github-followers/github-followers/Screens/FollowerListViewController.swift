//
//  FollowerListViewController.swift
//  github-followers
//
//  Created by Sanket Pimple on 3/26/23.
//

import UIKit

class FollowerListViewController: UIViewController {

    enum Section {
        case main
    }
    
    var userName: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var page = 1
    var hasMorefollowers = true

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: userName, page: page)
        configureDataSource()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true) 
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseId)
        collectionView.delegate = self
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMorefollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user does not have any followers. Go follow them!!"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }

                self.updateData(on: self.followers)
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(titile: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
           
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseId, for: indexPath) as! FollowersCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

}

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMorefollowers else { return }
            page+=1
            getFollowers(username: userName, page: page)
        }
    }
}

extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterText = searchController.searchBar.text, !filterText.isEmpty else { return }
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filterText.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
    
}
