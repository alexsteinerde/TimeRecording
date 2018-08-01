//
//  RecordHistoryTableViewCell.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 01.08.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class RecordHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var pauseTimeLabel: UILabel!
    
    fileprivate func load(_ record: TimeRecordUIModel) {
        startDateLabel.text = record.startDate
        endDateLabel.text = record.endDate
        pauseTimeLabel.text = "\(record.pauseSeconds) min"
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        dayLabel.text = formatter.string(from: record.date)
    }
    
    var record: TimeRecordUIModel? {
        didSet {
            guard let record = record else { return }
            load(record)
        }
    }
    
}
