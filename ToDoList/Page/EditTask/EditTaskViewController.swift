//
//  TaskViewContoller.swift
//  ToDoList
//
//  Created by LEO on 14.10.2024.
//

import UIKit

protocol EditTaskDelegate: AnyObject {
    func updateTaskStatus(task: Task)
    func updateTaskName(task: Task, title: String)
    func updateTaskState(task: Task, state: State)
    func updateTaskDeadline(task: Task, deadline: Date)
    func showChooserView(task: Task)
}

class EditTaskViewController: UIViewController {
    
    var isEditMode = false
    
    var task: Task
    weak var delegate: EditTaskDelegate?
    private let editTaskView = EditTaskView()
    private let arrowView = ArrowView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureEditTaskNavigationBar()
        setupView()
        
        editTaskView.taskNameTextField.delegate = self
        editTaskView.taskNameTextField.text = task.getTitle()
        editTaskView.taskStateSegmentedControl.selectedSegmentIndex = task.getState().rawValue
        editTaskView.deadlinePickerView.date = task.getDeadline()
    }
    
    private func setupView() {
        view.backgroundColor = .gray
        
        editTaskView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editTaskView)
        NSLayoutConstraint.activate([
            editTaskView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editTaskView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            editTaskView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            editTaskView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arrowView)
        NSLayoutConstraint.activate([
            arrowView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
            arrowView.bottomAnchor.constraint(equalTo: editTaskView.topAnchor, constant: -15),
            arrowView.widthAnchor.constraint(equalToConstant: 200),
            arrowView.heightAnchor.constraint(equalToConstant: 270),
        ])
        
        dismissKeyboard()
    }
    
    private func configureEditTaskNavigationBar() {
        navigationItem.title = task.getTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo,
                                                           target: self,
                                                           action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        isEditMode.toggle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: isEditMode ? .save : .edit,
                                                            target: self,
                                                            action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        if isEditMode {
            editTaskView.mainStackView.isUserInteractionEnabled = true
        } else {
            saveEditedTask()
        }
    }
    
    private func saveEditedTask() {
        guard let text = editTaskView.taskNameTextField.text, !text.isEmpty else {
            showAlert()
            editTaskView.taskNameTextField.text = task.getTitle()
            return
        }
        
        navigationItem.title = text
        
        editTaskView.mainStackView.isUserInteractionEnabled = false
        
        let selectedRow = editTaskView.taskStateSegmentedControl.selectedSegmentIndex
        delegate?.updateTaskState(task: task, state: State.allCases[selectedRow])
        delegate?.updateTaskName(task: task, title: text)
        delegate?.updateTaskDeadline(task: task, deadline: editTaskView.deadlinePickerView.date)
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