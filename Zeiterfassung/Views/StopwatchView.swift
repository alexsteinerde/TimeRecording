//
//  StopwatchView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class StopwatchView: UIView {

    @IBOutlet private weak var timeLabel: UILabel!
    
    
    private var seconds: Int = 0 {
        didSet {
            guard oldValue != seconds else { return }
            timeLabel.text = StopwatchView.textForLabel(fromSeconds: seconds)
        }
    }
    
    static func textForLabel(fromSeconds totalSeconds: Int) -> String {
        let hours = Int(totalSeconds / 3600)
        var remainder = Int(totalSeconds - hours * 3600)
        let minutes = Int(remainder / 60)
        remainder = Int(remainder - minutes * 60)
        let seconds = remainder
        
        return String(format: "%02d:%02d:%02d", hours,minutes,seconds)
    }
}
