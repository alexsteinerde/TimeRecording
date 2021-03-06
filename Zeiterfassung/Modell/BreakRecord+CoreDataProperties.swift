//
//  BreakRecord+CoreDataProperties.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 30.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//
//

import Foundation
import CoreData


extension BreakRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreakRecord> {
        return NSFetchRequest<BreakRecord>(entityName: "BreakRecord")
    }

    @NSManaged public var start: Date
    @NSManaged public var end: Date?
    @NSManaged public var timeRecord: TimeRecord

}
