import UIKit
import AllCollectionFeature

class AllCollectionCoordinator: BaseCoordinator {

    init(navigation: UINavigationController) {
        super.init()
        self.navigationController = navigation
    }

    override func start() {
        // Is the module around?
        let feature = AllCollectionFeatureFactory().create()
//        homeModule.showRequest = self.showRequest(action:)
        if let viewController = feature.viewController() {
            navigationController?.pushViewController(viewController, animated: false)
        }
    }

//    private func showRequest(action: String) {
//
//        if let vc = Feature(rawValue: action)?.moduleVC() {
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}
