//
//  NotificationsViewModel.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 1/7/19.
//  Copyright © 2019 Technology Speaks. All rights reserved.
//

import Foundation
import CoreData

class NotificationsModel {
  
  var coreDataContext: CoreDataManager!
  var fetchedCalendarUserResults: NSFetchedResultsController<Notifications>!
  let userDefaultsStandard = UserDefaults.standard
  
  func createNotification(calendarUser: CalendarUsers, time: Date, eventType: Int) {
    let time = DateHelpers.getTimeFromDate(time)
    let createNotification = Notifications(context: coreDataContext.mainContext)
    createNotification.owner = calendarUser
    createNotification.eventType = Int16(eventType)
    createNotification.time = time
    coreDataContext.saveContext()

  }
  
  func getAllNotifications(currentCalendarUser: CalendarUsers) -> [Notifications] {
    let fetchNotifications = NSFetchRequest<Notifications>(entityName: "Notifications")
    
    do {
      let predicateUser = NSPredicate(format: "owner.name == %@", currentCalendarUser.name as CVarArg)
      let andPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateUser])
      let notificationsTimeSort = NSSortDescriptor(key: #keyPath(Notifications.time), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
      fetchNotifications.sortDescriptors = [notificationsTimeSort]
      fetchNotifications.predicate = andPredicate
      let events = try coreDataContext.mainContext.fetch(fetchNotifications)
      return events
    } catch {
      let fetchError = error as NSError
      debugPrint(fetchError)
    }
    return []
    
  }
  
  func updateNotifications() {
    
  }
  
  func deleteNotification(currentCalendarUser: CalendarUsers, time: String, type: String) {
    let notificationToDelete = NSFetchRequest<Notifications>(entityName: "Notifications")
    let predicateUser = NSPredicate(format: "owner.name == %@", currentCalendarUser.name as CVarArg)
    let predicateEvent = NSPredicate(format: "time == %@", time as CVarArg)
    let andPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateUser, predicateEvent])
    notificationToDelete.predicate = andPredicate
    
    do {
      let events = try coreDataContext.mainContext.fetch(notificationToDelete)
      switch type {
      case "validate":
        print("Need to create an update function")
        updateNotifications()
      case "delete":
        for event in events {
          coreDataContext.mainContext.delete(event)
        }
        try coreDataContext.mainContext.save()
      default:
        print("Should not every be printing")
      }
    } catch {
      let fetchError = error as NSError
      debugPrint(fetchError)
    }
  }
}
