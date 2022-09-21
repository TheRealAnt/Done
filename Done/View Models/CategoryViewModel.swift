import Foundation
import RealmSwift
import UIKit

class CategoryViewModel {
    var categories: Results<Category>?
    let defaultNumberOfRows = 1
    let defaultBackgroundColor = "#FFFFFF"
    
    var numberOfRowsInSection: Int {
        categories?.count ?? defaultNumberOfRows
    }
    
    var screenTitle: String {
        doneTitle
    }
    
    var segueIdentifier: String {
        Constants.SegueIdentifiers.goToItems
    }
    
    var cellTextColor: UIColor {
        UIColor.label
    }
    
    func category(nameAt indexPath: IndexPath) -> String? {
        categories?[indexPath.row].name
    }
    
    func category(backgroundColorAt indexPath: IndexPath) -> String {
        categories?[indexPath.row].backgroundColor ?? defaultBackgroundColor
    }
    
    func categoryCell(backgroundColorAt indexPath: IndexPath) -> UIColor? {
        UIColor().colorWithHexString(hexString: category(backgroundColorAt: indexPath))
    }
    
    var randomBackgroundColor: String {
        UIColor().hexStringFromColor(color: UIColor().generateRandomColor())
    }
    
    func setupTableViewCell(in tableView: UITableView, with cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        cell.textLabel?.text = category(nameAt: indexPath)
        cell.textLabel?.textColor = cellTextColor
        cell.backgroundColor = categoryCell(backgroundColorAt: indexPath)
        return cell
    }
}

extension CategoryViewModel {
    var doneTitle: String { NSLocalizedString("doneTitle", comment: "the done title") }
    var addNewCategoryTitle: String { NSLocalizedString("addNewCategoryTitle", comment: "the add new category title") }
    var addTitle: String { NSLocalizedString("addTitle", comment: "the add title") }
}
