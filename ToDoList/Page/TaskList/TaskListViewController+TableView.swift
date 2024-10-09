//
//  ViewContoller+TableView.swift
//  ToDoList
//
//  Created by LEO on 12.08.2024.
//

import UIKit

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activeSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = activeSections[section]
        switch tableSection {
        case .toDo:
            return "HOLD"
        case .inProgress:
            return "ON THE GO"
        case .done:
            return "DONE"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableSection = activeSections[section]
        return taskDictionary[tableSection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.getIdentifier(), for: indexPath) as? TaskCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController")
        }
        
        cell.backgroundColor = .lightGray
        let tableSection = activeSections[indexPath.section]
        if let task = taskDictionary[tableSection]?[indexPath.row] {
            cell.configureCell(task: task)
            
            cell.checkmarkButton.tag = indexPath.row
            cell.checkmarkButton.section = indexPath.section
            cell.checkmarkButton.addTarget(self, action: #selector(checkmarkButtonAction(sender: )), for: .touchUpInside)
            
            cell.taskNameTextField.tag = indexPath.row
            cell.taskNameTextField.section = indexPath.section
            cell.taskNameTextField.addTarget(self, action: #selector(changeTaskName(sender: )), for: .editingDidEnd)
            
            cell.taskStateButton.tag = indexPath.row
            cell.taskStateButton.section = indexPath.section
            cell.taskStateButton.addTarget(self, action: #selector(showTaskStatePicker(sender: )), for: .touchUpInside)
        }
        return cell
    }
    
    @objc public func checkmarkButtonAction(sender: UIButton) {
        let index = sender.tag
        let section = sender.section
        
        let tableSection = activeSections[section]
        if var task = taskDictionary[tableSection]?[index] {
            task.toggleStatus()
            taskDictionary[tableSection]?.remove(at: index)
            
            if task.getStatus() == true {
                taskDictionary[.done]?.insert(task, at: 0)
            } else {
                taskDictionary[.toDo]?.insert(task, at: 0)
            }
        }
        taskListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let tableSection = activeSections[indexPath.section]
            taskDictionary[tableSection]?.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if self.taskDictionary[tableSection]?.isEmpty == true {
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .middle)
            }
            tableView.endUpdates()
        }
    }
}
