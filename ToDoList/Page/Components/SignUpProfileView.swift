//
//  SignUpProfileView.swift
//  ToDoList
//
//  Created by LEO on 06.12.2024.
//

import UIKit

class SignUpProfileView: UIView {
    
    private lazy var regFoarmStackView: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.alignment = .center
        result.distribution = .fill
        result.spacing = 10
        return result
    }()
    
    private lazy var regLoginTextField: UITextField = {
        let result = UITextField()
        result.placeholder = " Email"
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.backgroundColor = .lightGray
        result.layer.cornerRadius = 8
        result.layer.borderWidth = 1
        result.layer.borderColor = UIColor.white.cgColor
        return result
    }()
    
    private lazy var regPassTextField: UITextField = {
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
    
    private lazy var regButton: UIButton = {
        let result = UIButton()
        result.setTitle("Create", for: .normal)
        result.layer.cornerRadius = 8
        result.layer.borderColor = UIColor.white.cgColor
        result.backgroundColor = .orange
        result.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        result.addTarget(self, action: #selector(registerProfile), for: .touchUpInside)
        return result
    }()
    
    init() {
        super.init(frame: CGRectZero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func registerProfile() {
        
    }
    
    private func setupView() {
        regFoarmStackView.addArrangedSubview(regLoginTextField)
        regFoarmStackView.addArrangedSubview(regPassTextField)
        regFoarmStackView.addArrangedSubview(regButton)
        
        self.addSubview(regFoarmStackView)
        regFoarmStackView.translatesAutoresizingMaskIntoConstraints = false
        
        regFoarmStackView.setCustomSpacing(20, after: regPassTextField)
        
        NSLayoutConstraint.activate([
            regButton.widthAnchor.constraint(equalToConstant: 200),
            
            regLoginTextField.heightAnchor.constraint(equalToConstant: 40),
            regLoginTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            regPassTextField.heightAnchor.constraint(equalToConstant: 40),
            regPassTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            regFoarmStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            regFoarmStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
