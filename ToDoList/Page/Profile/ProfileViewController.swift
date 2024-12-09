//
//  ProfileViewController.swift
//  ToDoList
//
//  Created by LEO on 29.11.2024.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    func logIn()
    func logOut()
    func presentSignUpController()
}

class ProfileViewController: UIViewController {
    
    private var isLoggedIn = false {
        didSet {
            updateView()
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    private let signInProfileView = SignInProfileView()
    private let infoProfileView = InfoProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
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
    }
    
    private func updateView() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.signInProfileView.isHidden = self.isLoggedIn
            self.infoProfileView.isHidden = !self.isLoggedIn
        })
    }
}

extension ProfileViewController: ProfileDelegate {
    func logIn() {
        isLoggedIn = true
    }
    
    func logOut() {
        isLoggedIn = false
    }
    
    func presentSignUpController() {
        let vc = SignUpProfileController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
