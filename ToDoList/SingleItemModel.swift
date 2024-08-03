//
//  SingleItemModel.swift
//  ToDoList
//
//  Created by LEO on 03.08.2024.
//

import Foundation

struct SingleItemModel {
    var id: UUID = UUID()
    var title: String
    var isComplited: Bool = false
}
