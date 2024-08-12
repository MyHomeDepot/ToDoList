//
//  ViewContoller+TableView.swift
//  ToDoList
//
//  Created by LEO on 12.08.2024.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Configure Table View
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }
    
    // Height of cells
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    // Cell configure
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController")
        }
        cell.backgroundColor = .lightGray
        let caseItem = cases[indexPath.row]
        cell.configureCell(caseItem: caseItem)
        
        cell.cellCheck.tag = indexPath.row
        cell.cellCheck.addTarget(self, action: #selector(statusToggle(sender: )), for: .touchUpInside)
        
        cell.cellLabel.delegate = self
        cell.cellLabel.tag = indexPath.row
        cell.cellLabel.addTarget(self, action: #selector(changeLabel(sender: )), for: .editingDidEnd)
        
        cell.cellStateButton.tag = indexPath.row
        cell.cellStateButton.addTarget(self, action: #selector(customePicker(sender: )), for: .touchUpInside)
        
        return cell
    }
    
    // Remove case from table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            cases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
