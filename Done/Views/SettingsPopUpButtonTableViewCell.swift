import UIKit

class SettingsPopUpButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsPopUpButton: UIButton!
    @IBOutlet weak var settingsMenu: UICommand!
    @IBOutlet weak var menuItem1: UICommand!
    @IBOutlet weak var menuItem2: UICommand!
    @IBOutlet weak var menuItem3: UICommand!
    static let reuseIdentifier = "SettingsPopUpButtonTableViewCell"
    var callbackOnSettingPopUpButton: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func settingsPopUpButtonAction(_ sender: UIButton) {
        self.callbackOnSettingPopUpButton?()
    }
}
