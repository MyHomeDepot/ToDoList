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
    
    let taskStateChooserView = TaskStateChooserView()
    
    var activeSections: [State] {
        return State.allCases.filter { state in
            tasks.contains { $0.getState() == state }
        }
    }
    
    var tasks: [Task] = [
        Task(title: "Jump from building"),
        Task(title: "Backflip", isCompleted: false, state: .inProgress),
        Task(title: "Meditation", isCompleted: false, state: .inProgress),
        Task(title: "Bomb the ball", isCompleted: true, state: .done)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMainNavigationBar()
        setupView()
        
        taskListTableView.delegate = self
        taskListTableView.dataSource = self
        taskListTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.getIdentifier())
        
        taskStateChooserView.delegate = self
    }
    
    private func setupView() {
        view.addSubview(taskListTableView)
        view.addSubview(taskStateChooserView)
        
        taskListTableView.translatesAutoresizingMaskIntoConstraints = false
        taskStateChooserView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            taskListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            taskStateChooserView.topAnchor.constraint(equalTo: view.topAnchor),
            taskStateChooserView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskStateChooserView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskStateChooserView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureMainNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAddTaskAlert))
        navigationItem.rightBarButtonItem?.tintColor = .yellow
    }
    
    @objc private func showAddTaskAlert() {
        let result = UIAlertController(title: "Add case on the list", message: "", preferredStyle: .alert)
        
        result.addTextField { $0.addTarget(self,
                                           action: #selector(self.textFieldDidChangeInAlert(sender: )),
                                           for: .editingChanged) }
        
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
        guard let alertVC = presentedViewController as? UIAlertController else { return }
        
        if let text = sender.text,
           let saveActionInAlert = alertVC.actions.last {
            saveActionInAlert.isEnabled = isValidTitle(text: text)
        }
    }
    
    @objc func isValidTitle(text: String) -> Bool {
        return !text.isEmpty
    }
    
    @objc private func appendCase(title: String) {
        let newTask = Task(title: title)
        tasks.insert(newTask, at: 0)
        taskListTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = activeSections[indexPath.section]
        let task = tasks.filter { $0.getState() == state }[indexPath.row]
        
        let vc = EditTaskViewController(task: task)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let state = activeSections[indexPath.section]
            let task = tasks.filter { $0.getState() == state }[indexPath.row]
            tasks.removeAll{ $0.getId() == task.getId() }
            taskListTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activeSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let state = activeSections[section]
        return tasks.filter { $0.getState() == state }.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let state = activeSections[section]
        return state.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.getIdentifier(), for: indexPath) as? TaskCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController")
        }
        
        let state = activeSections[indexPath.section]
        let task = tasks.filter { $0.getState() == state }[indexPath.row]
        cell.configureCell(task: task)
        cell.delegate = self
        
        return cell
    }
}
