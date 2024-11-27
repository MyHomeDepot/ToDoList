//
//  PostService.swift
//  ToDoList
//
//  Created by LEO on 26.11.2024.
//

import UIKit
import Firebase

struct PostService {
    
    static let shared = PostService()
    let DB_REF = Database.database().reference()
    
    func fetchAllItems(completion: @escaping([Task]) -> Void) {
        DB_REF.child("Tasks").observeSingleEvent(of: .value) { snapshot in
            var fetchedTasks = [Task]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dictionary = childSnapshot.value as? [String: Any] {
                    let task = Task(id: childSnapshot.key, dictionary: dictionary)
                    fetchedTasks.append(task)
                }
            }
            
            completion(fetchedTasks)
        }
        
//        var fetchedTasks = [Task]()
//        
//        DB_REF.child("Tasks").observe(.childAdded) { (snapshot) in
//            fetchSingleItem(id: snapshot.key) { (task) in
//                fetchedTasks.append(task)
//                completion(fetchedTasks)
//            }
//        }
    }
    
    func fetchSingleItem(id: String, completion: @escaping(Task) -> Void) {
        DB_REF.child("Tasks").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let task = Task(id: id, dictionary: dictionary)
            completion(task)
        }
    }
    
    func uploadTask (task: Task) {
        let value = [
            "deadline": task.getDeadline().timeIntervalSince1970,
            "isCompleted": task.getStatus(),
            "state": task.getState().rawValue,
            "title": task.getTitle()
        ] as [String: Any]
        
        DB_REF.child("Tasks").child(task.getId().uuidString).updateChildValues(value)
    }
    
    func removeTask(task: Task) {
        DB_REF.child("Tasks").child(task.getId().uuidString).removeValue()
    }
    
}
