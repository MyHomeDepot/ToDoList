//
//  TaskStateChooserView.swift
//  ToDoList
//
//  Created by LEO on 28.10.2024.
//

import UIKit

class TaskStateChooserView: UIView {
    
    weak var delegate: SelectedTaskDelegate?
    
    var index: Int?
    var section: Int?
    
    let stackView = {
        var result = UIStackView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.axis = .vertical
        result.distribution = .fillEqually
        return result
    }()
    
    var taskStatePickerView: UIPickerView = {
        let result = UIPickerView()
        result.backgroundColor = .white
        result.layer.cornerRadius = 10
        return result
    }()
    
    let saveStateButton = {
        var result = UIButton()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.setTitle("Save", for: .normal)
        result.backgroundColor = .green
        result.layer.cornerRadius = 10
        result.addTarget(self, action: #selector(saveChange), for: .touchUpInside)
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        configureTaskStatePickerView()
        setupStack()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveChange() {
        let selectedRow = taskStatePickerView.selectedRow(inComponent: 0)
        let selectedState = State.allCases[selectedRow]
        delegate?.changeTaskState(section: section!, index: index!, state: selectedState)
        self.isHidden = true
    }
    
    private func configureTaskStatePickerView() {
        taskStatePickerView.delegate = self
        taskStatePickerView.dataSource = self
        taskStatePickerView.reloadAllComponents()
    }
    
    func setupStack() {
        stackView.addArrangedSubview(taskStatePickerView)
        stackView.addArrangedSubview(saveStateButton)
    }
    
    func setupView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension TaskStateChooserView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return State.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let value = State.allCases[row].rawValue
        let attributedString = NSAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        
        return attributedString
    }
}
