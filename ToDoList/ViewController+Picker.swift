//
//  CustomPicker.swift
//  ToDoList
//
//  Created by LEO on 12.08.2024.
//

import UIKit

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    func configurePicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    }
    
    @objc func customePicker(sender: UIButton) {
        stateBar.barStyle = .default
        stateBar.isTranslucent = true
        stateBar.sizeToFit()

        // Adding Button stateBar
        let doneButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        cancelButton.tintColor = .red
        
        let title = UIBarButtonItem(title: "Progress", style: .plain, target: nil, action: nil)
        title.isEnabled = false
        
        stateBar.setItems([doneButton, spaceButton, title, spaceButton, cancelButton], animated: true)
        stateBar.isUserInteractionEnabled = true

        pickerView.tag = sender.tag
        
        self.stateBar.isHidden = false
        self.pickerView.isHidden = false
    }
    
    @objc func doneClick(sender: UIBarButtonItem) {
        pickerView.isHidden = true
        self.stateBar.isHidden = true
        
        let index = pickerView.tag
        let selectRow = pickerView.selectedRow(inComponent: 0)
        let selectedState = State.allCases[selectRow]
        
        cases[index].state = selectedState
        tableView.reloadData()
    }

    @objc func cancelClick() {
        pickerView.isHidden = true
        self.stateBar.isHidden = true
    }
}
