import Foundation
import UIKit

class SettingsCell: UITableViewCell {
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    var callbackOnSettingSwitchButton : (()->())?
    static let reuseIdentifier = "SettingsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func settingsSwitchButtonAction(_ sender: UISwitch) {
        self.callbackOnSettingSwitchButton?()
    }
}
