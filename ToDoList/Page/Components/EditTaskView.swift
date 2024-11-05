//
//  EditTaskView.swift
//  ToDoList
//
//  Created by LEO on 05.11.2024.
//

import UIKit

class EditTaskView: UIView {
    
    weak var delegate: EditTaskDelegate?
    
    var section: Int
    var index: Int
    var task: Task
    
    let stackView: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.distribution = .fillEqually
        result.spacing = 10
        
        return result
    }()
    
    lazy var taskNameTextField: UITextField = {
        let result = UITextField()
        result.textAlignment = .center
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.backgroundColor = .lightGray
        result.layer.cornerRadius = 15
        result.layer.borderWidth = 2
        result.layer.borderColor = UIColor.white.cgColor
        result.addTarget(self, action: #selector(didChangeTaskName(sender: )), for: .editingDidEnd)
        result.text = task.getTitle()
        
        return result
    }()
    
    lazy var taskStateSegmentedControl: UISegmentedControl = {
        var result = UISegmentedControl(items: State.allCases.map(\.rawValue))
        result.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)],
            for: .normal
        )
        result.backgroundColor = .lightGray
        result.addTarget(self, action: #selector(didChangeTaskState(sender: )), for: .valueChanged)
        
        return result
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(section: Int, index: Int, task: Task) {
        self.section = section
        self.index = index
        self.task = task
        super.init(frame: CGRectZero)
        setupView()
    }
    
    @objc func didChangeTaskState(sender: UISegmentedControl) {
        let selectedRow = sender.selectedSegmentIndex
        delegate?.changeTaskState(section: section, index: index, state: State.allCases[selectedRow])
    }
    
    @objc func didChangeTaskName(sender: UITextField) {
        if sender.text?.isEmpty == true {
            taskNameTextField.text = task.getTitle()
            //showAlert()
        } else {
            task.setTitle(title: sender.text!)
            delegate?.changeTaskName(section: section, index: index, title: sender.text!)
        }
    }
    
//    private func showAlert() {
//        let alert = UIAlertController(
//            title: "Error",
//            message: "Task name cannot be empty",
//            preferredStyle: .alert)
//        
//        alert.addAction(
//            UIAlertAction(
//                title: "OK",
//                style: .default,
//                handler: nil
//            ))
//        
//        present(alert, animated: true, completion: nil)
//    }
    
    func setupView() {
        stackView.addArrangedSubview(taskNameTextField)
        stackView.addArrangedSubview(taskStateSegmentedControl)

        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        switch task.getState() {
        case .toDo: taskStateSegmentedControl.selectedSegmentIndex = 0
        case .inProgress: taskStateSegmentedControl.selectedSegmentIndex = 1
        case .done: taskStateSegmentedControl.selectedSegmentIndex = 2
        }
    }
}
