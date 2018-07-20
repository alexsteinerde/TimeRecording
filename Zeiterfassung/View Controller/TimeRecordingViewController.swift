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
        
        var view: TimeRecordingButtonView.Type {
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
    
    private var currentSeconds = 0
    private var savedSeconds = 0
    private var startDate = Date()
    
    typealias States = (current: State, old: State?)
    
    private var state: States = (.start, nil)
    private weak var currentStateView: UIView?
    private weak var stopwatchView: StopwatchView?
    private var timer: Timer?
    
    private func view(forState: State) -> UIView {
        let frame = CGRect(x: 0, y: view.frame.height/3*1, width: view.frame.width, height: view.frame.height/3*2)
        
        let viewType = forState.view
        let stateView = viewType.instanceFromNib() as! TimeRecordingButtonView
        stateView.delegate = self
        stateView.frame = frame
        return stateView
    }
    
    private func replace(oldStateWith newState: State) {
        let newStateView = view(forState: newState)
        self.view.addSubview(newStateView)
        currentStateView?.removeFromSuperview()
        currentStateView = newStateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replace(oldStateWith: state.current)
        let stopwatchView = createStopwatchView()
        self.stopwatchView = stopwatchView
        view.addSubview(stopwatchView)
    }
    
    private func createStopwatchView() -> StopwatchView {
        let stopwatch = StopwatchView.instanceFromNib() as! StopwatchView
        let frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height/3-64)
        stopwatch.frame = frame
        return stopwatch
    }
    
    private func createTimer() -> Timer {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            self.currentSeconds = Int(self.startDate.timeIntervalSinceNow) * -1
            self.stopwatchView?.seconds = self.currentSeconds + self.savedSeconds
        }
        return timer
    }
    
    private func startTimer() {
        startDate = Date()
        timer = createTimer()
    }
    
    private func stopTimer() {
        timer?.invalidate()
    }
}

extension TimeRecordingViewController: StartTimeRecordingDelegate {
    func startTimeRecording() {
        replace(oldStateWith: .running)
        startTimer()
    }
}

extension TimeRecordingViewController: PauseAndStopTimeRecordingDelegate {
    func pauseTimeRecording() {
        replace(oldStateWith: .pause)
        savedSeconds += currentSeconds
        stopTimer()
    }
    
    func stopTimeRecording() {
        replace(oldStateWith: .start)
        print(savedSeconds + currentSeconds)
    }
}

extension TimeRecordingViewController: ContinueTimeRecordingDelegate {
    func continueTimeRecording() {
        replace(oldStateWith: .running)
        startTimer()
    }
}
