//
//  ContinueButtonView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class ContinueButtonView: TimeRecordingButtonView {

    @IBAction func `continue`(_ sender: Any) {
        (delegate as? ContinueTimeRecordingDelegate)?.continueTimeRecording()
    }
}

protocol ContinueTimeRecordingDelegate: Delegate {
    func continueTimeRecording()
}
