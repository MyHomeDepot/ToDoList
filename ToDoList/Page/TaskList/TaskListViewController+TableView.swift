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
        return TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return nil
        }
        
        let result = UIView(frame: CGRect(x: 0, y: 0, width: taskListTableView.frame.size.width, height: 35))
        
        let sectionLabel = UILabel(frame: CGRect(x: 10, y: 4, width: result.frame.size.width, height: 35))
        
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .toDo:
                sectionLabel.text = "HOLD"
            case .inProgress:
                sectionLabel.text = "ON THE GO"
            case .done:
                sectionLabel.text = "DONE"
            }
        }
        
        sectionLabel.textColor = .secondaryLabel
        sectionLabel.textAlignment = .left
        sectionLabel.font = .systemFont(ofSize: 18, weight: .light)
        
        result.addSubview(sectionLabel)
        
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
        if let tableSection = TableSection(rawValue: section), let list = taskDictionary[tableSection] {
            return list.count
        }
        return 0
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.getIdentifier(), for: indexPath) as? TaskCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController")
        }
        
        cell.backgroundColor = .lightGray
        
        if let tableSection = TableSection(rawValue: indexPath.section), let list = taskDictionary[tableSection] {
            let task = list[indexPath.row]
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
        checkmarkToggle(at: sender.tag, for: sender.section)
        taskListTableView.reloadData()
    }
    
    func checkmarkToggle(at index: Int, for section: Int) {
        if let tableSection = TableSection(rawValue: section) {
            var result = taskDictionary[tableSection]?[index]
            result!.toggleStatus()
            taskDictionary[tableSection]?.remove(at: index)
            
            if result!.getStatus() == true {
                taskDictionary[.done]!.insert(result!, at: 0)
            } else {
                taskDictionary[.toDo]!.insert(result!, at: 0)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            if let tableSection = TableSection(rawValue: indexPath.section) {
                taskDictionary[tableSection]?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                taskListTableView.reloadData()
            }
        }
    }
}
