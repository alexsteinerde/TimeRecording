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
        
        var view: UIView.Type {
            switch self {
            case .start:
                return StartButtonView.self
            case .running:
                return PauseAndStopButtonView.self
            case .pause:
                return ContinueButtonView.self
            }
        }
    }
    
    typealias States = (current: State, old: State?)
    
    private var state: States = (.start, nil)
    private weak var currentStateView: UIView?
    
    private func view(forState: State) -> UIView {
        let frame = CGRect(x: 0, y: view.frame.height/3*1, width: view.frame.width, height: view.frame.height/3*2)
        
        let viewType = state.current.view
        let stateView = viewType.instanceFromNib()
        stateView.frame = frame
        return stateView
    }
    
    func replace(oldStateWith newState: State) {
        let newStateView = view(forState: newState)
        self.view.addSubview(newStateView)
        currentStateView?.removeFromSuperview()
        currentStateView = newStateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replace(oldStateWith: state.current)
    }
}
