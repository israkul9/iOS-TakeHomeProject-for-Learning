//
//  OnboardingCoordinator.swift
//  GithubFollowers
//
//  Created by Tusher on 1/26/24.
//


import UIKit
import SwiftUI

class OnboardingCoordinator : Coordinator {
    var rootViewController = UIViewController()
   
    
    func start() {
        let onboardingView = OnboardingView {
            print("Done tapped")
        }
        let viewController = UIHostingController(rootView: onboardingView)
        rootViewController = viewController
        
    }
}
