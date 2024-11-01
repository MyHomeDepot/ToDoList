//
//  SelectedTaskViewController+TextField.swift
//  ToDoList
//
//  Created by LEO on 16.10.2024.
//

import UIKit

extension SelectedTaskViewController: UITextFieldDelegate {
    
    @objc func configureTaskNameTextField() {
        taskNameTextField.delegate = self
        taskNameTextField.addTarget(self, action: #selector(didChangeTaskName(sender: )), for: .editingDidEnd)
        
        taskNameTextField.text = task.getTitle()
        taskNameTextField.textAlignment = .center
        taskNameTextField.font = .systemFont(ofSize: 20, weight: .medium)
        taskNameTextField.backgroundColor = .lightGray
        taskNameTextField.layer.cornerRadius = 15
        taskNameTextField.layer.borderWidth = 2
        taskNameTextField.layer.borderColor = UIColor.white.cgColor
        
        dismissKeyboard()
    }
    
    private func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didChangeTaskName(sender: UITextField) {
        if sender.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error",
                                          message: "Task name cannot be empty",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            
            present(alert, animated: true, completion: nil)
            taskNameTextField.text = task.getTitle()
        } else {
            task.setTitle(title: sender.text!)
            delegate?.changeTaskName(section: self.section, index: self.index, title: sender.text!)
        }
    }
}
