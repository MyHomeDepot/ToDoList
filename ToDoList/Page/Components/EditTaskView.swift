//
//  EditTaskView.swift
//  ToDoList
//
//  Created by LEO on 05.11.2024.
//

import UIKit

class EditTaskView: UIView {
    
    let mainStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.distribution = .fillEqually
        result.spacing = 15
        result.isUserInteractionEnabled = false
        
        return result
    }()
    
    lazy var taskNameTextField: UITextField = {
        let result = UITextField()
        result.textAlignment = .center
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.backgroundColor = .lightGray
        result.layer.cornerRadius = 8
        result.layer.borderWidth = 1
        result.layer.borderColor = UIColor.white.cgColor
        
        return result
    }()
    
    lazy var taskStateSegmentedControl: UISegmentedControl = {
        var result = UISegmentedControl(items: State.allCases.map(\.title))
        result.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)],
                                      for: .normal
        )
        result.backgroundColor = .lightGray
        
        return result
    }()
    
    let deadlineStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillProportionally
        
        return result
    }()
    
    lazy var deadlineLabel: UILabel = {
        let result = UILabel()
        result.text = "Deadline"
        result.font = .systemFont(ofSize: 20, weight: .medium)
        
        return result
    }()
    
    lazy var deadlinePickerView: UIDatePicker = {
        let result = UIDatePicker()
        result.datePickerMode = .dateAndTime
        result.preferredDatePickerStyle = .compact
        result.minimumDate = Date()
        result.maximumDate = Date(timeIntervalSince1970: 1480366260)
        result.subviews.first?.subviews.first?.backgroundColor = .white
        result.subviews.first?.subviews.last?.backgroundColor = .white
        
        return result
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRectZero)
        setupView()
    }
    
    func setupView() {
        deadlineStackView.addArrangedSubview(deadlineLabel)
        deadlineStackView.addArrangedSubview(deadlinePickerView)
        
        mainStackView.addArrangedSubview(taskNameTextField)
        mainStackView.addArrangedSubview(taskStateSegmentedControl)
        mainStackView.addArrangedSubview(deadlineStackView)
        
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
