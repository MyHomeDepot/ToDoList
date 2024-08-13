//
//  ViewContoller+TableView.swift
//  ToDoList
//
//  Created by LEO on 12.08.2024.
//

import UIKit

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        taskListTableView.allowsSelection = false
        taskListTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cases.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController")
        }
        cell.backgroundColor = .lightGray
        let task = cases[indexPath.row]
        cell.configureCell(task: task)
        
        cell.checkmarkButton.tag = indexPath.row
        cell.checkmarkButton.addTarget(self, action: #selector(checkmarkButtonToggle(sender: )), for: .touchUpInside)
        
        cell.taskNameTextField.delegate = self
        cell.taskNameTextField.tag = indexPath.row
        cell.taskNameTextField.addTarget(self, action: #selector(changeTaskName(sender: )), for: .editingDidEnd)
        
        cell.taskStateButton.tag = indexPath.row
        cell.taskStateButton.addTarget(self, action: #selector(showTaskStatePicker(sender: )), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            cases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
