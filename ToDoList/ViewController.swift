//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var cases: [SingleItemModel] = [SingleItemModel(title: "Jump from building"), SingleItemModel(title: "Backflip"), SingleItemModel(title: "Meditation"), SingleItemModel(title: "Bomb the ball", isComplited: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        configurePicker()
        viewsLayout()
    }
    
    // MARK: - Table view initialize
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        return tableView
    }()
    
    //MARK: - State bar initialize
    let stateBar: UIToolbar = {
        let stateBar = UIToolbar()
        stateBar.isHidden = true
        stateBar.layer.masksToBounds = true
        stateBar.layer.cornerRadius = 10
        stateBar.barTintColor = .white
        return stateBar
    }()
    
    // MARK: - Picker initialize
    var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        pickerView.layer.cornerRadius = 10
        return pickerView
    }()
    
    //MARK: - Navigation bar configure
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .gray
        
        navigationItem.title = "Dream Things"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openForm))
        navigationItem.rightBarButtonItem?.tintColor = .label
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
    
    //MARK: - Change label
    @objc func changeLabel(sender: UITextField) {
        let index = sender.tag
        cases[index].title = sender.text!
        dismissKeyboard()
        tableView.reloadData()
    }
    
    //MARK: - Hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    // MARK: - Views layout
    func viewsLayout() {
        self.view.addSubview(tableView)
        self.view.addSubview(stateBar)
        self.view.addSubview(pickerView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        stateBar.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stateBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stateBar.widthAnchor.constraint(equalToConstant: 250),
            stateBar.heightAnchor.constraint(equalToConstant: 130),
            
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            pickerView.widthAnchor.constraint(equalToConstant: 250),
            pickerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
