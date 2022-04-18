import UIKit
import FoundationToolkit

public struct HomeFeature {
    private let internalVC: HomeVC

    init(viewController: HomeVC) {
        self.internalVC = viewController
    }
}

// MARK: - Interface implementation

extension HomeFeature: HomeFeatureViewInterface {

    public func view() -> UIView { internalVC.view }

    public func viewController() -> UIViewController? { internalVC }
}

extension HomeFeature: HomeFeatureLogicInterface {

}

// MARK: - Action implementation

extension HomeFeature: ActionRequester {
    public var actionRequest: ActionRequest {
        get {
//            self.internalVC.showRequest ?? { _ in }
            { _ in }
        }
        // swiftlint:disable:next unused_setter_value
        set(newValue) {
//            self.internalVC.showRequest = newValue
        }
    }
}
