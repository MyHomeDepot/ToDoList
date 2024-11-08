//
//  TaskListViewController+NavigationBar.swift
//  ToDoList
//
//  Created by LEO on 31.10.2024.
//

import UIKit

extension TaskListViewController {
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTaskAlert))
        navigationItem.rightBarButtonItem?.tintColor = .yellow
    }
    
    @objc private func showAddTaskAlert() {
        let result = UIAlertController(title: "Add case on the list", message: "", preferredStyle: .alert)
        
        result.addTextField {
            $0.addTarget(self, action: #selector(self.textFieldDidChangeInAlert(sender: )), for: .editingChanged)
        }
        
        let cancelAlertButton = UIAlertAction(title: "Cancel", style: .destructive)
        result.addAction(cancelAlertButton)
        
        let saveAlertButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let textFieldText = result.textFields?.first?.text {
                self.appendCase(title: textFieldText)
                self.taskListTableView.reloadData()
            }
        }
        saveAlertButton.isEnabled = false
        result.addAction(saveAlertButton)
        
        present(result, animated: true)
    }
    
    @objc private func textFieldDidChangeInAlert(sender: UITextField) {
        guard let alertVC = presentedViewController as? UIAlertController else {
            return
        }
        
        if let text = sender.text,
           let saveActionInAlert = alertVC.actions.last {
            saveActionInAlert.isEnabled = isValidTitle(text: text)
        }
    }
    
    @objc func isValidTitle(text: String) -> Bool {
        return !text.isEmpty
    }
    
    @objc private func appendCase(title: String) {
        let result = Task(title: title)
        taskDictionary[.toDo]?.insert(result, at: 0)
        taskListTableView.reloadData()
    }
}
