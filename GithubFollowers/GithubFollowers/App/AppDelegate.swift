//
//  AppDelegate.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 18/1/24.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

 var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = self.setupTabbar()
        window.makeKeyAndVisible()
        return true
    }
    
    
    func setupTabbar() -> UITabBarController{
        let tabbarController = UITabBarController()
        tabbarController.tabBar.isTranslucent = false
        let searchVC = self.setupSearchViewController()
        let favVC = self.setupFavouriteViewController()
        tabbarController.tabBar.backgroundColor = .yellow
        tabbarController.viewControllers = [searchVC , favVC]
        return tabbarController
    }
    
    func setupSearchViewController() -> UINavigationController {
        let searchVC =  SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchVC.title = "Search"
        return UINavigationController(rootViewController: searchVC)
    }
    
    func setupFavouriteViewController() -> UINavigationController {
        let favVC =  FavouriteViewController()
        favVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favVC.title = "Favourites"
        return  UINavigationController(rootViewController: favVC)
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GithubFollowers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

