//
//  FavouriteTabCoordinator.swift
//  GithubFollowers
//
//  Created by Tusher on 1/26/24.
//

import Foundation
import UIKit

class FavouriteTabCoordinator : Coordinator {
    
    var rootViewController = UINavigationController()
    
    
    
    func start() {
        let FavViewController = FavouriteViewController()
        FavViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        FavViewController.title = "Favourites"
        self.rootViewController = UINavigationController(rootViewController: FavViewController)
    }
}
