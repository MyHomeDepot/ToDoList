//
//  ProfileViewController.swift
//  ToDoList
//
//  Created by LEO on 29.11.2024.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    func logIn(login: String)
    func logOut()
    func presentSignUpController()
}

class ProfileViewController: UIViewController {
    
    private let signInProfileView = SignInProfileView()
    private let infoProfileView = InfoProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInProfileView.delegate = self
        infoProfileView.delegate = self
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .gray
        
        signInProfileView.translatesAutoresizingMaskIntoConstraints = false
        infoProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(signInProfileView)
        view.addSubview(infoProfileView)
        
        NSLayoutConstraint.activate([
            signInProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            signInProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signInProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            infoProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            infoProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if AuthManager.shared.isLoggedIn {
            signInProfileView.isHidden = true
        } else {
            infoProfileView.isHidden = true
        }
        
        dismissKeyboard()
    }
    
    private func updateView() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.signInProfileView.isHidden = AuthManager.shared.isLoggedIn
            self.infoProfileView.isHidden = !AuthManager.shared.isLoggedIn
        })
    }
    
    private func dismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboardTouchOutside)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}

extension ProfileViewController: ProfileDelegate {
    func logIn(login: String) {
        UserDefaults.standard.set(login, forKey: "logedProfile")
        AuthManager.shared.isLoggedIn = true
        updateView()
    }
    
    func logOut() {
        UserDefaults.standard.set(nil, forKey: "logedProfile")
        AuthManager.shared.isLoggedIn = false
        updateView()
    }
    
    func presentSignUpController() {
        let vc = SignUpProfileController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
