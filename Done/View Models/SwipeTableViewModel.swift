import Foundation
import SwipeCellKit

class SwipeTableViewModel {
    func handleSwipeAction(for orientation: SwipeActionsOrientation,
                           on tableViewController: SwipeTableViewController) -> [SwipeAction] {
        switch orientation {
        case .right:
            return deleteAction(on: tableViewController)
        case .left:
            return editAction(on: tableViewController)
        }
    }
    private func deleteAction(on tableViewController: SwipeTableViewController) -> [SwipeAction] {
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { _, indexPath in
            tableViewController.deleteModel(at: indexPath)
        }
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }
    private func editAction(on tableViewController: SwipeTableViewController) -> [SwipeAction] {
        let editAction = SwipeAction(style: .default, title: "Edit") { _, indexPath in
            tableViewController.updateModelName(at: indexPath)
        }
        editAction.image = UIImage(named: "edit")
        return [editAction]
    }
}
