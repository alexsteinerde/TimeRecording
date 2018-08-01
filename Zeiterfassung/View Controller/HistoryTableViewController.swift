//
//  HistoryTableViewController.swift
//  Zeiterfassung
//
//  Created by Alex Steiner on 01.08.18.
//  Copyright © 2018 Alex Steiner. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var records = [TimeRecordUIModel]()

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! RecordHistoryTableViewCell
        cell.record = record
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let record = records[indexPath.row]
        tableView.beginUpdates()
        TimeRecordingManager.delete(record: record)
        records = TimeRecordingManager.allRecords
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
