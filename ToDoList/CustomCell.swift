//
//  CustomCell.swift
//  ToDoList
//
//  Created by LEO on 06.08.2024.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    var cellCheck: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "questionmark"), for: .normal)
        return button
    }()
    
    var cellLabel: UITextField = {
        let label = UITextField()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Error"
        label.allowsEditingTextAttributes = true
        return label
    }()
    
    var cellStateButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutCellView()
    }
    
    func configureCell (caseItem: SingleItemModel) {
        cellCheck.setImage(UIImage(systemName: caseItem.isComplited ? "checkmark.square" : "square"), for: .normal)
        cellCheck.tintColor = .label
        
        cellLabel.text = caseItem.title
        
        cellStateButton.setTitle("\(caseItem.state.rawValue)", for: .normal)
        cellStateButton.tintColor = .label
    }
    
    func layoutCellView() {
        self.contentView.addSubview(cellCheck)
        self.contentView.addSubview(cellLabel)
        self.contentView.addSubview(cellStateButton)
        
        cellCheck.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellStateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellCheck.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            cellCheck.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            cellCheck.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            cellCheck.widthAnchor.constraint(equalToConstant: 20),
            
            cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: self.cellCheck.trailingAnchor, constant: 25),
            cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -35),
            
            cellStateButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellStateButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            cellStateButton.widthAnchor.constraint(equalToConstant: 40),
            cellStateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
