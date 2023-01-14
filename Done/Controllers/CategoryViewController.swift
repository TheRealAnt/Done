import UIKit
import RealmSwift

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
    // MARK: - Data Manipulation Methods
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
    func loadCategories() {
        viewModel.categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    // MARK: - delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.viewModel.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category \(error)")
            }
        }
    }
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: viewModel.addNewCategoryTitle, message: nil, preferredStyle: .alert)
        let randomBackgroundColor = viewModel.randomBackgroundColor
        let action = UIAlertAction(title: viewModel.addTitle, style: .default) { [weak self] _ in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.backgroundColor = randomBackgroundColor
            self?.save(category: newCategory)
        }
        alert.addAction(UIAlertAction(title: viewModel.cancelTitle, style: .cancel))
        alert.addAction(action)
        alert.addTextField { [weak self] (field) in
            textField = field
            textField.placeholder = self?.viewModel.addNewCategoryTitle
        }
        present(alert, animated: true, completion: nil)
    }
}
