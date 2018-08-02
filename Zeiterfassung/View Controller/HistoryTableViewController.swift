//
//  HistoryTableViewController.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 01.08.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class HistoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterButtonDidPress(_ sender: Any) {
        guard !self.view.subviews.contains(where: { $0 is MonthSelectionView}) else { return }
        let view = MonthSelectionView.instanceFromNib() as! MonthSelectionView
        view.setup()
        view.selectedFilterAction = { filter in
            if let filter = filter {
                self.records = filter.filter(records: TimeRecordingManager.allRecords)
            } else {
                self.records = TimeRecordingManager.allRecords
            }
            view.closeAction?()
            self.currentFilter = filter
            self.tableView.reloadData()
        }
        view.frame = CGRect(x: 0, y: (view.frame.height)/2, width: view.frame.width, height: view.frame.height/2)
        
        self.view.addSubview(view)
        self.view.bringSubview(toFront: view)
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var records = [SimpleTimeRecord]()
    var currentFilter: MonthFilterElement?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecordHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        records = TimeRecordingManager.allRecords
        tableView.reloadData()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! RecordHistoryTableViewCell
        cell.record = record
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let record = records[indexPath.row]
        tableView.beginUpdates()
        TimeRecordingManager.delete(record: record)
        records = TimeRecordingManager.allRecords
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
