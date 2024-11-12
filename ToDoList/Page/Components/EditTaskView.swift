//
//  EditTaskView.swift
//  ToDoList
//
//  Created by LEO on 05.11.2024.
//

import UIKit

class EditTaskView: UIView {
    
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
        result.isUserInteractionEnabled = false
        
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
        result.isUserInteractionEnabled = false
        
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
        stackView.addArrangedSubview(taskNameTextField)
        stackView.addArrangedSubview(taskStateSegmentedControl)
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
