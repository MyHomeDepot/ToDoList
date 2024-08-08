//
//  CustomCell.swift
//  ToDoList
//
//  Created by LEO on 06.08.2024.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    var cellButton: UIButton = {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutCellView()
      }
    
    func configureCell (state: Bool, label: String) {
        cellButton.setImage(UIImage(systemName: state ? "checkmark.square" : "square"), for: .normal)
        cellButton.tintColor = .label
        cellLabel.text = label
    }
    
    func layoutCellView() {
        self.contentView.addSubview(cellButton)
        self.contentView.addSubview(cellLabel)
        
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellButton.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            cellButton.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            cellButton.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            cellButton.widthAnchor.constraint(equalToConstant: 20),
            
            cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: self.cellButton.trailingAnchor, constant: 25),
            cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -35)
        ])
    }
}
