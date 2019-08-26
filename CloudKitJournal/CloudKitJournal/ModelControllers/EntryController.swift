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
    
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    let database = CKContainer(identifier: "iCloud.com.blakekvarfordt.CloudKitJournal").privateCloudDatabase
    
    func save(entry: Entry, completion: @escaping (Bool) -> Void) {
        let entry = entry
        let entryRecord = CKRecord(entry: entry)
        database.save(entryRecord) { (record, error) in
            
            if let error = error {
                print("ERROR with saving the entryRecord \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let record = record else { return }
            guard let entry = Entry(ckRecord: record) else { return }
            self.entries.append(entry)
            completion(true)
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
