//
//  SignUpProfileController.swift
//  ToDoList
//
//  Created by LEO on 06.12.2024.
//

import UIKit

class SignUpProfileController: UIViewController {
    
    private let signUpProfileView = SignUpProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignUpProfileBar()
        setupView()
    }
    
    private func setupSignUpProfileBar() {
        navigationItem.title = "Registration"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log in", image: .none,
                                                           target: self,
                                                           action: #selector(undoButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc private func undoButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .gray
        
        signUpProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(signUpProfileView)
        
        NSLayoutConstraint.activate([
            signUpProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signUpProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
