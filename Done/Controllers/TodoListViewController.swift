import UIKit
import RealmSwift
import CoreData

class TodoListViewController: SwipeTableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = TodoListViewModel()
    var todoItems: Results<Item>?
    let realm = try! Realm() // swiftlint:disable:this force_try
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory?.name
        guard let colorHex = selectedCategory?.backgroundColor else { fatalError() }
        updateNavBar(withHexCode: colorHex)
    }
    override func viewWillDisappear(_ animated: Bool) {
        updateNavBar(withHexCode: "1D9BF6")
        configureNavigationBar(largeTitleColor: .label,
                               backgoundColor: .systemBackground,
                               tintColor: .label,
                               title: viewModel.homeTitle,
                               preferredLargeTitle: false)
    }
    // MARK: - navbar setup methods
    func updateNavBar(withHexCode colorHexCode: String) {
        let navBarColor = UIColor().colorWithHexString(hexString: selectedCategory!.backgroundColor)
        configureNavigationBar(largeTitleColor: .label,
                               backgoundColor: navBarColor,
                               tintColor: .label,
                               title: selectedCategory?.name ?? "",
                               preferredLargeTitle: true)
        searchBar.barTintColor = navBarColor
        searchBar.tintColor = navBarColor
        searchBar.backgroundColor = navBarColor
    }
    // MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let percentage = CGFloat(indexPath.row)/CGFloat(todoItems!.count)
        let color = UIColor().colorWithHexString(hexString: selectedCategory!.backgroundColor).withAlphaComponent(percentage)
        cell.backgroundColor = color
        cell.textLabel?.textColor = .white
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    override func deleteModel(at indexPath: IndexPath) {
        if let todoItemForDeletion = todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(todoItemForDeletion)
                }
            } catch {
                print("Error deleting todoItem \(error)")
            }
            self.tableView.reloadData()
        }
    }
    
    override func updateModelName(at indexPath: IndexPath) {
        if todoItems?[indexPath.row] != nil {
            self.updateModel(at: indexPath)
        }
    }
    
    override func updateModel(at indexPath: IndexPath) {
        #warning("TODO: - Duplicate methods (updateModel/deleteModel), try find an optimized implementation")
        var textField = UITextField()
        let alert = UIAlertController(title: viewModel.updateItemNameTitle,
                                      message: nil,
                                      preferredStyle: .alert)
        let category = todoItems?[indexPath.row]
        let action = UIAlertAction(title: viewModel.addTitle, style: .default) { [weak self] _ in
            do {
                try self?.realm.write {
                    self?.todoItems?[indexPath.row].title = textField.text!
                }
            } catch {
                print("Error saving category \(error)")
            }
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }
        alert.addAction(UIAlertAction(title: viewModel.cancelTitle, style: .cancel))
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = self.viewModel.updateItemNameTitle
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: viewModel.addNewItemTitle, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: viewModel.addItemTitle, style: .default) { _ in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = self.viewModel.itemNameTitle
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: viewModel.cancelTitle, style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Model Manupulation Methods
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

// MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@",
                                      searchBar.text!).sorted(byKeyPath: "dateCreated",
                                                              ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
