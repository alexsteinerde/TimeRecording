//
//  TimeRecordingViewController.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class TimeRecordingViewController: UIViewController {

    enum State {
        case start
        case running
        case pause
    }
    
    private var state: State = .start

}
