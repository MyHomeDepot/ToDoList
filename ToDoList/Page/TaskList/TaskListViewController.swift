//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class TaskListViewController: UIViewController, UITextFieldDelegate {
    
    internal var taskListTableView: UITableView = {
        let result = UITableView(frame: .zero, style: .grouped)
        result.backgroundColor = .gray
        
        return result
    }()
    
    internal let taskStateBar: UIToolbar = {
        let result = UIToolbar()
        result.isHidden = true
        result.layer.masksToBounds = true
        result.layer.cornerRadius = 10
        result.barTintColor = .white
        
        return result
    }()
    
    internal var taskStatePickerView: UIPickerView = {
        let result = UIPickerView()
        result.isHidden = true
        result.layer.cornerRadius = 10
        
        return result
    }()
    
    private let sections: [String] = ["Hold", "Success"]
    
    private var sourceTaskList: [Task] = [
        Task(title: "Jump from building"),
        Task(title: "Backflip"),
        Task(title: "Meditation"),
        Task(title: "Bomb the ball", isCompleted: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskList.categorizeTasks(for: sourceTaskList)
        configureNavigationBar()
        configureTableView()
        configurePickerView()
        viewLayout()
    }
    
    public func getSection(index: Int) -> String {
        return sections[index]
    }
    
    public func getSectionCount() -> Int {
        return sections.count
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTaskAlert))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc private func showAddTaskAlert() {
        let result = UIAlertController(title: "Add case on the list", message: "", preferredStyle: .alert)
        
        result.addTextField {
            $0.addTarget(self, action: #selector(self.textFieldDidChangeInAlert(sender: )), for: .editingChanged)
        }
        
        let saveAlertButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let textFieldText = result.textFields?.first?.text {
                self.appendCase(title: textFieldText)
            }
        }
        saveAlertButton.isEnabled = false
        result.addAction(saveAlertButton)
        
        let cancelAlertButton = UIAlertAction(title: "Cancel", style: .destructive)
        result.addAction(cancelAlertButton)
        
        present(result, animated: true)
    }
    
    @objc private func textFieldDidChangeInAlert(sender: UITextField) {
        guard let alertVC = presentedViewController as? UIAlertController else {
            return
        }
        
        if let text = sender.text,
           let saveActionInAlert = alertVC.actions.first {
            saveActionInAlert.isEnabled = isValidTitle(text: text)
        }
    }
    
    @objc private func isValidTitle(text: String) -> Bool {
        return !text.isEmpty
    }
    
    @objc private func appendCase(title: String) {
        let result = Task(title: title)
        TaskList.appendTask(for: result, in: "hold")
        taskListTableView.reloadData()
    }
    
    @objc public func checkmarkButtonToggle(sender: UIButton) {
        let index = sender.tag
        
        if sender.section == 0 {
            TaskList.toggleStatus(at: index, in: "hold")
            TaskList.appendTask(for: TaskList.removeTask(at: index, in: "hold"), in: "success")
        } else {
            TaskList.toggleStatus(at: index, in: "success")
            TaskList.appendTask(for: TaskList.removeTask(at: index, in: "success"), in: "hold")
        }
        
        taskListTableView.reloadData()
    }
    
    @objc public func changeTaskName(sender: UITextField) {
        let index = sender.tag
        
        if sender.section == 0 {
            TaskList.changeTitle(at: index, on: sender.text!, in: "hold")
        } else {
            TaskList.changeTitle(at: index, on: sender.text!, in: "success")
        }
        
        dismissKeyboard()
        taskListTableView.reloadData()
    }
    
    private func textFieldShouldReturn(sender: UITextField) -> Bool {
        sender.resignFirstResponder()
        
        return true
    }
    
    private func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    private func viewLayout() {
        view.addSubview(taskListTableView)
        view.addSubview(taskStateBar)
        view.addSubview(taskStatePickerView)
        
        taskListTableView.translatesAutoresizingMaskIntoConstraints = false
        taskStateBar.translatesAutoresizingMaskIntoConstraints = false
        taskStatePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            taskListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            taskStateBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskStateBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            taskStateBar.widthAnchor.constraint(equalToConstant: 250),
            taskStateBar.heightAnchor.constraint(equalToConstant: 130),
            
            taskStatePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskStatePickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            taskStatePickerView.widthAnchor.constraint(equalToConstant: 250),
            taskStatePickerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
