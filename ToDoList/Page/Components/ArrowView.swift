//
//  ArrowView.swift
//  ToDoList
//
//  Created by LEO on 13.11.2024.
//

import UIKit

class ArrowView: UIView {
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "arrow.png")
        let result = UIImageView(image: image!)
        
        return result
    }()
    
    init() {
        super.init(frame: CGRectZero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
