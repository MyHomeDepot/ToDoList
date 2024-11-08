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
    
    var taskDictionary = [State: [Task]]()
    
    var activeSections: [State] {
        return State.allCases.filter { tableSection in
            taskDictionary[tableSection]?.isEmpty == false
        }
    }
    
    private var sourceTaskList: [Task] = [
        Task(title: "Jump from building"),
        Task(title: "Backflip", isCompleted: false, state: .inProgress),
        Task(title: "Meditation", isCompleted: false, state: .inProgress),
        Task(title: "Bomb the ball", isCompleted: true, state: .done)]
    
    private func sortData() {
        taskDictionary[.toDo] = sourceTaskList.filter { $0.getState() == .toDo }
        taskDictionary[.inProgress] = sourceTaskList.filter { $0.getState() == .inProgress }
        taskDictionary[.done] = sourceTaskList.filter { $0.getState() == .done }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortData()
        configureNavigationBar()
        configureTableView()
        setupView()
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
}
