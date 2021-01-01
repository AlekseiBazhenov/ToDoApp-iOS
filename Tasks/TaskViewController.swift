//
//  TaskViewController.swift
//  Tasks
//
//  Created by Aleksey Bazhenov on 01.01.2021.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    var currentTask: String?
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = currentTask
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        let tasks = UserDefaults().value(forKey: "tasks") as! [String]
        var newList = [String]()
        
        for task in tasks {
            if (task != currentTask) {
                newList.append(task)
            }
        }
        
        UserDefaults().setValue(newList, forKey: "tasks")

        update?()
        
        navigationController?.popViewController(animated: true)
    }

}
