//
//  SearchTabCoordinator.swift
//  GithubFollowers
//
//  Created by Tusher on 1/27/24.
//

import Foundation
import UIKit


class SearchTabCoordinator : Coordinator {
    
    var rootViewController = UINavigationController()
    
    
    
    func start() {
        let SearchViewController = SearchViewController()
        SearchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        SearchViewController.title = "Search"
        self.rootViewController = UINavigationController(rootViewController: SearchViewController)
    }
}

