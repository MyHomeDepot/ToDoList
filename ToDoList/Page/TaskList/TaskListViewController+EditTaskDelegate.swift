//
//  TaskListViewController+EditTaskDelegate.swift
//  ToDoList
//
//  Created by LEO on 17.10.2024.
//
import Foundation
extension TaskListViewController: EditTaskDelegate {
    
    func updateTaskStatus(task: Task) {
        guard let index = tasks.firstIndex(where: { $0.getId() == task.getId() }) else { return }
        tasks[index].toggleStatus()
        taskListTableView.reloadData()
    }
    
    func updateTaskName(task: Task, title: String) {
        guard let index = tasks.firstIndex(where: { $0.getId() == task.getId() }) else { return }
        tasks[index].setTitle(title: title)
        taskListTableView.reloadData()
    }
    
    func updateTaskState(task: Task, state: State) {
        guard let index = tasks.firstIndex(where: { $0.getId() == task.getId() }) else { return }
        tasks[index].setState(state: state)
        taskListTableView.reloadData()
    }
    
    func updateTaskDeadline(task: Task, deadline: Date) {
        guard let index = tasks.firstIndex(where: { $0.getId() == task.getId() }) else { return }
        tasks[index].setDeadline(deadline: deadline)
        taskListTableView.reloadData()
    }
    
    func showChooserView(task: Task) {
        taskStateChooserView.task = task
        taskStateChooserView.isHidden = false
    }
}
