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
    
    private let editTaskView: EditTaskView
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(section: Int, index: Int, task: Task, delegate: EditTaskDelegate) {
        self.editTaskView = EditTaskView(section: section, index: index, task: task)
        editTaskView.delegate = delegate
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
        
        dismissKeyboard()
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
