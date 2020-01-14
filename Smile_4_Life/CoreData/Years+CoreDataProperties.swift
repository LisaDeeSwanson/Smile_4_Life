//
//  Years+CoreDataProperties.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 10/14/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//
//

import Foundation
import CoreData


extension Years {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Years> {
        return NSFetchRequest<Years>(entityName: "Years")
    }

    @NSManaged public var year: Int16
    @NSManaged public var hygieneEventYear: NSSet

}

// MARK: Generated accessors for hygieneEventYear
extension Years {

    @objc(addHygieneEventYearObject:)
    @NSManaged public func addToHygieneEventYear(_ value: HygieneEvents)

    @objc(removeHygieneEventYearObject:)
    @NSManaged public func removeFromHygieneEventYear(_ value: HygieneEvents)

    @objc(addHygieneEventYear:)
    @NSManaged public func addToHygieneEventYear(_ values: NSSet)

    @objc(removeHygieneEventYear:)
    @NSManaged public func removeFromHygieneEventYear(_ values: NSSet)

}
