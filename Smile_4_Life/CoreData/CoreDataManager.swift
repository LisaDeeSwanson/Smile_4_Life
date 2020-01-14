//
//  CoreDataManager.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/3/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
  
//  static let shared = CoreDataManager()
  
  lazy var mainContext: NSManagedObjectContext = {
    return self.persistentContainer.viewContext
  }()
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
  
  init() {
    print("In COREDATAMANAGER INIT++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
  }
  // MARK: - Core Data Saving support
  
  func saveContext () {
    guard mainContext.hasChanges else { return }
      do {
        try mainContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }

  }

  }


//***********************************************************************
// Remove before ship
class OTHERCoreDataManager {
  
  static let shared = CoreDataManager()
  var mainContext: NSManagedObjectContext
  var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Smile_4_Life")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  init() {    
    mainContext = self.persistentContainer.viewContext
  }
  // MARK: - Core Data Saving support
  
  func saveContext () {
    guard mainContext.hasChanges else { return }
    //    let context = persistentContainer.viewContext
    //    if context.hasChanges {
    do {
      try mainContext.save()
      //        try context.save()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    //    }
  }
  
}
// End Remove before ship
  

