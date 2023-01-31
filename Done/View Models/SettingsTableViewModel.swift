import Foundation
import UIKit

enum SettingItemType: Int {
    //case backgroundColors
    case appearance
    case hapticFeedback
    //case notifications
}

class SettingsTableViewModel: HandleUserInterfaceStyleSwitching {
    func setUserInterface(style: UIUserInterfaceStyle) {}
    
    
    var settings: [SettingItemType] = [SettingItemType]()
    
    func setupTableViewWithSettings() {
        settings.append(contentsOf: [SettingItemType.appearance,
                                     SettingItemType.hapticFeedback])
    }
    
    func setupTableViewCell(in tableView: UITableView,
                            with cell: SettingsPopUpButtonTableViewCell,
                            at indexPath: IndexPath) -> UITableViewCell {
        cell.settingsLabel.text = appearanceTitle
        return cell
    }
    
    func setupSettingsPopUpButtonCell(in tableView: UITableView,
                                      with cell: SettingsPopUpButtonTableViewCell,
                                      at indexPath: IndexPath) -> UITableViewCell {

        return cell
    }
    
    func setupHapticFeedbackCell(in tableView: UITableView,
                                 with cell: SettingsCell,
                                 at indexPath: IndexPath) -> UITableViewCell {
        cell.settingLabel.text = hapticFeedbackTitle
        return cell
    }
}

// MARK: - Computed properties

extension SettingsTableViewModel {
    var numberOfRowsInSection: Int {
        settings.count
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

// MARK: - Localized strings

extension SettingsTableViewModel {
    var appearanceTitle: String { NSLocalizedString("appearanceTitle", comment: "the appearance title") }
    var appearanceMenuTitle: String { NSLocalizedString("appearanceMenuTitle", comment: "the appearance menu title") }
    var hapticFeedbackTitle: String { NSLocalizedString("hapticFeedbackTitle", comment: "the haptic feedback title") }
    var autoTitle: String { NSLocalizedString("autoTitle", comment: "the auto title") }
    var darkTitle: String { NSLocalizedString("darkTitle", comment: "the dark title") }
    var lightTitle: String { NSLocalizedString("lightTitle", comment: "the light title") }
}
