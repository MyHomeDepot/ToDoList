//
//  SelectedTaskViewController+SegmentedControl.swift
//  ToDoList
//
//  Created by LEO on 16.10.2024.
//

import UIKit

extension SelectedTaskViewController {
    
    func configureTaskStateSegmentedControl() {
        taskStateSegmentedControl.addTarget(self, action: #selector(didChangeTaskState(sender: )), for: .valueChanged)
        taskStateSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.label,
                                                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)], for: .normal)
        switch task.getState() {
        case .toDo: taskStateSegmentedControl.selectedSegmentIndex = 0
        case .inProgress: taskStateSegmentedControl.selectedSegmentIndex = 1
        case .done: taskStateSegmentedControl.selectedSegmentIndex = 2
        }
    }
    
    @objc func didChangeTaskState(sender: UISegmentedControl) {
        let selectedRow = sender.selectedSegmentIndex
        delegate?.changeTaskState(section: self.section, index: self.index, state: State.allCases[selectedRow])
    }
}
