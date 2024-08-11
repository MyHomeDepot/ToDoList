//
//  ViewController.swift
//  ToDoList
//
//  Created by LEO on 01.08.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cases: [SingleItemModel] = [SingleItemModel(title: "Jump from building"), SingleItemModel(title: "Backflip"), SingleItemModel(title: "Meditation"), SingleItemModel(title: "Bomb the ball", isComplited: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar()
        configureTableView()
        configurePicker()
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
    
    //MARK: - Status toggle
    @objc func statusToggle(sender: UIButton) {
        let index = sender.tag
        cases[index].isComplited.toggle()
        tableView.reloadData()
    }
    
    //MARK: - Navigation bar configure
    func navigationBar() {
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
        tableView.allowsSelection = false
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
        cell.configureCell(caseItem: caseItem)
        
        cell.cellCheck.tag = indexPath.row
        cell.cellCheck.addTarget(self, action: #selector(statusToggle(sender: )), for: .touchUpInside)
        
        cell.cellLabel.delegate = self
        cell.cellLabel.tag = indexPath.row
        cell.cellLabel.addTarget(self, action: #selector(changeLabel(sender: )), for: .editingDidEnd)
        
        cell.cellStateButton.tag = indexPath.row
        cell.cellStateButton.addTarget(self, action: #selector(presentPicker(sender: )), for: .touchUpInside)
        
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
            stateBar.heightAnchor.constraint(equalToConstant: 150),
            
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            pickerView.widthAnchor.constraint(equalToConstant: 200),
            pickerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    //MARK: - State bar
    let stateBar: UIToolbar = {
        let stateBar = UIToolbar()
        stateBar.isHidden = true
        stateBar.layer.cornerRadius = 100
        stateBar.backgroundColor = .black
        return stateBar
    }()
    
    // MARK: - Picker configure
    var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        pickerView.layer.cornerRadius = 10
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return State.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return State.allCases[row].rawValue
    }
    
    func configurePicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    }
    
    //MARK: - Present picker    
    @objc func presentPicker(sender: UIButton) {
        stateBar.barStyle = .default
        stateBar.backgroundColor = .black
        stateBar.isTranslucent = true
        stateBar.sizeToFit()

        // Adding Button stateBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        cancelButton.tintColor = .red
        stateBar.setItems([doneButton, spaceButton, cancelButton], animated: true)
        stateBar.isUserInteractionEnabled = true

        pickerView.tag = sender.tag
        
        self.stateBar.isHidden = false
        self.pickerView.isHidden = false
    }
    
    @objc func doneClick(sender: UIBarButtonItem) {
        pickerView.isHidden = true
        self.stateBar.isHidden = true
        
        let index = pickerView.tag
        let selectRow = pickerView.selectedRow(inComponent: 0)
        let selectedState = State.allCases[selectRow]
        
        cases[index].state = selectedState
        tableView.reloadData()
    }

    @objc func cancelClick() {
        pickerView.isHidden = true
        self.stateBar.isHidden = true
    }
}
