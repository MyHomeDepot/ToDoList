//
//  TaskListViewController+EditTaskDelegate.swift
//  ToDoList
//
//  Created by LEO on 17.10.2024.
//

import Foundation

extension TaskListViewController: EditTaskDelegate {
    
    private func updateTask(id: UUID, update: (inout Task) -> Void) {
        guard let index = tasks.firstIndex(where: { $0.getId() == id }) else { return }
        update(&tasks[index])
        taskListTableView.reloadData()
    }
    
    func updateTaskStatus(task: Task) {
        updateTask(id: task.getId()) { $0.toggleStatus() }
    }
    
    func updateTaskName(task: Task, title: String) {
        updateTask(id: task.getId()) { $0.setTitle(title: title) }
    }
    
    func updateTaskState(task: Task, state: State) {
        updateTask(id: task.getId()) { $0.setState(state: state) }
    }
    
    func updateTaskDeadline(task: Task, deadline: Date) {
        updateTask(id: task.getId()) { $0.setDeadline(deadline: deadline) }
    }
    
    func showChooserView(task: Task) {
        taskStateChooserView.task = task
        taskStateChooserView.isHidden = false
    }
}
