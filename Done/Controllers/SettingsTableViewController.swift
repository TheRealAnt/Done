import Foundation
import UIKit

class SettingsTableViewController: UITableViewController {
    var viewModel = SettingsTableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .singleLine
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell {
            cell.settingLabel.text = "Dark mode"
            cell.callbackOnSettingSwitchButton = { [weak self] in
                self?.darkModeSwitchAction(cell: cell)
            }
            return cell
        }
        return UITableViewCell()
    }
    private func registerTableViewCells() {
        let settingsCell = UINib(nibName: "SettingsCell", bundle: nil)
        self.tableView.register(settingsCell, forCellReuseIdentifier: "SettingsCell")
    }
    
    func darkModeSwitchAction(cell: SettingsCell) {
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        if window?.traitCollection.userInterfaceStyle == .dark {
            window?.overrideUserInterfaceStyle = .light
        } else if window?.overrideUserInterfaceStyle == .light {
            window?.overrideUserInterfaceStyle = .dark
        }
    }
}


// TODO: - Darkmode, background color settings.
