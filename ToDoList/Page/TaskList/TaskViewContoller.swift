//
//  TaskViewContoller.swift
//  ToDoList
//
//  Created by LEO on 14.10.2024.
//

import UIKit

protocol TaskViewDelegate: AnyObject {
    func changeTaskName(section: Int, index: Int, title: String)
}

class TaskViewContoller: UIViewController, UITextFieldDelegate {
    
    weak var delegate: TaskViewDelegate?
    
    let section: Int
    let index: Int
    let task: Task
    
    var taskNameTextField: UITextField = {
        let result = UITextField()
        result.textColor = .label
        result.textAlignment = .left
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.backgroundColor = .gray
        
        result.borderStyle = .roundedRect
        result.layer.masksToBounds = true
        result.layer.cornerRadius = 15.0
        result.layer.borderWidth = 2.0
        result.layer.borderColor = UIColor.white.cgColor
        
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
        viewLayout()
    }
    
    @objc func configureTaskNameTextField() {
        taskNameTextField.delegate = self
        taskNameTextField.text = task.getTitle()
        taskNameTextField.addTarget(self, action: #selector(didChangeTaskName(sender: )), for: .editingDidEnd)
        dismissKeyboard()
    }
    
    private func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didChangeTaskName(sender: UITextField) {
        delegate?.changeTaskName(section: self.section, index: self.index, title: sender.text!)
    }
    
    private func viewLayout() {
        view.addSubview(taskNameTextField)
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            taskNameTextField.widthAnchor.constraint(equalToConstant: 200),
            taskNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
