//
//  HygieneEvents+CoreDataProperties.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 10/14/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//
//

import Foundation
import CoreData


extension HygieneEvents {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HygieneEvents> {
        return NSFetchRequest<HygieneEvents>(entityName: "HygieneEvents")
    }

    @NSManaged public var date: Date
    @NSManaged public var eventType: Int16
    @NSManaged public var owner: CalendarUsers
    @NSManaged public var yearOfEvent: Years

}
