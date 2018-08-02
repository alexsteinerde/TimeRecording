//
//  MonthSelectionView.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 13.07.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class MonthSelectionView: UIView {

    @IBAction func close(_ sender: Any) {
        closeAction?()
    }
    
    @IBAction func deactivateFilter(_ sender: Any) {
        selectedFilterAction?(nil)
    }
    
    var closeAction: (() -> Void)?
    
    var selectedFilterAction: ((_ filter: MonthFilterElement?) -> Void)?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deactivateButton: UIStackView!
    
    var records = [SimpleTimeRecord]()
    
    var months = [MonthFilterElement]()
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        closeAction = { self.removeFromSuperview() }
        records = TimeRecordingManager.allRecords
        let allMonths = records.map(MonthFilterElement.components(forRecord: ))
        months = Array(Set(allMonths))
        tableView.reloadData()
    }
}

struct MonthFilterElement: Hashable {
    var month: Int
    var year: Int
    
    func filter(records: [SimpleTimeRecord]) -> [SimpleTimeRecord] {
        return records.filter({ MonthFilterElement.components(forRecord: $0) == self })
    }
    
    static func components(forRecord record: SimpleTimeRecord) -> MonthFilterElement {
        let date = record.date
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        return MonthFilterElement(month: components.month!, year: components.year!)
    }
}

extension MonthFilterElement {
    var title: String {
        let components = DateComponents(year: year, month: month)
        let date = Calendar.current.date(from: components)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let text = formatter.string(from: date!)
        return text
    }
}

extension MonthSelectionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return months.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let month = months[indexPath.row]
        
        cell.textLabel?.text = month.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let month = months[indexPath.row]
        selectedFilterAction?(month)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
