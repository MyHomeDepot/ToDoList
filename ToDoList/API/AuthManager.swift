//
//  AuthManager.swift
//  ToDoList
//
//  Created by LEO on 10.12.2024.
//

import UIKit

class AuthManager {
    static let shared = AuthManager()
    
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
        }
    }
    
    var profile: String {
        get {
            return UserDefaults.standard.string(forKey: "logedProfile") ?? ""
        }
        set {
            UserDefaults.setValue(newValue, forKey: "logedProfile")
        }
    }
}
