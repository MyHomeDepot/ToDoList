//
//  CustomPicker.swift
//  ToDoList
//
//  Created by LEO on 12.08.2024.
//

import UIKit

extension TaskListViewController: UIPickerViewDelegate {
    
    @objc func showTaskStatePicker(sender: UIButton) {
        taskStateBar.barStyle = .default
        taskStateBar.isTranslucent = true
        taskStateBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        cancelButton.tintColor = .red
        
        let title = UIBarButtonItem(title: "Progress", style: .plain, target: nil, action: nil)
        title.isEnabled = false
        
        taskStateBar.setItems([doneButton, spaceButton, title, spaceButton, cancelButton], animated: true)
        taskStateBar.isUserInteractionEnabled = true
        
        taskStatePickerView.tag = sender.tag
        taskStatePickerView.section = sender.section
        
        taskStateBar.isHidden = false
        taskStatePickerView.isHidden = false
    }
    
    @objc private func doneClick() {
        taskStatePickerView.isHidden = true
        taskStateBar.isHidden = true
        
        let index = taskStatePickerView.tag
        let section = taskStatePickerView.section
        
        let selectedRow = taskStatePickerView.selectedRow(inComponent: 0)
        let selectedState = State.allCases[selectedRow]
        
        changeTaskState(section: section, index: index, state: selectedState)
        taskListTableView.reloadData()
    }
    
    @objc func cancelClick() {
        taskStatePickerView.isHidden = true
        taskStateBar.isHidden = true
    }
}


extension TaskListViewController: UIPickerViewDataSource {
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
