import UIKit
import RealmSwift

#warning("TODO: - Transition to SwiftUI")
class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm() // swiftlint:disable:this force_try
    let viewModel = CategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        configureNavigationBar(largeTitleColor: .label,
                               backgoundColor: .systemBackground,
                               tintColor: .label,
                               title: viewModel.screenTitle,
                               preferredLargeTitle: false)
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        return viewModel.setupTableViewCell(in: tableView, with: cell, at: indexPath)
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: viewModel.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController // swiftlint:disable:this force_cast
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = viewModel.categories?[indexPath.row]
        }
    }
    
    func loadCategories() {
        viewModel.categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModelName(at indexPath: IndexPath) {
        if viewModel.categories?[indexPath.row] != nil {
            self.updateModel(at: indexPath)
        }
    }
    
    override func updateModel(at indexPath: IndexPath) {
        var textField = UITextField()
        let alert = UIAlertController(title: viewModel.addNewCategoryTitle,
                                      message: nil,
                                      preferredStyle: .alert)
        let randomBackgroundColor = viewModel.randomBackgroundColor
        let category = viewModel.categories?[indexPath.row]
        let action = UIAlertAction(title: viewModel.addTitle, style: .default) { [weak self] _ in
            do {
                try self?.realm.write {
                    category?.name = textField.text!
                    category?.backgroundColor = randomBackgroundColor
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
            textField.placeholder = self.viewModel.addNewCategoryTitle
        }
        present(alert, animated: true, completion: nil)
    }
    
    override func deleteModel(at indexPath: IndexPath) {
        if let categoryForDeletion = viewModel.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
#warning("TODO: - Replace print with OSLog instead")
                print("Error deleting category \(error)")
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: - Tap gestures
private extension CategoryViewController {
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        configureAddCategoryAlertDialog()
    }
}

// MARK: - Tap actions
private extension CategoryViewController {
    func configureAddCategoryAlertDialogAction(on alert: UIAlertController,
                                               with textField: UITextField,
                                               backgroundColor: String) {
        var textField = textField
        let action = UIAlertAction(title: viewModel.addTitle, style: .default) { _ in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.backgroundColor = backgroundColor
            self.save(category: newCategory)
        }
        alert.addAction(UIAlertAction(title: viewModel.cancelTitle, style: .cancel))
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = self.viewModel.addNewCategoryTitle
        }
    }
}

// MARK: - Data handling helper methods
private extension CategoryViewController {
    func configureAddCategoryAlertDialog() {
        let textField = UITextField()
        let alert = UIAlertController(title: viewModel.addNewCategoryTitle,
                                      message: nil,
                                      preferredStyle: .alert)
        let randomBackgroundColor = viewModel.randomBackgroundColor
        configureAddCategoryAlertDialogAction(on: alert,
                                              with: textField,
                                              backgroundColor: randomBackgroundColor)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
}
