//
//  TaskListViewController+TaskViewDelegate.swift
//  ToDoList
//
//  Created by LEO on 17.10.2024.
//

extension TaskListViewController: SelectedTaskDelegate {
    
    func changeTaskName(section: Int, index: Int, title: String) {
        let tableSection = activeSections[section]
        if isValidTitle(text: title){
            taskDictionary[tableSection]?[index].setTitle(title: title)
            taskListTableView.reloadData()
        }
    }
    
    func changeTaskState(section: Int, index: Int, state: State) {
        let tableSection = activeSections[section]
        if state != taskDictionary[tableSection]?[index].getState() {
            var result = taskDictionary[tableSection]?[index]
            result!.setState(state: state)
            taskDictionary[tableSection]?.remove(at: index)
            
            switch state {
            case .toDo:
                taskDictionary[.toDo]?.insert(result!, at: 0)
            case .inProgress:
                taskDictionary[.inProgress]?.insert(result!, at: 0)
            case .done:
                taskDictionary[.done]?.insert(result!, at: 0)
            }
        }
        taskListTableView.reloadData()
    }
}
