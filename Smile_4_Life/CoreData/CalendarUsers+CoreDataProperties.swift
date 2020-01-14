//
//  CalendarUsers+CoreDataProperties.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 10/14/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//
//

import Foundation
import CoreData


extension CalendarUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalendarUsers> {
        return NSFetchRequest<CalendarUsers>(entityName: "CalendarUsers")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String
    @NSManaged public var userID: UUID
    @NSManaged public var hygieneEvents: NSSet?
    @NSManaged public var notifications: NSSet?

}

// MARK: Generated accessors for hygieneEvents
extension CalendarUsers {

    @objc(addHygieneEventsObject:)
    @NSManaged public func addToHygieneEvents(_ value: HygieneEvents)

    @objc(removeHygieneEventsObject:)
    @NSManaged public func removeFromHygieneEvents(_ value: HygieneEvents)

    @objc(addHygieneEvents:)
    @NSManaged public func addToHygieneEvents(_ values: NSSet)

    @objc(removeHygieneEvents:)
    @NSManaged public func removeFromHygieneEvents(_ values: NSSet)

}

// MARK: Generated accessors for notifications
extension CalendarUsers {

    @objc(addNotificationsObject:)
    @NSManaged public func addToNotifications(_ value: Notifications)

    @objc(removeNotificationsObject:)
    @NSManaged public func removeFromNotifications(_ value: Notifications)

    @objc(addNotifications:)
    @NSManaged public func addToNotifications(_ values: NSSet)

    @objc(removeNotifications:)
    @NSManaged public func removeFromNotifications(_ values: NSSet)

}
