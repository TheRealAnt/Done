import UIKit

protocol HandleUserInterfaceStyleSwitching {
    func setUserInterface(style: UIUserInterfaceStyle)
}

extension HandleUserInterfaceStyleSwitching {
    func setUserInterfaceStyle(to style: UIUserInterfaceStyle) {
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        switch style {
        case .light:
            window?.overrideUserInterfaceStyle = .light
        case .dark:
            window?.overrideUserInterfaceStyle = .dark
        default:
            window?.overrideUserInterfaceStyle = .unspecified
        }
    }
}
