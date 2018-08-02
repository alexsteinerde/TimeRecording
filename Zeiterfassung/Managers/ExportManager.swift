//
//  ExportManager.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 01.08.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import Foundation

class ExportManager {
    static var seperator = ";"
    static var lineBreak = "\n"
    static func csv(forRecords records: [SimpleTimeRecord]) -> String {
        var file = String()
        let header = "Datum"+seperator+"Startzeit"+seperator+"Endzeit"+seperator+"Pausenzeit"+seperator+"Summe"
        
        let rows = records.map({ row(forRecord: $0) })
        
        
        file += header+lineBreak
        file += rows.joined(separator: lineBreak)
        return file
    }
    
    static func row(forRecord record: SimpleTimeRecord) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let date = formatter.string(from: record.date)
        let components: [String] = [date, record.startDate, record.endDate, String(record.pauseSeconds), String(record.totalTime)]
        return components.joined(separator: seperator)
    }
    
    static func save(content: String, toFilename filename: String) -> URL {
        
        let filepath = self.getDocumentsDirectory() + "/" + filename
        let fileURL = URL(fileURLWithPath: filepath)
        do {
            try content.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
        
        return fileURL
    }
    
    private static func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
