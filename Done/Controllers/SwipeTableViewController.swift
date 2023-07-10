import UIKit
import SwipeCellKit

protocol SwipeTableViewControllerUpdateModel {
    func updateModel(at indexPath: IndexPath)
    func deleteModel(at indexPath: IndexPath)
    func updateModelName(at indexPath: IndexPath)
}

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate, SwipeTableViewControllerUpdateModel {
    func deleteModel(at indexPath: IndexPath) {}
    func updateModel(at indexPath: IndexPath) {}
    func updateModelName(at indexPath: IndexPath) {}
    let swipeTableViewModel = SwipeTableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    // MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SwipeTableViewCell
        cell?.delegate = self
        return cell ?? SwipeTableViewCell()
    }
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        swipeTableViewModel.handleSwipeAction(for: orientation, on: self)
    }
    func tableView(_ tableView: UITableView,
                   editActionsOptionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        switch orientation {
        case .right:
            options.expansionStyle = .destructive
        case .left:
            options.expansionStyle = .none
        }
        return options
    }
}
