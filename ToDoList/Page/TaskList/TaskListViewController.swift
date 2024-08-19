//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class TaskListViewController: UIViewController, UITextFieldDelegate {
    
    var taskListTableView: UITableView = {
        let result = UITableView(frame: .zero, style: .grouped)
        result.backgroundColor = .gray
        
        return result
    }()
    
    let taskStateBar: UIToolbar = {
        let result = UIToolbar()
        result.isHidden = true
        result.layer.masksToBounds = true
        result.layer.cornerRadius = 10
        result.barTintColor = .white
        
        return result
    }()
    
    var taskStatePickerView: UIPickerView = {
        let result = UIPickerView()
        result.isHidden = true
        result.layer.cornerRadius = 10
        
        return result
    }()
    
    var sections: [String] = ["Hold", "Success"]
    
    var sourceTaskList: [Task] = [
        Task(title: "Jump from building"),
        Task(title: "Backflip"),
        Task(title: "Meditation"),
        Task(title: "Bomb the ball", isComplited: true)]
    
    var uncompletedTaskList: [Task] = []
    var completedTaskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterSourceTaskList()
        configureNavigationBar()
        configureTableView()
        configurePickerView()
        viewLayout()
    }
    
    @objc func filterSourceTaskList() {
        uncompletedTaskList = sourceTaskList.filter { !$0.isComplited }
        completedTaskList = sourceTaskList.filter { $0.isComplited }
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTaskAlert))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc func showAddTaskAlert() {
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
    
    @objc func textFieldDidChangeInAlert(sender: UITextField) {
        guard let alertVC = presentedViewController as? UIAlertController else {
            return
        }
        
        if let text = sender.text,
           let saveActionInAlert = alertVC.actions.first {
            saveActionInAlert.isEnabled = isValidTitle(text: text)
        }
    }
    
    @objc func isValidTitle(text: String) -> Bool {
        return !text.isEmpty
    }
    
    @objc func appendCase(title: String) {
        let result = Task(title: title)
        uncompletedTaskList.append(result)
        taskListTableView.reloadData()
    }
    
    @objc func checkmarkButtonToggle(sender: UIButton) {
        let index = sender.tag
        
        if sender.section == 0 {
            uncompletedTaskList[index].isComplited.toggle()
            completedTaskList.append(uncompletedTaskList.remove(at: index))
        } else {
            completedTaskList[index].isComplited.toggle()
            uncompletedTaskList.append(completedTaskList.remove(at: index))
        }
        
        taskListTableView.reloadData()
    }
    
    @objc func changeTaskName(sender: UITextField) {
        let index = sender.tag
        
        if sender.section == 0 {
            uncompletedTaskList[index].title = sender.text!
        } else {
            completedTaskList[index].title = sender.text!
        }
        
        dismissKeyboard()
        taskListTableView.reloadData()
    }
    
    func textFieldShouldReturn(sender: UITextField) -> Bool {
        sender.resignFirstResponder()
        
        return true
    }
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    func viewLayout() {
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
