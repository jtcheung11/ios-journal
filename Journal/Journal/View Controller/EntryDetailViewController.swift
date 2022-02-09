//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Jonmichael Cheung on 2/8/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    @IBAction func clearAllButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else { return }
        if let entry = entry {
            print("\(entry.title) to be implemented tomorrow.")
        } else {
            EntryController.shared.createEntryWith(title: title, body: body)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
}
