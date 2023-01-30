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
        registerCell(on: self.tableView, with: SettingsCell.reuseIdentifier)
        registerCell(on: self.tableView, with: SettingsPopUpButtonTableViewCell.reuseIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Settings"
    }
}

extension SettingsTableViewController: HandleUserInterfaceStyleSwitching {
    func setUserInterface(style: UIUserInterfaceStyle) {}
    
    func registerCell(on tableView: UITableView,
                      with reuseIdentifier: String,
                      bundle: Bundle? = nil) {
        let cell = UINib(nibName: reuseIdentifier, bundle: bundle)
        tableView.register(cell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    // MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexRow = indexPath.row
        if indexRow == 0 {
            return configureSettingsPopUpButtonCell(on: tableView,
                                                    for: indexPath,
                                                    with: SettingsPopUpButtonTableViewCell.reuseIdentifier)
        } else if indexRow == 1 {
            return configureSettingsCell(on: tableView,
                                         for: indexPath,
                                         with: SettingsCell.reuseIdentifier)
        }
        return UITableViewCell()
    }
    
    func hapticFeedbackSwitchAction(cell: SettingsCell) {
        print("haptic on/off")
    }
}

extension SettingsTableViewController {
    func configureSettingsPopUpButtonCell(on tableView: UITableView,
                                          for indexPath: IndexPath,
                                          with reuseIdentifier: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsPopUpButtonTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? SettingsPopUpButtonTableViewCell else {
            return UITableViewCell()
        }
        let usersItem = UIAction(title: "Auto", image: UIImage(systemName: "person.fill")) { _ in
            self.setUserInterfaceStyle(to: .unspecified)
        }
        let addUserItem = UIAction(title: "Dark", image: UIImage(systemName: "person.badge.plus")) { _ in
            self.setUserInterfaceStyle(to: .dark)
        }
        let removeUserItem = UIAction(title: "Light", image: UIImage(systemName: "person.fill.xmark.rtl")) { _ in
            self.setUserInterfaceStyle(to: .light)
        }
        let menu = UIMenu(title: "Appearance menu",
                          options: .displayInline,
                          children: [usersItem, addUserItem, removeUserItem])
        cell.settingsPopUpButton.menu = menu
        cell.settingsPopUpButton.showsMenuAsPrimaryAction = true
        return viewModel.setupTableViewCell(in: tableView,
                                            with: cell,
                                            at: indexPath)
    }
    
    func configureSettingsCell(on tableView: UITableView,
                               for indexPath: IndexPath,
                               with reuseIdentifier: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier,
                                                       for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        cell.settingLabel.text = "Haptic feedback"
        cell.callbackOnSettingSwitchButton = { [weak self] in
            self?.hapticFeedbackSwitchAction(cell: cell)
        }
        return viewModel.setupHapticFeedbackCell(in: tableView, with: cell, at: indexPath)
    }
}
