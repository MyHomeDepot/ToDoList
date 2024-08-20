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
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
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
        self.isCompleted.toggle()
    }
    
    public func getState() -> State {
        return state
    }
    
    public func getEnumStateValue() -> State.RawValue {
        return state.rawValue
    }
    
    public mutating func setState(state: State) {
        self.state = state
    }
}

public enum State: String, CaseIterable {
    case toDo = "To Do"
    case inProgress = "In Process"
    case done = "Done"
}
