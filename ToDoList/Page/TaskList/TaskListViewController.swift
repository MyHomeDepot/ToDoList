//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class TaskListViewController: UIViewController, UITextFieldDelegate {
    
    var taskListTableView: UITableView = {
        let result = UITableView()
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
    
    var cases: [Task] = [
        Task(title: "Jump from building"),
        Task(title: "Backflip"),
        Task(title: "Meditation"),
        Task(title: "Bomb the ball", isComplited: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        configurePickerView()
        viewLayout()
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTaskForm))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc func showAddTaskForm() {
        let alert = UIAlertController(title: "Add case on the list", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                self.appendCase(title: text)
            }
        }
        alert.addAction(saveButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        
        present (alert, animated: true)
    }
    
    @objc func appendCase(title: String) {
        cases.append(Task(title: title))
        taskListTableView.reloadData()
    }
    
    @objc func checkmarkButtonToggle(sender: UIButton) {
        let index = sender.tag
        cases[index].isComplited.toggle()
        taskListTableView.reloadData()
    }
    
    @objc func changeTaskName(sender: UITextField) {
        let index = sender.tag
        cases[index].title = sender.text!
        dismissKeyboard()
        taskListTableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
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
