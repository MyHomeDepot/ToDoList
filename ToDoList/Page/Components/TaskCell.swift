//
//  CustomCell.swift
//  ToDoList
//
//  Created by LEO on 06.08.2024.
//

import UIKit

class TaskCell: UITableViewCell {
    
    private var task: Task?
    weak var delegate: EditTaskDelegate?
    
    private static let identifier = "CustomCell"
    
    var checkmarkButton: UIButton = {
        let result = UIButton()
        return result
    }()
    
    var taskNameLabel: UILabel = {
        let result = UILabel()
        result.textColor = .label
        result.font = .systemFont(ofSize: 20, weight: .medium)
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
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func getIdentifier() -> String {
        return TaskCell.identifier
    }
    
    public func configureCell (task: Task) {
        self.backgroundColor = .lightGray
        self.task = task
        
        checkmarkButton.setImage(UIImage(systemName: task.getStatus() ? "checkmark.square" : "square"), for: .normal)
        checkmarkButton.tintColor = .yellow
        checkmarkButton.addTarget(self, action: #selector(checkmarkButtonAction), for: .touchUpInside)
        
        taskNameLabel.text = task.getTitle()
        
        taskStateButton.setTitle("\(task.getState().title)", for: .normal)
        taskStateButton.tintColor = .label
        taskStateButton.backgroundColor = statusColor(task: task)
        taskStateButton.addTarget(self, action: #selector(showChooser), for: .touchUpInside)
    }
    
    @objc private func checkmarkButtonAction() {
        guard let task = task else { return }
        delegate?.updateTaskStatus(task: task)
    }
    
    @objc private func showChooser() {
        guard let task = task else { return }
        
        //delegate?.
    }
    
    private func statusColor(task: Task) -> UIColor {
        switch task.getState() {
        case .toDo: return UIColor.darkGray
        case .done: return UIColor.green
        case .inProgress: return UIColor.orange
        }
    }
    
    private func setupView() {
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(taskStateButton)
        
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskStateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkmarkButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            checkmarkButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 25),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 25),
            
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            taskNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 10),
            taskNameLabel.trailingAnchor.constraint(equalTo: taskStateButton.leadingAnchor, constant: -10),
            
            taskStateButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskStateButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            taskStateButton.widthAnchor.constraint(equalToConstant: 70),
            taskStateButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
