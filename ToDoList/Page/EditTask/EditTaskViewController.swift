//
//  TaskViewContoller.swift
//  ToDoList
//
//  Created by LEO on 14.10.2024.
//

import UIKit

protocol EditTaskDelegate: AnyObject {
    func changeTaskName(section: Int, index: Int, title: String)
    func changeTaskState(section: Int, index: Int, state: State)
}

class EditTaskViewController: UIViewController {
    
    weak var delegate: EditTaskDelegate?
    private let editTaskView = EditTaskView()
    
    var section: Int
    var index: Int
    var task: Task
    
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
        editTaskView.taskNameTextField.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .gray
        
        editTaskView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editTaskView)
        NSLayoutConstraint.activate([
            editTaskView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editTaskView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            editTaskView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            editTaskView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        
        editTaskView.taskNameTextField.addTarget(self, action: #selector(didChangeTaskName(sender: )), for: .editingDidEnd)
        editTaskView.taskNameTextField.text = task.getTitle()
        
        editTaskView.taskStateSegmentedControl.addTarget(self, action: #selector(didChangeTaskState(sender: )), for: .valueChanged)
        editTaskView.taskStateSegmentedControl.selectedSegmentIndex = task.getState().rawValue
        
        dismissKeyboard()
    }
    
    @objc func didChangeTaskState(sender: UISegmentedControl) {
        let selectedRow = sender.selectedSegmentIndex
        delegate?.changeTaskState(section: section, index: index, state: State.allCases[selectedRow])
    }
    
    @objc func didChangeTaskName(sender: UITextField) {
        if sender.text?.isEmpty == true {
            editTaskView.taskNameTextField.text = task.getTitle()
            showAlert()
        } else {
            task.setTitle(title: sender.text!)
            delegate?.changeTaskName(section: section, index: index, title: sender.text!)
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Task name cannot be empty",
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func dismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboardTouchOutside)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension EditTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
