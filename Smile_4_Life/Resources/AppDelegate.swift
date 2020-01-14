//
//  AppDelegate.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 2/17/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit
import CoreData

//extension UIView {
//  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    print("In UIView touchesBegan")
//    next?.touchesBegan(touches, with: event)
//  }
//}
//
//extension UIWindow {
//  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    print("In UIWindow touchesBegan")
//    next?.touchesBegan(touches, with: event)
//  }
//}

class CustomNavigationController: UITabBarController, UITabBarControllerDelegate {
  
//  let viewModelMainView = ViewModelMainView()
//  lazy var coreDataManager = CoreDataManager()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.delegate = self
    
    print("In Custom Navigation Controller")
//    _ = coreDataManager.mainContext
    
//    if let vc = viewControllers?[0] as? MainHomeViewController {
////      vc.viewModelMainView = ViewModelMainView()
////      vc.viewModelMainView.coreDataContext = coreDataManager
//    }
    
  }
  

  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    print("Selected view controller**************************\(viewController)")
  }
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
  var window: UIWindow?
//  lazy var coreDataManager = CoreDataManager.shared

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print("In didFinishLauchingWithOptions")
    
    print("Content Scale Factor: \((window?.contentScaleFactor, UIScreen.main.scale))")
    let userDefaultID = UserDefaults.standard
    if !userDefaultID.bool(forKey: kInitialUser) {
            print("No current User set")
      userDefaultID.set(false, forKey: kInitialUser)
      userDefaultID.set(kDefaultUserID, forKey: kCurrentCalendarUserID)
    }
   
    
    UINavigationBar.appearance().tintColor = .cpSlate
    UINavigationBar.appearance().backgroundColor = .cpLightBlue2
    UINavigationBar.appearance().barTintColor = .cpLightBlue2
    UINavigationBar.appearance().prefersLargeTitles = true
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cpSlate]
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cpSlate]
    
    let persistantViewModelMain = ViewModelMainView()

    if let tab = window?.rootViewController as? CustomNavigationController {
      for child in tab.viewControllers ?? [] {
        if let top = child as? PersistanceViewModelMain {
          top.set(stack: persistantViewModelMain)
        }
      }
    }
    
    return true
  }
  
//  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    print("In AppDelegate Class")
//  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    CoreDataManager.shared.saveContext()
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
//     Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
//    CoreDataManager.saveContext(<#T##CoreDataManager#>)
  }
  
  

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {

      let container = NSPersistentContainer(name: "Smile_4_Life")
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

