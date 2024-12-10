//
//  ProfileSignInView.swift
//  ToDoList
//
//  Created by LEO on 06.12.2024.
//

import UIKit

class SignInProfileView: UIView {
    
    weak var delegate: ProfileDelegate?
    
    private lazy var signFoarmStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.distribution = .fill
        result.spacing = 10
        return result
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.alignment = .center
        result.distribution = .fillEqually
        result.spacing = 2
        return result
    }()
    
    private lazy var signLoginTextField: UITextField = {
        let result = UITextField()
        result.placeholder = " Email"
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.backgroundColor = .lightGray
        result.layer.cornerRadius = 8
        result.layer.borderWidth = 1
        result.layer.borderColor = UIColor.white.cgColor
        return result
    }()
    
    private lazy var signPassTextField: UITextField = {
        let result = UITextField()
        result.placeholder = " Password"
        result.isSecureTextEntry = true
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.backgroundColor = .lightGray
        result.layer.cornerRadius = 8
        result.layer.borderWidth = 1
        result.layer.borderColor = UIColor.white.cgColor
        return result
    }()
    
    private lazy var loginButton: UIButton = {
        let result = UIButton()
        result.setTitle("Log in", for: .normal)
        result.layer.cornerRadius = 8
        result.layer.borderColor = UIColor.white.cgColor
        result.backgroundColor = .green
        result.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        result.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        return result
    }()
    
    private lazy var signUpButton: UIButton = {
        let result = UIButton()
        result.setTitle("Sign up", for: .normal)
        result.setTitleColor(.blue, for: .normal)
        result.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
        result.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return result
    }()
    
    init() {
        super.init(frame: CGRectZero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logInPressed() {
        guard let login = signLoginTextField.text, let pass = signPassTextField.text else {
            print("login or pass is empty")
            return
        }
        
        if UserDefaults.standard.string(forKey: login) != nil && UserDefaults.standard.string(forKey: login) == pass {
            delegate?.logIn(login: login)
        } else {
            print("login or pass is incorrect")
        }
    }
    
    @objc private func signUpPressed() {
        delegate?.presentSignUpController()
    }
    
    private func setupView() {
        buttonsStackView.addArrangedSubview(loginButton)
        buttonsStackView.addArrangedSubview(signUpButton)
        
        signFoarmStackView.addArrangedSubview(signLoginTextField)
        signFoarmStackView.addArrangedSubview(signPassTextField)
        signFoarmStackView.addArrangedSubview(buttonsStackView)
        
        self.addSubview(signFoarmStackView)
        signFoarmStackView.translatesAutoresizingMaskIntoConstraints = false
        
        signFoarmStackView.setCustomSpacing(20, after: signPassTextField)
        
        
        NSLayoutConstraint.activate([
            signLoginTextField.heightAnchor.constraint(equalToConstant: 40),
            signLoginTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            signPassTextField.heightAnchor.constraint(equalToConstant: 40),
            signPassTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            
            signFoarmStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signFoarmStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
