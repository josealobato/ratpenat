import UIKit
import HomeFeature
import FoundationToolkit

class HomeCoordinator: BaseCoordinator {
        
    init(navigation: UINavigationController) {
        super.init()
        self.navigationController = navigation
    }
    
    override func start() {
        
        var feature = HomeFeatureFactory().create()
        // The the action callback.
        feature.actionRequest = self.actionRequest(action:)
        if let vc = feature.viewController() {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    // The action request will be called when the Feature request some action.
    private func actionRequest(action: String) {
        
//        if let vc = Feature(rawValue: action)?.vc() {
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
