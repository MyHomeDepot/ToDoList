//
//  TaskViewContoller.swift
//  ToDoList
//
//  Created by LEO on 14.10.2024.
//

import UIKit

protocol SelectedTaskDelegate: AnyObject {
    func changeTaskName(section: Int, index: Int, title: String)
    func changeTaskState(section: Int, index: Int, state: State)
}

class SelectedTaskViewController: UIViewController {
    
    weak var delegate: SelectedTaskDelegate?
    
    let section: Int
    let index: Int
    var task: Task
    
    var taskNameTextField: UITextField = {
        let result = UITextField()
        
        return result
    }()
    
    var taskStateSegmentedControl: UISegmentedControl = {
        var result = UISegmentedControl(items: State.allCases.map(\.rawValue))
        
        return result
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(section: Int, index: Int, task: Task) {
        self.section = section
        self.index = index
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configureTaskNameTextField()
        configureTaskStateSegmentedControl()
        viewLayout()
    }
    
    private func viewLayout() {
        view.addSubview(taskNameTextField)
        view.addSubview(taskStateSegmentedControl)
        
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        taskStateSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            taskNameTextField.widthAnchor.constraint(equalToConstant: 200),
            taskNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            taskStateSegmentedControl.topAnchor.constraint(equalToSystemSpacingBelow: taskNameTextField.bottomAnchor, multiplier: 1),
            taskStateSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
