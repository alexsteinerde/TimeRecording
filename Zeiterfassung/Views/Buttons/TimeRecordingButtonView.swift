//
//  TimeRecordingButtonView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 20.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

protocol Delegate: class {
}

protocol DelegateCaller: class {
    var delegate: Delegate? { get set }
}

class TimeRecordingButtonView: UIView, DelegateCaller {
    weak var delegate: Delegate?
    
}
