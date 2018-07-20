//
//  StartButtonView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class StartButtonView: UIView {

    weak var delegate: StartTimeRecordingDelegate?

    @IBAction func start(_ sender: Any) {
        delegate?.startTimeRecording()
    }
}

protocol StartTimeRecordingDelegate: class {
    func startTimeRecording()
}
