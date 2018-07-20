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

}

protocol StartTimeRecordingDelegate: class {
    func startTimeRecording()
}
