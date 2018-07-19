//
//  ZeiterfassungTests.swift
//  ZeiterfassungTests
//
//  Created by Alex Steiner on 19.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import XCTest
@testable import Zeiterfassung

class ZeiterfassungTests: XCTestCase {
    
    func testStopwatchString() {
        XCTAssertEqual(StopwatchView.textForLabel(fromSeconds: 0), "00:00:00")
        XCTAssertEqual(StopwatchView.textForLabel(fromSeconds: 1), "00:00:01")
        XCTAssertEqual(StopwatchView.textForLabel(fromSeconds: 60), "00:01:00")
        XCTAssertEqual(StopwatchView.textForLabel(fromSeconds: 61), "00:01:01")
        XCTAssertEqual(StopwatchView.textForLabel(fromSeconds: 3599), "00:59:59")
        XCTAssertEqual(StopwatchView.textForLabel(fromSeconds: 3600), "01:00:00")
        XCTAssertEqual(StopwatchView.textForLabel(fromSeconds: 3661), "01:01:01")
    }
    
}
