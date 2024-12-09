//
//  ProfileInfoView.swift
//  ToDoList
//
//  Created by LEO on 06.12.2024.
//

import UIKit

class InfoProfileView: UIView {
    
    weak var delegate: ProfileDelegate?
    
    private lazy var logOutButton: UIButton = {
        let result = UIButton()
        result.setTitle("Log Out", for: .normal)
        result.layer.cornerRadius = 15
        result.backgroundColor = .red
        result.addTarget(self, action: #selector(logOutPressed), for: .touchUpInside)
        return result
    }()
    
    init() {
        super.init(frame: CGRectZero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logOutPressed() {
        delegate?.logOut()
    }
    
    private func setupView() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logOutButton)
        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
            logOutButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
    }
}
