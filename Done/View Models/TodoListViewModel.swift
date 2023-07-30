import Foundation

class TodoListViewModel {}

// MARK: - Localized strings

extension TodoListViewModel {
    var homeTitle: String { NSLocalizedString("homeTitle", comment: "the home title") }
    var itemNameTitle: String { NSLocalizedString("itemNameTitle", comment: "the item name title") }
    var updateItemNameTitle: String { NSLocalizedString("updateItemNameTitle", comment: "the update item name title") }
    var addItemTitle: String { NSLocalizedString("addItemTitle", comment: "the add item title") }
    var addNewItemTitle: String { NSLocalizedString("addNewItemTitle", comment: "the add new item title") }
    var addTitle: String { NSLocalizedString("addTitle", comment: "the add title") }
    var cancelTitle: String { NSLocalizedString("cancelTitle", comment: "the cancel title") }
}
