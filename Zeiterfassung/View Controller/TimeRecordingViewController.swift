//
//  TimeRecordingViewController.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class TimeRecordingViewController: UIViewController {
    
    @IBAction func exportDidPressed(_ sender: Any) {
        guard !self.view.subviews.contains(where: { $0 is MonthSelectionView}) else { return }
        let view = MonthSelectionView.instanceFromNib() as! MonthSelectionView
        view.setup()
        view.deactivateButton.isHidden = false
        view.selectedFilterAction = { filter in
            view.closeAction?()
            guard let filter = filter else { return }
            let content = ExportManager.csv(forRecords: filter.filter(records: TimeRecordingManager.allRecords))
            let url = ExportManager.save(content: content, toFilename: filter.title+".csv")
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
            
            self.present(vc, animated: true)
        }
        view.frame = CGRect(x: 0, y: (view.frame.height)/2, width: view.frame.width, height: view.frame.height/2)
        
        self.view.addSubview(view)
        self.view.bringSubview(toFront: view)
    }
    
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
        if TimeRecordingManager.isTodaysTimerRunning {
            if let currentStartDate = TimeRecordingManager.lastStartDate, let savedSeconds = TimeRecordingManager.recordedSecondsToday {
                self.startDate = currentStartDate
                self.savedSeconds = savedSeconds
                self.currentSeconds = Int(self.startDate.timeIntervalSinceNow) * -1
                state.current = .running
                resumeTimer()
            } else if let savedSeconds = TimeRecordingManager.recordedSecondsToday {
                self.savedSeconds = savedSeconds
                state.current = .pause
            }
        }

        replace(oldStateWith: state.current)
        let stopwatchView = createStopwatchView()
        self.stopwatchView = stopwatchView
        view.addSubview(stopwatchView)
        if TimeRecordingManager.isTodaysTimerRunning {
            self.stopwatchView?.seconds = self.currentSeconds + self.savedSeconds
        }
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
    
    private func resumeTimer() {
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
        TimeRecordingManager.start()
    }
}

extension TimeRecordingViewController: PauseAndStopTimeRecordingDelegate {
    func pauseTimeRecording() {
        replace(oldStateWith: .pause)
        savedSeconds += currentSeconds
        stopTimer()
        TimeRecordingManager.pause()
    }
    
    func stopTimeRecording() {
        replace(oldStateWith: .start)
        print(savedSeconds + currentSeconds)
        TimeRecordingManager.stop()
        stopTimer()
    }
}

extension TimeRecordingViewController: ContinueTimeRecordingDelegate {
    func continueTimeRecording() {
        replace(oldStateWith: .running)
        startTimer()
        TimeRecordingManager.resume()
    }
}
