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
            return cell
        }
        return UITableViewCell()
    }
    private func registerTableViewCells() {
        let settingsCell = UINib(nibName: "SettingsCell", bundle: nil)
        self.tableView.register(settingsCell, forCellReuseIdentifier: "SettingsCell")
    }
}


// TODO: - Darkmode, background color settings.
