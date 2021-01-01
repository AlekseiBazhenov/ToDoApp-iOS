//
//  EntryViewController.swift
//  Tasks
//
//  Created by Aleksey Bazhenov on 01.01.2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        var tasks = UserDefaults().value(forKey: "tasks") as? [String] ?? []
        tasks.append(text)
        
        UserDefaults().setValue(tasks, forKey: "tasks")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }

}
