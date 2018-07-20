//
//  PauseAndStopButtonView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class PauseAndStopButtonView: TimeRecordingButtonView {


    @IBAction func pause(_ sender: Any) {
        (delegate as? PauseAndStopTimeRecordingDelegate)?.pauseTimeRecording()
    }
    
    @IBAction func stop(_ sender: Any) {
        (delegate as? PauseAndStopTimeRecordingDelegate)?.stopTimeRecording()
    }
}

protocol PauseAndStopTimeRecordingDelegate: Delegate {
    func pauseTimeRecording()
    func stopTimeRecording()
}
