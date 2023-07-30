import Foundation
import RealmSwift

#warning("TODO: - SwiftUI -> SwiftData")
class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundColor: String = ""
    let items = List<Item>()
}
