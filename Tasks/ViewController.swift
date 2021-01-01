//
//  ViewController.swift
//  Tasks
//
//  Created by Aleksey Bazhenov on 01.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadTasks()
    }
    
    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = { self.onDataUpdate() }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func loadTasks() {
        tasks.removeAll()
        
//        let savedTasks = UserDefaults().value(forKey: "tasks") ?? []
//        guard (savedTasks != nil) else {
//            return
//        }
        
        tasks = UserDefaults().value(forKey: "tasks") as? [String] ?? [] 
        tableView.reloadData()
    }
    
    private func onDataUpdate() {
        DispatchQueue.main.async {
            self.loadTasks()
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "Task Details"
        vc.currentTask = tasks[indexPath.row]
        vc.update = { self.onDataUpdate() }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
