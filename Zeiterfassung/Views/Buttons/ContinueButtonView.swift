//
//  ContinueButtonView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class ContinueButtonView: UIView {

    weak var delegate: ContinueTimeRecordingProtocol?

}

protocol ContinueTimeRecordingProtocol: class {
    func continueTimeRecording()
}
