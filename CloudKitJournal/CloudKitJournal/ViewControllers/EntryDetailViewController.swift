//
//  EntryDetailViewController.swift
//  CloudKitJournal
//
//  Created by Blake kvarfordt on 8/26/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextField.text = entry.text
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, let body = bodyTextField.text else { return }
        let newEntry = Entry(title: title, text: body)
        EntryController.shared.save(entry: newEntry) { (_) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    @IBAction func clearFieldsButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextField.text = ""
    }
    
    @IBAction func mainViewTapped(_ sender: Any) {
        titleTextField.resignFirstResponder()
        bodyTextField.resignFirstResponder()
    }
    
}

extension EntryDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return titleTextField.resignFirstResponder()
    }
}
