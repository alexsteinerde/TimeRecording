//
//  PauseAndStopButtonView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class PauseAndStopButtonView: UIView {

    weak var delegate: PauseAndStopTimeRecordingDelegate?

    @IBAction func pause(_ sender: Any) {
        delegate?.pauseTimeRecording()
    }
    
    @IBAction func stop(_ sender: Any) {
        delegate?.stopTimeRecording()
    }
}

protocol PauseAndStopTimeRecordingDelegate: class {
    func pauseTimeRecording()
    func stopTimeRecording()
}
