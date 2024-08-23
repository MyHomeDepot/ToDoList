//
//  CustomCell.swift
//  ToDoList
//
//  Created by LEO on 06.08.2024.
//

import UIKit

class TaskCell: UITableViewCell {
    
    private static let identifier = "CustomCell"
    
    var checkmarkButton: UIButton = {
        let result = UIButton()
        result.setImage(UIImage(systemName: "questionmark"), for: .normal)
        
        return result
    }()
    
    var taskNameTextField: UITextField = {
        let result = UITextField()
        result.textColor = .label
        result.textAlignment = .left
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.text = "Error"
        result.allowsEditingTextAttributes = true
        
        return result
    }()
    
    var taskStateButton: UIButton = {
        let result = UIButton()
        result.layer.cornerRadius = 10
        result.titleLabel?.font = .italicSystemFont(ofSize: 14)
        
        return result
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func getIdentifier() -> String {
        return TaskCell.identifier
    }
    
    public func configureCell (task: Task) {
        checkmarkButton.setImage(UIImage(systemName: task.getStatus() ? "checkmark.square" : "square"), for: .normal)
        checkmarkButton.tintColor = .yellow
        
        taskNameTextField.text = task.getTitle()
        
        taskStateButton.setTitle("\(task.getEnumStateValue())", for: .normal)
        taskStateButton.tintColor = .label
        taskStateButton.backgroundColor = statusColor(task: task)
    }
    
    private func statusColor(task: Task) -> UIColor {
        switch task.getState() {
        case .toDo: return UIColor.darkGray
        case .done: return UIColor.green
        case .inProgress: return UIColor.orange
        }
    }
    
    private func cellViewLayout() {
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(taskNameTextField)
        contentView.addSubview(taskStateButton)
        
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        taskStateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkmarkButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            checkmarkButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 25),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 25),
            
            taskNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            taskNameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            taskNameTextField.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 15),
            taskNameTextField.trailingAnchor.constraint(equalTo: taskStateButton.trailingAnchor, constant: -50),
            
            taskStateButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskStateButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            taskStateButton.widthAnchor.constraint(equalToConstant: 70),
            taskStateButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
