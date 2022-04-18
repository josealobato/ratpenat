import UIKit
import FoundationToolkit

public struct AllCollectionFeature {
    private let internalVC: AllCollectionVC

    init(viewController: AllCollectionVC) {
        self.internalVC = viewController
    }
}

// MARK: - Interface implementation

extension AllCollectionFeature: AllCollectionFeatureViewInterface {

    public func view() -> UIView { internalVC.view }

    public func viewController() -> UIViewController? { internalVC }
}

extension AllCollectionFeature: AllCollectionFeatureLogicInterface {

}

// MARK: - Action implementation

extension AllCollectionFeature: ActionRequester {
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
