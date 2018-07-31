//
//  TimeRecordingManager.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 31.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import Foundation

class TimeRecordingManager {
    private static var coreDataManager = CoreDataManager(modelName: "Model")
    
    class func start() {
        
    }
    
    class func pause() {
        
    }
    
    class func resume() {
        
    }
    
    class func stop() {
        
    }
    
    class var lastStartDate: Date? {
        return nil
    }
    
    class var isTodaysTimerRunning: Bool {
        return false
    }
    
    class var recordedSecondsToday: Int? {
        return nil
    }
}
