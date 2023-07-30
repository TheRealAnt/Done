import UIKit

extension UIViewController {
    #warning("TODO: - Navigation bar style is inconsistent on Home vs. Category view")
    func configureNavigationBar(largeTitleColor: UIColor,
                                backgoundColor: UIColor,
                                tintColor: UIColor,
                                title: String,
                                preferredLargeTitle: Bool) {
        guard let navigationBar = navigationController?.navigationBar else {
            fatalError("navigation controller does not exist")
        }
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationBar.isTranslucent = false
        navigationBar.tintColor = tintColor
        navigationItem.title = title
    }
}
