//
//  ViewController.swift
//  Todoey
//
//  Created by Antonie Sander on 2022/03/22.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    // MARK: - Tableview datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // MARK: - Tableview delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)


        let action = UIAlertAction(title: "Add item", style: .default) { action in
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
}

