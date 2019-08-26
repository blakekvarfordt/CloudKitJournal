//
//  EntryTableViewController.swift
//  CloudKitJournal
//
//  Created by Blake kvarfordt on 8/26/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func loadData() {
        EntryController.shared.fetchEntries { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryListCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailView" {
            guard let index = tableView.indexPathForSelectedRow, let destination = segue.destination as? EntryDetailViewController else { return }
            let entry = EntryController.shared.entries[index.row]
            destination.entry = entry
        }
    }
    

}
