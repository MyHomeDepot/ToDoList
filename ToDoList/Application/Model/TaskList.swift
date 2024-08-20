//
//  TaskList.swift
//  ToDoList
//
//  Created by LEO on 20.08.2024.
//

import Foundation

public struct TaskList {
    private static var uncompletedTaskList: [Task] = []
    private static var completedTaskList: [Task] = []
    
    public static func categorizeTasks(for sourceTaskList: [Task]) {
        uncompletedTaskList = sourceTaskList.filter { !$0.getStatus() }
        completedTaskList = sourceTaskList.filter { $0.getStatus() }
    }
    
    public static func getTaskCount(in indicator: String) -> Int {
        switch indicator{
        case "hold":
            return uncompletedTaskList.count
        case "success":
            return completedTaskList.count
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
    
    public static func appendTask(for task: Task, in indicator: String) {
        switch indicator{
        case "hold":
            uncompletedTaskList.append(task)
        case "success":
            completedTaskList.append(task)
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
    
    public static func changeTitle(at index: Int, on title: String, in indicator: String) {
        switch indicator{
        case "hold":
            uncompletedTaskList[index].setTitle(title: title)
        case "success":
            completedTaskList[index].setTitle(title: title)
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
    
    public static func changeState(at index: Int, on state: State, in indicator: String) {
        switch indicator{
        case "hold":
            uncompletedTaskList[index].setState(state: state)
        case "success":
            completedTaskList[index].setState(state: state)
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
    
    public static func toggleStatus(at index: Int, in indicator: String) {
        switch indicator{
        case "hold":
            uncompletedTaskList[index].toggleStatus()
        case "success":
            completedTaskList[index].toggleStatus()
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
    
    public static func removeTask(at index: Int, in indicator: String) -> Task {
        switch indicator{
        case "hold":
            return uncompletedTaskList.remove(at: index)
        case "success":
            return completedTaskList.remove(at: index)
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
    
    public static func getTaskByIndex(at index: Int, in indicator: String) -> Task {
        switch indicator{
        case "hold":
            uncompletedTaskList[index]
        case "success":
            completedTaskList[index]
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
    
    private static func getTaskList(in indicator: String) -> [Task] {
        switch indicator{
        case "hold":
            return uncompletedTaskList
        case "success":
            return completedTaskList
        default:
            fatalError("Invalid indicator: \(indicator)")
        }
    }
}
