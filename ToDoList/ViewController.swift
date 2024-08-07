//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cases: [SingleItemModel] = [SingleItemModel(title: "Jump from building"), SingleItemModel(title: "Backflip"), SingleItemModel(title: "Meditation"), SingleItemModel(title: "Bomb the ball", isComplited: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBar()
        configureTableView()
        layoutTableView()
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
    
    //MARK: - Status toggle
    @objc func statusToggle(sender: UIButton) {
        let index = sender.tag
        cases[index].isComplited.toggle()
        tableView.reloadData()
    }
    
    //MARK: - Navigation bar configure
    func configureBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .tertiaryLabel
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openForm))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    // MARK: - Table view operations
    
    // Table initialize
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .tertiaryLabel
        return tableView
    }()
    
    // Table configure
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    // Number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }
    
    // Height of cells
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    // Cell configure
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController")
        }
        cell.backgroundColor = .systemGray
        let caseItem = cases[indexPath.row]
        cell.configureCell(state: caseItem.isComplited, label: caseItem.title)

        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(statusToggle(sender: )), for: .touchUpInside)
        return cell
    }
    
    // Remove case from table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            cases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Table layout
    func layoutTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
