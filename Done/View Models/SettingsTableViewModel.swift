import Foundation
import UIKit

class SettingsTableViewModel {
    let defaultNumberOfRows = 1
    
    func setupTableViewCell(in tableView: UITableView,
                            with cell: UITableViewCell,
                            at indexPath: IndexPath) -> UITableViewCell {
        cell.textLabel?.text = "Dark mode"
        cell.textLabel?.textColor = .white
        return cell
    }
}

// MARK: - Computed properties

extension SettingsTableViewModel {
    var numberOfRowsInSection: Int {
       defaultNumberOfRows
    }
}
