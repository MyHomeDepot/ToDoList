//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cases: [SingleItemModel] = [SingleItemModel(title: "Jump from building"), SingleItemModel(title: "Backflip"), SingleItemModel(title: "Meditation"), SingleItemModel(title: "Bomb the ball")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.window?.backgroundColor = .systemMint
        configureBar()
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openForm))
        
        view.addSubview(tableView)
        configureTableView()
        constrainTableView()
    }
    
    //MARK: - Form to add case
    @objc func openForm() {
        let alert = UIAlertController(title: "Add case on the list", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                self.appendCase(title: text)
            }
        }
        alert.addAction(saveButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        
        present (alert, animated: true)
    }
    
    //MARK: - Add case to array
    @objc func appendCase(title: String) {
        cases.append(SingleItemModel(title: title))
        tableView.reloadData()
    }
    
    //MARK: - Navigation bar configure
    func configureBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemMint
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Table view operations
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "caseCell")
        let caseItem = cases[indexPath.row]
        
        cell.textLabel?.text = caseItem.title
        cell.accessoryType = .checkmark
        cell.backgroundColor = .cyan
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == . delete {
            cases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemMint
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "caseCell")
    }
    
    func constrainTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

