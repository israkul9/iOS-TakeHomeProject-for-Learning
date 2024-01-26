//
//  ApplicationCoordinator.swift
//  GithubFollowers
//
//  Created by Tusher on 1/26/24.
//

import UIKit
import SwiftUI

class ApplicationCoordinator : Coordinator {
    
    var onboardingCoordinator = OnboardingCoordinator()
    var mainCoordinator = MainCoordinator()
    
    var childCoordinators = [Coordinator]()
    
    var window = UIWindow()
    
    init(window : UIWindow){
        self.window = window
    }
    
    func start() {
       
       showOnboarding()
        //self.showMainScreen()
    }
    
    
    func showOnboarding(){
        self.onboardingCoordinator.start()
        childCoordinators.append(onboardingCoordinator)
        self.window.rootViewController = self.onboardingCoordinator.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func showMainScreen(){
        self.mainCoordinator.start()
        self.childCoordinators.append(self.mainCoordinator)
        self.window.rootViewController = self.mainCoordinator.rootTabbarController
        self.window.makeKeyAndVisible()
        
    }
  
    
}
