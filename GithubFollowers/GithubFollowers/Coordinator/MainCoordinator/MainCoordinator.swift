//
//  MainCoordinator.swift
//  GithubFollowers
//
//  Created by Tusher on 1/27/24.
//

import Foundation
import UIKit
class MainCoordinator : Coordinator {
    
    var rootViewController = UINavigationController()
    
    var rootTabbarController = UITabBarController()
    
    var favCoordinator = FavouriteTabCoordinator()
    
    var searchCoordinator = SearchTabCoordinator()
    
    var childCoordinators = [Coordinator]()
    
    init(){
        rootTabbarController.tabBar.isTranslucent = false
        rootTabbarController.tabBar.backgroundColor = .white
    }
    
    func start() {
        self.setupTabbar()
    }
    
    func setupTabbar(){
        
     
        
        searchCoordinator.start()
        let searchVC = searchCoordinator.rootViewController
        
        
        favCoordinator.start()
        let favVC = favCoordinator.rootViewController
        
       
        childCoordinators = [searchCoordinator , favCoordinator]
    
        rootTabbarController.viewControllers = [searchVC , favVC]
        
    }
    
}
