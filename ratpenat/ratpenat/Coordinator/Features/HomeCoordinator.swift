import UIKit
import HomeFeature

class HomeCoordinator: BaseCoordinator {
        
    init(navigation: UINavigationController) {
        super.init()
        self.navigationController = navigation
    }
    
    override func start() {
        // Is the module around?
        let feature = HomeFeatureFactory().create()
//        homeModule.showRequest = self.showRequest(action:)
        navigationController?.pushViewController(feature.viewController(), animated: false)
    }
    
//    private func showRequest(action: String) {
//        
//        if let vc = Feature(rawValue: action)?.moduleVC() {
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}
