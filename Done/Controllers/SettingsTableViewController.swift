import Foundation
import UIKit

// swiftlint:disable trailing_whitespace
class SettingsTableViewController: UITableViewController {
    var viewModel = SettingsTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .singleLine
        self.tableView.dataSource = self
        self.tableView.delegate = self
        viewModel.setupTableViewWithSettings()
        registerCell(on: self.tableView, with: SettingsCell.reuseIdentifier)
        registerCell(on: self.tableView, with: SettingsPopUpButtonTableViewCell.reuseIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Settings"
    }
}

extension SettingsTableViewController {
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
        
        switch indexPath.row {
        case SettingItemType.appearance.rawValue: return configureSettingsPopUpButtonCell(on: tableView,
                                                                                          for: indexPath,
                                                                                          with: SettingsPopUpButtonTableViewCell.reuseIdentifier)
        case SettingItemType.hapticFeedback.rawValue: return configureSettingsCell(on: tableView,
                                                                                   for: indexPath,
                                                                                   with: SettingsCell.reuseIdentifier)
        default:
            return UITableViewCell()
        }
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
        
        let unspecifiedStyleItem = UIAction(title: viewModel.autoTitle,
                                            image: UIImage(systemName: "person.fill")) { [weak self] _ in
            self?.viewModel.setUserInterfaceStyle(to: .unspecified)
        }
        let darkStyleItem = UIAction(title: viewModel.darkTitle,
                                     image: UIImage(systemName: "person.badge.plus")) { [weak self] _ in
            self?.viewModel.setUserInterfaceStyle(to: .dark)
        }
        let lightStyleItem = UIAction(title: viewModel.lightTitle,
                                      image: UIImage(systemName: "person.fill.xmark.rtl")) { [weak self] _ in
            self?.viewModel.setUserInterfaceStyle(to: .light)
        }
        
        cell.settingsPopUpButton.menu = UIMenu(title: viewModel.appearanceMenuTitle,
                                               options: .displayInline,
                                               children: [unspecifiedStyleItem,
                                                          darkStyleItem,
                                                          lightStyleItem])
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
        cell.callbackOnSettingSwitchButton = { [weak self] in
            self?.hapticFeedbackSwitchAction(cell: cell)
        }
        return viewModel.setupHapticFeedbackCell(in: tableView, with: cell, at: indexPath)
    }
}
