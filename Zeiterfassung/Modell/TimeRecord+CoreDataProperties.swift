//
//  TimeRecord+CoreDataProperties.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 30.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//
//

import Foundation
import CoreData


extension TimeRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeRecord> {
        return NSFetchRequest<TimeRecord>(entityName: "TimeRecord")
    }

    @NSManaged public var start: NSDate?
    @NSManaged public var end: NSDate?
    @NSManaged public var date: NSDate?
    @NSManaged public var breaks: NSOrderedSet?

}

// MARK: Generated accessors for breaks
extension TimeRecord {

    @objc(insertObject:inBreaksAtIndex:)
    @NSManaged public func insertIntoBreaks(_ value: BreakRecord, at idx: Int)

    @objc(removeObjectFromBreaksAtIndex:)
    @NSManaged public func removeFromBreaks(at idx: Int)

    @objc(insertBreaks:atIndexes:)
    @NSManaged public func insertIntoBreaks(_ values: [BreakRecord], at indexes: NSIndexSet)

    @objc(removeBreaksAtIndexes:)
    @NSManaged public func removeFromBreaks(at indexes: NSIndexSet)

    @objc(replaceObjectInBreaksAtIndex:withObject:)
    @NSManaged public func replaceBreaks(at idx: Int, with value: BreakRecord)

    @objc(replaceBreaksAtIndexes:withBreaks:)
    @NSManaged public func replaceBreaks(at indexes: NSIndexSet, with values: [BreakRecord])

    @objc(addBreaksObject:)
    @NSManaged public func addToBreaks(_ value: BreakRecord)

    @objc(removeBreaksObject:)
    @NSManaged public func removeFromBreaks(_ value: BreakRecord)

    @objc(addBreaks:)
    @NSManaged public func addToBreaks(_ values: NSOrderedSet)

    @objc(removeBreaks:)
    @NSManaged public func removeFromBreaks(_ values: NSOrderedSet)

}
