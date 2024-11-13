//
//  SingleItemModel.swift
//  ToDoList
//
//  Created by LEO on 03.08.2024.
//

import Foundation

public struct Task {
    private let id: UUID = UUID()
    private var title: String
    private var isCompleted: Bool = false
    private var state: State = State.toDo
    private var deadline: Date = Date()
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, isCompleted: Bool, state: State) {
        self.title = title
        self.isCompleted = isCompleted
        self.state = state
    }
    
    public func getId() -> UUID {
        return id
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public mutating func setTitle(title: String) {
        self.title = title
    }
    
    public func getStatus() -> Bool {
        return isCompleted
    }
    
    public mutating func toggleStatus() {
        isCompleted.toggle()
        autoChangeState()
    }
    
    public func getState() -> State {
        return state
    }
    
    public mutating func setState(state: State) {
        self.state = state
        autoChangeStatus()
    }
    
    private mutating func autoChangeStatus() {
        if state == .done {
            isCompleted = true
        } else {
            isCompleted = false
        }
    }
    
    private mutating func autoChangeState() {
        if isCompleted {
            setState(state: .done)
        } else {
            setState(state: .toDo)
        }
    }
    
    public func getDeadline() -> Date {
        return self.deadline
    }
    
    public mutating func setDeadline(deadline: Date) {
        self.deadline = deadline
    }
}

public enum State: Int, CaseIterable {
    case toDo = 0
    case inProgress
    case done
    
    var title: String {
        switch self {
        case .toDo: return "To Do"
        case .inProgress: return "In Process"
        case .done: return "Done"
        }
    }
}
