import Foundation
import UIKit

class SettingsTableViewController: UITableViewController {
    var viewModel = SettingsTableViewModel()
    let setting = SettingItemType.appearance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .singleLine
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Settings"
    }
}

extension SettingsTableViewController {
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    // MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var indexRow = indexPath.row
        
        if indexRow == 0 {
            let settingsPopUpButtonTableViewCell = UINib(nibName: "SettingsPopUpButtonTableViewCell", bundle: nil)
            self.tableView.register(settingsPopUpButtonTableViewCell, forCellReuseIdentifier: "SettingsPopUpButtonTableViewCell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsPopUpButtonTableViewCell", for: indexPath) as? SettingsPopUpButtonTableViewCell {
                let usersItem = UIAction(title: "Auto", image: UIImage(systemName: "person.fill")) { (action) in
                    self.appearanceMenuAction(for: cell, with: .unspecified)
                }
                let addUserItem = UIAction(title: "Dark", image: UIImage(systemName: "person.badge.plus")) { (action) in
                    self.appearanceMenuAction(for: cell, with: .dark)
                }
                let removeUserItem = UIAction(title: "Light", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
                    self.appearanceMenuAction(for: cell, with: .light)
                }
                let menu = UIMenu(title: "Appearance menu", options: .displayInline, children: [usersItem , addUserItem , removeUserItem])
                cell.settingsPopUpButton.menu = menu
                cell.settingsPopUpButton.showsMenuAsPrimaryAction = true
                return viewModel.setupTableViewCell(in: tableView, with: cell, at: indexPath)}
        } else if indexRow == 1 {
            let settingsCell = UINib(nibName: "SettingsCell", bundle: nil)
            self.tableView.register(settingsCell, forCellReuseIdentifier: "SettingsCell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell {
                cell.settingLabel.text = "Haptic feedback"
                cell.callbackOnSettingSwitchButton = { [weak self] in
                    self?.hapticFeedbackSwitchAction(cell: cell)
                }
                return viewModel.setupHapticFeedbackCell(in: tableView, with: cell, at: indexPath)
            }}
        return UITableViewCell()
        
    }
    func appearanceMenuAction(for cell: SettingsPopUpButtonTableViewCell, with mode: UIUserInterfaceStyle) {
        /* TODO: - Save users settings in user defaults. */
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        
        switch mode {
        case .light:
            window?.overrideUserInterfaceStyle = .light
        case .dark:
            window?.overrideUserInterfaceStyle = .dark
        default:
            window?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    func hapticFeedbackSwitchAction(cell: SettingsCell) {
        print("haptic on/off")
    }
}
