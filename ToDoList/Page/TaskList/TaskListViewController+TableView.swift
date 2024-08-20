//
//  ViewContoller+TableView.swift
//  ToDoList
//
//  Created by LEO on 12.08.2024.
//

import UIKit

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func configureTableView() {
        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        taskListTableView.allowsSelection = false
        taskListTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.getIdentifier())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return nil
        }
        
        let result = UIView(frame: CGRect(x: 0, y: 0, width: taskListTableView.frame.size.width, height: 35))
        
        let label = UILabel(frame: CGRect(x: 10, y: 4, width: result.frame.size.width, height: 35))
        label.text = getSection(index: section)
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25, weight: .light)
        
        result.addSubview(label)
        
        return result
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let result = UIView(frame: CGRect(x: 0, y: 0, width: taskListTableView.frame.size.width, height: 0))
        return result
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return TaskList.getTaskCount(in: "hold")
        } else {
            return TaskList.getTaskCount(in: "success")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return 0
        }
        return 35
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = tableView.dequeueReusableCell(withIdentifier: TaskCell.getIdentifier(), for: indexPath) as? TaskCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController")
        }
    
        result.backgroundColor = .lightGray
        
        var task: Task
        if indexPath.section == 0 {
            task = TaskList.getTaskByIndex(at: indexPath.row, in: "hold")
        } else {
            task = TaskList.getTaskByIndex(at: indexPath.row, in: "success")
        }
        result.configureCell(task: task)
        
        result.checkmarkButton.tag = indexPath.row
        result.checkmarkButton.section = indexPath.section
        result.checkmarkButton.addTarget(self, action: #selector(checkmarkButtonToggle(sender: )), for: .touchUpInside)
        
        result.taskNameTextField.delegate = self
        result.taskNameTextField.tag = indexPath.row
        result.taskNameTextField.section = indexPath.section
        result.taskNameTextField.addTarget(self, action: #selector(changeTaskName(sender: )), for: .editingDidEnd)
        
        result.taskStateButton.tag = indexPath.row
        result.taskStateButton.section = indexPath.section
        result.taskStateButton.addTarget(self, action: #selector(showTaskStatePicker(sender: )), for: .touchUpInside)
        
        return result
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            if indexPath.section == 0 {
                TaskList.removeTask(at: indexPath.row, in: "hold")
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                TaskList.removeTask(at: indexPath.row, in: "success")
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
}
