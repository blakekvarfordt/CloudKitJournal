//
//  Entry.swift
//  CloudKitJournal
//
//  Created by Blake kvarfordt on 8/26/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let ckRecordTypeKey = "Entry"
    static let titleKey = "title"
    static let textKey = "text"
    static let timestampKey = "timestamp"
    static let ckIdentifierKey = "ckRecordID"
}


class Entry {
    let title: String
    let text: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, text: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.ckRecordTypeKey, recordID: entry.ckRecordID)
        self.setValue(entry.timestamp, forKey: EntryConstants.timestampKey)
        self.setValue(entry.title, forKey: EntryConstants.titleKey)
        self.setValue(entry.text, forKey: EntryConstants.textKey)
    }
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        
        guard let title = ckRecord[EntryConstants.titleKey] as? String,
            let text = ckRecord[EntryConstants.textKey] as? String,
            let timestamp = ckRecord[EntryConstants.timestampKey] as? Date else { return nil}
        
        self.init(title: title, text: text, timestamp: timestamp, ckRecordID: ckRecord.recordID)
    }
}

