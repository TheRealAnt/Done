import Foundation
import UIKit

enum SettingItemType: Int, CaseIterable {
    //case backgroundColors = "Background colours"
    case appearance
    case hapticFeedback
    //case notifications = "Notifications"
}

class SettingsTableViewModel {
    
//    func setupBackgroundColorsCell(in tableView: UITableView,
//                                   with cell: UITableViewCell,
//                                   at indexPath: IndexPath) -> UITableViewCell {
//        cell.textLabel?.text = Setting.backgroundColors.rawValue
//        return cell
//    }
    
    func setupTableViewCell(in tableView: UITableView,
                            with cell: SettingsPopUpButtonTableViewCell,
                            at indexPath: IndexPath) -> UITableViewCell {
        cell.settingsLabel.text = "Appearance"
        return cell
    }
    
    func setupHapticFeedbackCell(in tableView: UITableView,
                                 with cell: UITableViewCell,
                                 at indexPath: IndexPath) -> UITableViewCell {
        return cell
    }
}

// MARK: - Computed properties

extension SettingsTableViewModel {
    var numberOfRowsInSection: Int {
        SettingItemType.allCases.count
    }
    
    func appearanceMode() -> UIUserInterfaceStyle {
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        
        guard let currentAppearanceMode = window?.traitCollection.userInterfaceStyle else {
            return UIUserInterfaceStyle.unspecified
        }
        return currentAppearanceMode
    }
}


