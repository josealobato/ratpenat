import UIKit
import HomeFeature

class HomeCoordinator: BaseCoordinator {

    init(navigation: UINavigationController) {
        super.init()
        self.navigationController = navigation
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    override func start() {
        var feature = HomeFeatureFactory().create()
        // The the action callback.
        feature.actionRequest = self.actionRequest(action:)
        if let viewController = feature.viewController() {
            navigationController?.pushViewController(viewController, animated: false)
        }
    }

    // The action request will be called when the Feature request some action.
    private func actionRequest(action: String) {
//        if let vc = Feature(rawValue: action)?.vc() {
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
