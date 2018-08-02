//
//  TimeRecordingManager.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 31.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import Foundation
import CoreData

class TimeRecordingManager {
    private static var coreDataManager = CoreDataManager(modelName: "Model")
    
    class func start() {
        if let timeRecord = timeRecordForDate(date: Date()) {
            let breakRecord = BreakRecord(entity: NSEntityDescription.entity(forEntityName: "BreakRecord", in: coreDataManager.managedObjectContext)!, insertInto: coreDataManager.managedObjectContext)
            breakRecord.start = timeRecord.end!
            timeRecord.insertIntoBreaks(breakRecord, at: 0)
            timeRecord.end = nil
            try? coreDataManager.managedObjectContext.save()
            return resume()
        }
        let record = TimeRecord.init(entity: NSEntityDescription.entity(forEntityName: "TimeRecord", in: coreDataManager.managedObjectContext)!, insertInto: coreDataManager.managedObjectContext)
        record.start = Date()
        record.date = Date()
        try? coreDataManager.managedObjectContext.save()
    }
    
    class func pause() {
        guard let timeRecord = timeRecordForDate(date: Date()) else { return }
        let breakRecord = BreakRecord(entity: NSEntityDescription.entity(forEntityName: "BreakRecord", in: coreDataManager.managedObjectContext)!, insertInto: coreDataManager.managedObjectContext)
        breakRecord.start = Date()
        timeRecord.insertIntoBreaks(breakRecord, at: 0)
        try? coreDataManager.managedObjectContext.save()
    }
    
    class func resume() {
        guard let timeRecord = timeRecordForDate(date: Date()) else { return }
        (timeRecord.breaks?.firstObject as? BreakRecord)?.end = Date()
        try? coreDataManager.managedObjectContext.save()
    }
    
    class func stop() {
        guard let timeRecord = timeRecordForDate(date: Date()) else { return }
        timeRecord.end = Date()
        try? coreDataManager.managedObjectContext.save()
    }
    
    private class func timeRecordForDate(date: Date) -> TimeRecord? {
        let calendar = Calendar.current
        let dateFrom = calendar.startOfDay(for: date)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        
        let fetch: NSFetchRequest<TimeRecord> = TimeRecord.fetchRequest()
        fetch.predicate = NSPredicate(format: "date > %@ && date < %@", dateFrom as NSDate, dateTo! as NSDate)
        return (try? coreDataManager.managedObjectContext.fetch(fetch))?.first
    }
    
    class var lastStartDate: Date? {
        guard let timeRecord = timeRecordForDate(date: Date()) else { return nil }
        guard let breaks = timeRecord.breaks?.array as? [BreakRecord], breaks.count > 0 else { return timeRecord.start }
        if breaks.contains(where: { $0.end == nil }) {
            return nil
        }
        return breaks.filter({ $0.end != nil }).first?.start
    }
    
    class var lastBreakOrTimeStart: Date? {
        guard let timeRecord = timeRecordForDate(date: Date()) else { return nil }
        guard let breaks = timeRecord.breaks?.array as? [BreakRecord], breaks.count > 0 else { return timeRecord.start }
        return breaks.first?.start
    }
    
    class var isTodaysTimerRunning: Bool {
        guard let timeRecord = timeRecordForDate(date: Date()) else { return false }
        return timeRecord.end == nil
    }
    
    class var recordedSecondsToday: Int? {
        guard let timeRecord = timeRecordForDate(date: Date()) else { return nil }
        guard let lastStart = lastBreakOrTimeStart, let breaks = timeRecord.breaks?.array as? [BreakRecord], breaks.count > 0 else { return 0 }
        let secondsSinceStart = lastStart.timeIntervalSince(timeRecord.start)
        let a = breaks.filter({ $0.end != nil })
            .map({ $0.end!.timeIntervalSince($0.start) })
        let pauseTime = a.reduce(0, +)
        return Int(secondsSinceStart - pauseTime - 1)
    }
    
    class var allRecords: [SimpleTimeRecord] {
        let fetch: NSFetchRequest<TimeRecord> = TimeRecord.fetchRequest()
        let records = (try? coreDataManager.managedObjectContext.fetch(fetch))
        return (records ?? []).map({ SimpleTimeRecord(fromTimeRecord: $0) }).sorted(by: { $0.date > $1.date })
    }
    
    class func delete(record: SimpleTimeRecord) {
        coreDataManager.managedObjectContext.delete(record.record)
        try? coreDataManager.managedObjectContext.save()
    }
}

struct SimpleTimeRecord {
    var date: Date
    var startDate: String
    var endDate: String
    var pauseSeconds: Int
    var totalTime: String
    fileprivate var record: TimeRecord
}

extension SimpleTimeRecord {
    init(fromTimeRecord record: TimeRecord) {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        self.date = record.date
        self.startDate = formatter.string(from: record.start)
        self.endDate = formatter.string(from: record.end ?? Date())
        let seconds = (record.breaks?.array as? [BreakRecord])?.compactMap({ $0.end?.timeIntervalSince($0.start) }) ?? [0.0]
        self.pauseSeconds = Int(seconds.reduce(0, +))
        self.record = record
        let totalSeconds = Int((record.end ?? Date()).timeIntervalSince(record.start)) - self.pauseSeconds
        self.totalTime = StopwatchView.textForLabel(fromSeconds: totalSeconds)
    }
}
