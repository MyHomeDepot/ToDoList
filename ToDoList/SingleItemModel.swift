//
//  SingleItemModel.swift
//  ToDoList
//
//  Created by LEO on 03.08.2024.
//

import UIKit

struct SingleItemModel {
    var id: UUID = UUID()
    var title: String
    var isComplited: Bool = false
    var state: State = State.toDo
}

enum State: String, CaseIterable {
    case toDo = "To Do"
    case inProgress = "In Process"
    case done = "Done"
}
