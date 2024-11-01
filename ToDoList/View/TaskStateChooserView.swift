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
    
    let overlayView: UIView = {
        let result = UIView()
        result.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    let foarmStackView: UIStackView = {
        var result = UIStackView()
        result.axis = .vertical
        result.distribution = .equalSpacing
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    let buttonStackView: UIStackView = {
        var result = UIStackView()
        result.axis = .horizontal
        result.spacing = 5
        result.distribution = .fillEqually
        result.translatesAutoresizingMaskIntoConstraints = false
        result.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return result
    }()
    
    var taskStatePickerView: UIPickerView = {
        let result = UIPickerView()
        result.backgroundColor = .white
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return result
    }()
    
    let saveStateButton: UIButton = {
        var result = UIButton()
        result.setTitle("Save", for: .normal)
        result.backgroundColor = .green
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        result.translatesAutoresizingMaskIntoConstraints = false
        result.addTarget(self, action: #selector(saveChange), for: .touchUpInside)
        return result
    }()
    
    let cancelFoarmButton: UIButton = {
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
        self.isHidden = true
        viewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideView() {
        self.isHidden = true
    }
    
    @objc func saveChange() {
        let selectedRow = taskStatePickerView.selectedRow(inComponent: 0)
        let selectedState = State.allCases[selectedRow]
        delegate?.changeTaskState(section: section!, index: index!, state: selectedState)
        hideView()
    }
    
    private func configureTaskStatePickerView() {
        taskStatePickerView.delegate = self
        taskStatePickerView.dataSource = self
        taskStatePickerView.reloadAllComponents()
    }
    
    func configureFoarmStackView() {
        foarmStackView.addArrangedSubview(taskStatePickerView)
        foarmStackView.addArrangedSubview(buttonStackView)
    }
    
    func configureButtonStackView() {
        buttonStackView.addArrangedSubview(cancelFoarmButton)
        buttonStackView.addArrangedSubview(saveStateButton)
    }
    
    func viewLayout() {
        configureTaskStatePickerView()
        configureFoarmStackView()
        configureButtonStackView()
        
        addSubview(overlayView)
        overlayView.addSubview(foarmStackView)
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
