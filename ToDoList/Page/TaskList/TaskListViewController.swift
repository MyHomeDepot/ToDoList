//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class TaskListViewController: UIViewController {
    
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
    
    enum TableSection: Int, CaseIterable {
        case toDo, inProgress, done
    }
    
    public var taskDictionary = [TableSection: [Task]]()
    
    public var activeSections: [TableSection] {
        return TableSection.allCases.filter { tableSection in
            taskDictionary[tableSection]?.isEmpty == false
        }
    }
    
    private var sourceTaskList: [Task] = [
        Task(title: "Jump from building"),
        Task(title: "Backflip", isCompleted: false, state: .inProgress),
        Task(title: "Meditation", isCompleted: false, state: .inProgress),
        Task(title: "Bomb the ball", isCompleted: true, state: .done)]
    
    private func sortData() {
        taskDictionary[.toDo] = sourceTaskList.filter({ $0.getState() == .toDo})
        taskDictionary[.inProgress] = sourceTaskList.filter({ $0.getState() == .inProgress})
        taskDictionary[.done] = sourceTaskList.filter({ $0.getState() == .done})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortData()
        configureNavigationBar()
        configureTableView()
        configurePickerView()
        viewLayout()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTaskAlert))
        navigationItem.rightBarButtonItem?.tintColor = .yellow
    }
    
    private func configureTableView() {
        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        taskListTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.getIdentifier())
    }
    
    private func configurePickerView() {
        taskStatePickerView.delegate = self
        taskStatePickerView.dataSource = self
        taskStatePickerView.reloadAllComponents()
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
    
    @objc public func isValidTitle(text: String) -> Bool {
        return !text.isEmpty
    }
    
    @objc private func appendCase(title: String) {
        let result = Task(title: title)
        taskDictionary[.toDo]?.insert(result, at: 0)
        taskListTableView.reloadData()
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
