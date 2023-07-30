import UIKit

protocol SwipeTableViewControllerUpdateModel {
    func updateModel(at indexPath: IndexPath)
    func deleteModel(at indexPath: IndexPath)
    func updateModelName(at indexPath: IndexPath)
}

class SwipeTableViewController: UITableViewController, SwipeTableViewControllerUpdateModel {
    func deleteModel(at indexPath: IndexPath) {}
    func updateModel(at indexPath: IndexPath) {}
    func updateModelName(at indexPath: IndexPath) {}
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    // MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #warning("TODO: - localize strings")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .destructive, title: "Edit") { _, _, _  in
            self.updateModelName(at: indexPath)
        }
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(named: "edit")
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _  in
            self.deleteModel(at: indexPath)
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(named: "delete")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
