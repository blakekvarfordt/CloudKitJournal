//
//  EntryController.swift
//  CloudKitJournal
//
//  Created by Blake kvarfordt on 8/26/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    var entries: [Entry] = []
    
    let database = CKContainer.init(identifier: "iCloud.com.blakekvarfordt.CloudKitJournal").privateCloudDatabase
    
    func save(entry: Entry, completion: @escaping (Bool) -> Void) {
        let entry = entry
        let entryRecord = CKRecord(entry: entry)
        database.save(entryRecord) { (_, error) in
            
            if let error = error {
                print("ERROR with saving the entryRecord \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
        }
        self.entries.append(entry)
        completion(true)
        
    }
    
    func createEntry(with title: String, text: String, completion: @escaping (Bool) -> Void) {
        let newEntry = Entry(title: title, text: text)
        save(entry: newEntry) { (success) in
            
            if success {
                self.entries.append(newEntry)
                completion(true)
            } else {
                completion(false)
            }
        }
       
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryConstants.ckRecordTypeKey, predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("ERROR with saving the entryRecord \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else { return }
            let entries = records.compactMap({Entry(ckRecord: $0)})
            self.entries = entries
            completion(true)
        }
    }
}
