//
//  StartButtonView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class StartButtonView: TimeRecordingButtonView {

    @IBAction func start(_ sender: Any) {
        (delegate as? StartTimeRecordingDelegate)?.startTimeRecording()
    }
}

protocol StartTimeRecordingDelegate: Delegate {
    func startTimeRecording()
}
