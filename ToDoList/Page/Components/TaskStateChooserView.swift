//
//  TaskStateChooserView.swift
//  ToDoList
//
//  Created by LEO on 28.10.2024.
//

import UIKit

class TaskStateChooserView: UIView {
    
    var task: Task?
    weak var delegate: EditTaskDelegate?
    
    private lazy var overlayView: UIView = {
        let result = UIView()
        result.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        
        return result
    }()
    
    private lazy var foarmStackView: UIStackView = {
        var result = UIStackView()
        result.axis = .vertical
        result.distribution = .equalSpacing
        
        return result
    }()
    
    private lazy var buttonStackView: UIStackView = {
        var result = UIStackView()
        result.axis = .horizontal
        result.spacing = 5
        result.distribution = .fillEqually
        result.translatesAutoresizingMaskIntoConstraints = false
        result.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return result
    }()
    
    private lazy var taskStatePickerView: UIPickerView = {
        let result = UIPickerView()
        result.backgroundColor = .white
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        result.delegate = self
        result.dataSource = self
        
        return result
    }()
    
    private lazy var saveStateButton: UIButton = {
        var result = UIButton()
        result.setTitle("Save", for: .normal)
        result.backgroundColor = .green
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        result.translatesAutoresizingMaskIntoConstraints = false
        result.addTarget(self, action: #selector(saveChange), for: .touchUpInside)
        
        return result
    }()
    
    private lazy var cancelFoarmButton: UIButton = {
        var result = UIButton()
        result.setTitle("Cancel", for: .normal)
        result.backgroundColor = .red
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        result.translatesAutoresizingMaskIntoConstraints = false
        result.addTarget(self, action: #selector(hideView), for: .touchUpInside)
        
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hideView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func hideView() {
        self.isHidden = true
    }
    
    @objc private func saveChange() {
        guard let task = task else { return }
        let selectedRow = taskStatePickerView.selectedRow(inComponent: 0)
        let state = State.allCases[selectedRow]
        delegate?.updateTaskState(task: task, state: state)
        NSLog("\(task.getTitle())")
        hideView()
    }
    
    private func setupView() {
        buttonStackView.addArrangedSubview(cancelFoarmButton)
        buttonStackView.addArrangedSubview(saveStateButton)
        
        foarmStackView.addArrangedSubview(taskStatePickerView)
        foarmStackView.addArrangedSubview(buttonStackView)
        
        addSubview(overlayView)
        overlayView.addSubview(foarmStackView)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        foarmStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            foarmStackView.widthAnchor.constraint(equalToConstant: 200),
            foarmStackView.heightAnchor.constraint(equalToConstant: 150),
            foarmStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            foarmStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: - UIPickerViewDelegate
extension TaskStateChooserView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return State.allCases[row].title
    }
}

// MARK: - UIPickerViewDataSource
extension TaskStateChooserView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return State.allCases.count
    }
}
